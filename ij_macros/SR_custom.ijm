// "SR_custom"

// 0. Set image parameters
var args = split(getArgument(),",");
var out_dir = args[0];
var light_factor = args[1]; //light stainings 0.95, dark 1.3
id = getImageID();
title = getTitle();
path = getDirectory("image");
new_title=out_dir+title+"_SRthresholded";
tissue_title=out_dir+title+"_tissue";
rgb_path=out_dir+title+"_RGB";
print(parseFloat(light_factor))

// 1. Make an RGB stack to measure the tissue in the blue channel (captures tissue area best)
// METHOD A
// We are using a pre-saved RGB stack(saved by script thresholding as _artifact_cealred
setSlice(3);	//(2)
setAutoThreshold("Default stack"); //Mean");//Default stack //Default Percentile
getThreshold(min, max);
yellow_factor = max;
run("Create Selection");
run("Set Measurements...", "area area_fraction limit display redirect=None decimal=3");
run("Measure");
setResult("Label", nResults-1, "tissue")
updateResults();
run("Select None");
saveAs("Jpeg", tissue_title);
close();
// Set the sirius red threshold and measure, add a label to the measurements
open(out_dir+title);
// As mentioned, the file is already RGB

setSlice(2);
setAutoThreshold("Default stack");
getThreshold(min, max);
setThreshold(min, max/parseFloat(light_factor));
run("Measure")
setResult("Label", nResults-1, "sirius_red")
updateResults();

// Save the results
selectWindow("Results");
saveAs("Measurements", out_dir+"Results_"+title+".csv");
saveAs("Jpeg", new_title);
print("Sirius Red quantification complete for image",title);
close();
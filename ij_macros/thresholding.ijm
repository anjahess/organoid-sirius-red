// "thresholding"
var args=split(getArgument(),",");
var out_dir=args[0];
var light_factor=args[1];
title=getTitle();
path=getDirectory("image")+title;
print(out_dir);
print(light_factor);
// This measurement is special for lumen thresholding
call("Versatile_Wand_Tool.doWand", 6, 8, 0.0, 0.0, 0.0, "8-connected");
run("Make Inverse");
run("Measure");
run("Select None");

min=newArray(3);
max=newArray(3);
filter=newArray(3);

// Create BW artifact threashold

// 1. Make an RGB stack to measure artifacts in the first channel
run("RGB Stack");
setSlice(1);
setAutoThreshold();//Default stack
run("Create Selection");
run("Clear", "slice");
setSlice(2);
run("Clear", "slice");
setSlice(3)
run("Clear", "slice");
run("Select None");
//Save the transformed image
out_path=getDirectory("image");
new_title=out_dir+title+"_artifact_cleared"
saveAs("Tiff", new_title);
print("Saved artifact cleared image here:", new_title);
runMacro("SR_custom", out_dir+","+light_factor);
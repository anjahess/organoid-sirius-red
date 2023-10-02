// This macro processes all the images in a folder and any subfolders.
  extension = ".tif";
  var args=split(getArgument(),",");
  var run_dir=args[0];
  var thresh=args[1];
  var input_format = "organoid_ROIs";
  print(input_format);
  var dir1 = run_dir+"/input/"+input_format+"/";	
  var out_dir = run_dir+"/results/"+input_format+"/";
  setBatchMode(true);
  n = 0;
  processFolder(dir1);
  print(dir1)
  function processFolder(dir1) {
     list = getFileList(dir1);
     for (i=0; i<list.length; i++) {
          if (endsWith(list[i], "/"))
              processFolder(dir1+list[i]);
          else if (endsWith(list[i], extension))
             processImage(dir1, list[i]);
      }
  }
  function processImage(dir1, name_img) {
  	print("folder", dir1+name_img);
     print("opening", name_img);
     open(dir1+name_img);
     runMacro("thresholding", out_dir+","+thresh);
     // add code here to analyze or process the image
     //saveAs(extension, dir2+name);
  }
print("Sirius Red Quanti for all images done.");
selectWindow("Results");
saveAs("Measurements", out_dir+"results.csv");
run("Quit");

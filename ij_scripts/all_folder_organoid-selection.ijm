// This macro processes all the images in a folder and any subfolders.
  extension = ".tif";
  var args=split(getArgument(),",");
  var run_dir=args[0];
  var thresh=args[1];
  dir1 = run_dir+"/input/whole_slide/";
  print(dir1);
  out_dir = run_dir+"/input/organoid_ROIs/";
  setBatchMode(false);  //CRITICAL OTHERWISE YOU WILL NOT SEE IMAGES
  n = 0;
  processFolder(dir1);
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
     print("opening", name_img);
     open(dir1+name_img);
     runMacro("select_organoid_rectangle_from_200umbar", out_dir);  
  }
print("Organoid ROI selection for all images of", run_dir, " done.");
beep();
run("Quit");

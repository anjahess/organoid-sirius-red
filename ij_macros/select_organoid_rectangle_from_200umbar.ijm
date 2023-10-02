// To save the generated tif.
var args = split(getArgument(),",");
var out_dir = args[0];
id = getImageID();
name = getTitle();
path = getDirectory("image");
selectImage(id);
run("Set Scale...", "distance=184.0109 known=200 unit=µm");
makeRectangle(300,300, 300, 300);
beep();
beep();
beep();
run("Wait For User", "Select rectangle around a single organoid. Leave space in the lower left for a scale bar.");
if (selectionType() == 0)  {
      run("Crop");
      run("Scale Bar...", "width=100 height=3 font=10 color=White background=None location=[Lower Left] bold overlay");
      print("Applied scalebar.");
      dotIndex = indexOf(name, ".");
      prefix = substring(name, 0, dotIndex);
      new_title = out_dir+prefix+id+"_square.tif";
      saveAs("Tiff", new_title);
      print("Opening original for further organoid selection.", path+name);
      open(path+name); // continue to edit the original
      runMacro("select_organoid_rectangle_from_200umbar", out_dir);
   } else {
      print("Skipping image", id);
      close();
   }


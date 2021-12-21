Directory = getDirectory("Choose the folder containing Images");
Images = getFileList(Directory);
NumImages = Images.length;
for (t = 0; t < NumImages; t += 1) {
	CurrentImage = Images[t];
	//file = File.openAsString(Path);
	open(Directory + CurrentImage);
	CurrentImageID = getImageID();
	selectImage(CurrentImageID);
	Stack.setChannel(4)
	setOption("ScaleConversions", true);
	run("8-bit");
	run("Grays");
	run("Subtract Background...", "rolling=10");
	run("Gaussian Blur...", "sigma=0.3 scaled");
	run("adaptiveThr ", "using=Mean from=557 then=-2");
	//run("adaptiveThr ", "using=Mean from=1201 then=-5");
	//557 and -2 for Epi
	run("Despeckle", "slice");
	run("Watershed", "slice");
	//setOption("BlackBackground", true);
	//run("Erode");	 			Erode function not used for new centroid detection
	run("Analyze Particles...", "size=10-Infinity circularity=0.40-1.00 show=[Count Masks] display clear add slice");
	//selectWindow("Count Masks of Epidermis.tif");
	run("Find Maxima...", "prominence=10 output=[Single Points]");
	selectWindow("Results");
	saveAs("text", Directory + "Results for " + CurrentImage + ".csv");
}

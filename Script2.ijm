Directory = getDirectory("Choose a Directory with Results");
ImageDirectory = getDirectory("Choose a Directory with Images");
ResultsList = getFileList(Directory);
Array.sort(ResultsList);
ImagesList = getFileList(ImageDirectory);
Array.sort(ImagesList);
NumResults = ResultsList.length;
NumImages = ImagesList.length;
//PathsFile = File.openAsString("C:/Users/chenc/Desktop/List of Paths.txt/");
//PathList = split(PathsFile, "\n");
//a = PathList.length;
for (t = 0; t < NumResults; t += 1) {
	CurrentResult = ResultsList[t];
	CurrentImage = ImagesList[t];
	//fixed upto here
	file = File.openAsString(Directory + CurrentResult);
	open(Directory + CurrentResult);
	open(ImageDirectory + CurrentImage);
	xdimension = getWidth();
	ydimension = getHeight();
	//name = getResult("Label", t)
	//counter = t;
	newImage("Circles for " + CurrentResult, "8-bit black", xdimension, ydimension, 1);
	ImageID = getImageID();
//	file = File.openAsString("C:/Users/chenc/Desktop/Results.csv/");
	rows = split(file, "\n");
	lengthofrows = rows.length;
	for (i = 0; i < lengthofrows - 1; i += 1) {
		//print(rows[i]);
		entry = split(rows[i], ",");
		//Array.print(entry);
		//b = entry.length;
		//for (v = 0; v < b; v += 1) {
		selectWindow(CurrentResult);
		X = getResult("X", i);
		Y = getResult("Y", i);
		c = newArray(X, Y);
		print(c[0]);
		print(c[1]);
		c0 = (parseFloat(c[0]) - 5) * 2.5 ;	//2.5 is units for conversion make sure units are in pixels 
		c1 = (parseFloat(c[1]) - 5) * 2.5;
		coordinates = newArray(c0, c1);
		//Array.print(coordinates);
		selectImage(ImageID);
		makeOval(c0, c1, 25, 25);
		run("Add...", "value=255");
		//run("Watershed");
	//	roiManager("Add");
	}
	run("Watershed");
	selectImage(ImageID);
	saveAs("tiff", Directory + "Circles for " + CurrentResult + ".tiff");
	close();
	selectWindow(CurrentResult);
	run("Close");
}

//saveAs("Tiff", "C:/Users/chenc/Desktop/Untitled.tif");
//selectImage(-7)
//run("Save XY Coordinates...")//
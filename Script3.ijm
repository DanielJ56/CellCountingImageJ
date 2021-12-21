CirclesDirectory = getDirectory("Choose a Directory with Circles");
ImageDirectory = getDirectory("Choose a Directory with Images");
CirclesList = getFileList(CirclesDirectory);
Array.sort(CirclesList);
ImagesList = getFileList(ImageDirectory);
Array.sort(ImagesList);
NumCirc = CirclesList.length;
NumImages = ImagesList.length;
for (t = 0; t < NumCirc; t += 1) {
	CurrentCircle = CirclesList[t];
	open(CirclesDirectory + CurrentCircle);
	CircleID = getImageID();
	CurrentImage = ImagesList[t];
	open(ImageDirectory + CurrentImage);
	ImageID = getImageID();
	selectImage(CircleID);
	run("Convert to Mask");
	run("Analyze Particles...", "  show=Overlay display clear add");
	selectWindow("Results");
	run("Close");
	selectImage(ImageID);
	for (n = 1; n < 5; n += 1) {
		Stack.setChannel(n);
		run("Subtract Background...", "rolling=10 slice");
		roiManager("multi-measure append");	
	}
	selectWindow("Results");
	saveAs("text", ImageDirectory + "Means for " + CurrentImage + ".csv");
	selectWindow("Results");
	run("Close");
	selectImage(CircleID);
	close();
	selectImage(ImageID);
	close();
}

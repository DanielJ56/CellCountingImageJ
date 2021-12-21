MeanDirectory = getDirectory("Choose a Directory with Means");
ThresholdCCR5 = getNumber("Enter Threshold for CCR5", 50);
ThresholdCD4 = getNumber("Enter Threshold for CD4", 20);
ThresholdCD3 = getNumber("Enter Threshold for CD3", 80);
MeanFileList = getFileList(MeanDirectory);
NumFiles = MeanFileList.length;
CCR5 = false;
CD4 = false;
CD3 = false;
for (t = 0; t < NumFiles; t += 1) {
	CCR5CD4counter = 0 ;
	CCR5CD4CD3counter = 0;
	CD4CD3counter = 0;
	CCR5CD3counter = 0;
	CCR5counter = 0;
	CD3counter = 0 ;
	CD4counter = 0;
	CurrentMeanFile = MeanFileList[t];
	file = File.openAsString(MeanDirectory + CurrentMeanFile);
	open(MeanDirectory + CurrentMeanFile);
	rows = split(file, "\n");
	NumMeans = rows.length - 1;
	selectWindow(CurrentMeanFile);
	//LastLabel = getResult("Label", t);
	CCR5channel = parseInt(NumMeans) / 4;
	CD4channel = CCR5channel * 2;
	//CD3channel = CCR5channel * 3;
	for (n = 0; n < CCR5channel; n += 1) {
		selectWindow(CurrentMeanFile);
		//MeanCD4 = getResult("Mean", 14000);
		MeanCCR5 = getResult("Mean", n);
		PosCD4 = n + CCR5channel;
		PosCD3 = n + CD4channel;
		selectWindow(CurrentMeanFile);
		MeanCD4 = getResult("Mean", PosCD4);
		selectWindow(CurrentMeanFile);
		MeanCD3 = getResult("Mean", PosCD3);
		if (MeanCCR5 >= ThresholdCCR5) {
			CCR5 = true;
			
		}
		if (MeanCD4 >= ThresholdCD4) {
			CD4 = true;
		}
		if (MeanCD3 >= ThresholdCD3) {
			CD3 = true;
		}
		if (CCR5 == true && CD3 == false && CD4 == false) {
			CCR5counter += 1;
		}
		if (CCR5 == false && CD3 == true && CD4 == false) {
			CD3counter += 1;
		} 
		if (CCR5 == false && CD3 == false && CD4 == true) {
			CD4counter += 1;
		}
		if (CCR5 == true && CD3 == true && CD4 == false) {
			CCR5CD3counter += 1;
		} 
		if (CCR5 == false && CD3 == true && CD4 == true) {
			CD4CD3counter += 1;
		}
		if (CCR5 == true && CD3 == false && CD4 == true) {
			CCR5CD4counter += 1;
		} 
		if (CCR5 == true && CD3 == true && CD4 == true) {
			CCR5CD4CD3counter += 1;
		}
		CCR5 = false;
		CD3 = false;
		CD4 = false;
	}
	Table.create("Results");
	setResult("Counts", 0, " Count of CCR5 Only Cells: " + CCR5counter);
	setResult("Counts", 1,  " Count of CD3 Only Cells: " + CD3counter);
	setResult("Counts", 2, " Count of CD4 Only Cells: " + CD4counter);
	setResult("Counts", 3, " Count of CCR5CD4 Only Cells: " + CCR5CD4counter);
	setResult("Counts", 4, " Count of CCR5CD3 Only Cells: " + CCR5CD3counter);
	setResult("Counts", 5, " Count of CD4CD3 Only Cells: " + CD4CD3counter);
	setResult("Counts", 6, " Count of CCR5CD4CD3 Cells: " + CCR5CD4CD3counter);
	selectWindow("Results");
	saveAs("text", MeanDirectory + "Counts for " + CurrentMeanFile + ".csv");
	run("Close");
	selectWindow(CurrentMeanFile);
	run("Close");
}
print("Script Complete");
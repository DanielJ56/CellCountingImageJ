# CellCountingImageJ

This series of ImageJ scripts takes in a 4 channel immunofluorescent stain image and identifies the counts for the various combinationsof cells in the image. 

## Script 1
- Converts image to binary, performs functions to improve maxima identification and determines local maxima, identifying cells and obtaining coordinates
## Script 2
- Draws circles around each maxima, representing the cell while performing operations to improve cell drawing. 
## Script 3
- Measures pixel intensity inside each cell
## Script 4
- Given a threshold intensity, filters out mean intensity values that don't meet threshold within the area of each cell, determining the marker combinations appropriate for each cell and provides counts. 

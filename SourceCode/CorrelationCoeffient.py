
#!/usr/bin/python
import sys
import statistics
import math
import csv

def correlation(dataset1, dataset2):
	orderedPairs = len(dataset1)
	summationValues = []
	dataset1Squared = []
	dataset2Squared = []
	# Get the a dataset of sums between both datasets Ex) c = a*b
	for a,b in zip(dataset1,dataset2):
		x = a*b
		summationValues.append(x)
	# Get a dataset of all squares in dataset1
	for a in dataset1:
		x = math.pow(a,2)
		dataset1Squared.append(x)
		# Get a dataset of all squares in dataset2
	for b in dataset2:
		x = math.pow(b,2)
		dataset2Squared.append(x)
	sumSV = sum(summationValues)
	sumData1 = sum(dataset1)
	sumData2 = sum(dataset2)
	sumData1Squared = sum(dataset1Squared)
	sumData2Squared = sum(dataset2Squared)
	# Calculate correlation coeffient 
	cc = ((orderedPairs * sumSV) - (sumData1 * sumData2)) / math.sqrt((orderedPairs*sumData1Squared - math.pow(sumData1,2)) * (orderedPairs*sumData2Squared - math.pow(sumData2,2)))
	print("Correlation Coefficient is:" + str(cc))
	
def main():
	# Get the  line arguments
	filename1 = str(sys.argv[1])
	attribute1 = int(sys.argv[2])
	filename2 = str(sys.argv[3])

	# Open the file, put the first file into a dataset based off the given attribute
	with open(filename1, 'rb') as csvfile:
		att_dataset = []
		reader = csv.reader(csvfile)
		for row in reader:
			x = float(row[attribute1])
			att_dataset.append(x)
  attribute2 = int(sys.argv[4])
  # second file open and read
  with open(filename2, 'rb') as csvfile2:
    att_dataset2 = []
    reader = csv.reader(csvfile2)
    for row in reader:
      x = float(row[attribute2])
      att_dataset2.append(x)
  correlation(att_dataset, att_dataset2)
main()

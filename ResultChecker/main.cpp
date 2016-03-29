#include <vector>
#include <string>
#include <iostream>
#include <cmath>

#include "fileReader.h"

using std::vector;
using std::string;
using std::endl;
using std::cout;
using std::fabs;

int main(int argc, char *argv[]) {
	if (argc != 3) {
		cout << "Usage: ./check file1.txt file2.txt" << endl;
	}

	vector<double> data1; // my output data vector
	vector<double> data2; // test output data vector.

	fileReader file; // instantiate a readFile object.
	if (!file.getData(argv[1], data1) || !file.getData(argv[2], data2)) {
		return -1;
	}

	double acceptable_difference = 0.01;

	// go throught both vectors and check each element.
	for (unsigned int i = 0; i < data2.size(); i++) {
		if (fabs(data1[i] - data2[i]) > acceptable_difference) {
			return -1;
		}
	}

	return 0;
}

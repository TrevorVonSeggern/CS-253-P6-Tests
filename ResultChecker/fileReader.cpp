#include "fileReader.h"

bool fileReader::getData(const string fileName, vector<double> &result) const {
	ifstream file;
	string line;
	file.open(fileName);

	if(!file.is_open()) {
		cerr << "Error: File does not exist [" << fileName << "]" << endl;
		return false;
	}

	int line_number = 0;

	while (getline(file, line)) {

		stringstream in_stream(line);
		double temp_value = 0;

		// add all numbers to data vector.
		while (in_stream >> temp_value || !in_stream.eof()) {

			// test for something that is not a number.
			if (in_stream.fail()) {
				return false;
			}
			result.push_back(temp_value); // add the coordinate into the vector.
		}

		// check for empty lines.
		if ((line.empty()) && !(in_stream.eof())) {
			cerr << "Error: line " << line_number << " is empty." << endl;
			return false;
		}
	}
	return true;
}

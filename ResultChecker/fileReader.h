#ifndef FILEREADER_H_INCLUDE
#define FILEREADER_H_INCLUDE

#include <fstream>
#include <iostream>
#include <vector>
#include <string>
#include <sstream>

using std::vector;
using std::string;
using std::ifstream;
using std::stringstream;
using std::cout;
using std::cerr;
using std::endl;

class fileReader {
public:
	bool getData(const string fileName, vector<double> &result) const;
};


#endif // FILEREADER_H_INCLUDE

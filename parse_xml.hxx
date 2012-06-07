#ifndef FGDO_UTIL_HPP
#define FGDO_UTIL_HPP

#include <iostream>
#include <string>
#include <vector>

#include "stdint.h"

#include "vector_io.hxx"

using namespace std;

const char *FGDO_UTIL_ERRORS[] = { "success", "XML tag not found" };

template <class T>
T parse_xml(string xml, const char tag[]) throw (string) {
    string start_tag("<");
    start_tag.append(tag);
    start_tag.append(">");

    string end_tag("</");
    end_tag.append(tag);
    end_tag.append(">");

    int start = xml.find(start_tag, 0) + start_tag.size();
    int end = xml.find(end_tag, 0);
    int length = end - start;

    if (length > 0) {
//        cout << "parsing: " << tag << " from '" << xml.substr(start, length) << "'" << endl;

        istringstream data( xml.substr(start, length) );
        T value;
        data >> value;

        return value;
    } else {
        ostringstream oss;
        oss << "Tag '" << tag << "' was not found, find(" << start_tag << ") returned " << start << ", find(" << end_tag << ") returned " << end << ", error in file [" << __FILE__ << "] on line [" << __LINE__ << "]" << endl;
        throw oss.str();
    }
}

template <>
string parse_xml<string>(string xml, const char tag[]) throw (string) {
    string start_tag("<");
    start_tag.append(tag);
    start_tag.append(">");

    string end_tag("</");
    end_tag.append(tag);
    end_tag.append(">");

    int start = xml.find(start_tag, 0) + start_tag.size();
    int end = xml.find(end_tag, 0);
    int length = end - start;

    if (length > 0) {
//        cout << "parsing: " << tag << " from '" << xml.substr(start, length) << "'" << endl;

        return xml.substr(start, length);
    } else if (length == 0) {
        return string();
    } else {
        ostringstream oss;
        oss << "Tag '" << tag << "' was not found, find(" << start_tag << ") returned " << start << ", find(" << end_tag << ") returned " << end << ", error in file [" << __FILE__ << "] on line [" << __LINE__ << "]" << endl;
        throw oss.str();
    }
}

template <class T>
void parse_xml_vector(string xml, const char tag[], vector<T> &result) throw (string) {
    string start_tag("<");
    start_tag.append(tag);
    start_tag.append(">");

    string end_tag("</");
    end_tag.append(tag);
    end_tag.append(">");

    int start = xml.find(start_tag, 0) + start_tag.size();
    int end = xml.find(end_tag, 0);
    int length = end - start;

    if (length > 0) {
        string_to_vector(xml.substr(start, length), result);
        return;
    } else if (length == 0) {
        return;
    } else {
        ostringstream oss;
        oss << "Tag '" << tag << "' was not found, find(" << start_tag << ") returned " << start << ", find(" << end_tag << ") returned " << end << ", error in file [" << __FILE__ << "] on line [" << __LINE__ << "]" << endl;
        throw oss.str();
    }
}

#endif

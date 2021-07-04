#include <iostream>
#include <set>
#include <string>

using namespace std;

const set <char> letters{ 'a','b','c','d','e','f','g','h',
                          'i','j','k','l','m','n','o','p',
                          'q','r','s','t','u','v','w','x',
                          'y','z','_','A','B','C','D','E',
                          'F','G','H','I','J','K','L','M',
                          'N','O','P','Q','R','S','T','U',
                          'V','W','X','Y','Z'};
const set <char> nums{ '0','1','2','3','4','5','6','7','8','9' };
const set <string> types { "char", "integer" };
const set <char> signs{ '-','+' };

bool checkConst(string str)
{
    if (str.compare(0, 6, "const ") == 0)
        return true;
    else
        return false;
}

bool checkID(string str)
{
    const int states[2][3] = { {1, -1, -1}, {1, 1, -1} };
    int curState = 0, signal = 0;
    while ((curState != -1) && (str.size() != 0))
    {
        if (letters.count(str[0]) != 0)
            signal = 0;
        else
            if (nums.count(str[0]) != 0)
                signal = 1;
            else
                signal = 2;
        curState = states[curState][signal];
        str = str.substr(1);
    }
    if (curState == -1)
        return false;
    else
        return true;
}

bool checkRecord(string str)
{
    if (str.compare(0, 8, ":record ") == 0)
        return true;
    else
        return false;
}

bool checkIDs(string str)
{
    string ID;
    int pos;
    while (str != "")
    {
        pos = str.find(',');
        if (pos != string::npos)
        {
            ID = str.substr(0, pos);
            str = str.substr(pos + 1);
        }
        else
        {
            ID = str;
            str = "";
        }
        if (!checkID(ID))
        {
            cout << ID << " is wrong ID" << endl << endl;
            return false;
        }
    }
    return true;
}

bool checkType(string str)
{
    if (types.count(str) != 0)
        return true;
    else
        return false;
}

bool checkField(string str)
{
    int pos = str.find(':');
    if (pos != string::npos)
    {
        string IDs = str.substr(0, pos);
        if (checkIDs(IDs))
        {
            cout << IDs << " is(are) fine ID(s)";
            string type = str.substr(pos + 1);
            if (checkType(type))
            {
                cout << " of " << type << " type" << endl << endl;
                return true;
            }
            else
            {
                cout << ", but " << type << " is not correct type" << endl << endl;
                return false;
            }
        }
        else
            return false;
    }
    else
        return false;
}

bool checkFields(string str)
{
    int pos;
    string field;
    while (str != "")
    {
        pos = str.find(';');
        if (pos != string::npos)
        {
            field = str.substr(0, pos);
            str = str.substr(pos + 2);
        }
        else
        {
            field = str;
            str = "";
        }
        if (!checkField(field))
            return false;
    }
    return true;
}

bool checkChar(char ch)
{
    if ((letters.count(ch) != 0) || (nums.count(ch) != 0))
        return true;
    else
        return false;
}

bool checkNum(string str)
{
    const int states[2][3] = { {1, 1, -1}, {-1, 1, -1} };
    int curState = 0, signal = 0;
    while ((curState != -1) && (str.size() != 0))
    {
        if (signs.count(str[0]) != 0)
            signal = 0;
        else
            if (nums.count(str[0]) != 0)
                signal = 1;
            else
                signal = 2;
        curState = states[curState][signal];
        str = str.substr(1);
    }
    if (curState == -1)
        return false;
    else
        return true;
}

bool checkValue(string str)
{
    if (str[0] == '\'')
    {
        if ((str[2] == '\'') && (checkChar(str[1])) && (str.size() == 3))
            return true;
        else
        {
            return false;
        }
    }
    else
        if (checkNum(str))
            return true;
        else
            return false;
}

bool checkParam(string str)
{
    int pos = str.find(':');
    if (pos != string::npos)
    {
        string ID = str.substr(0, pos);
        if (checkID(ID))
        {
            cout << ID << " is correct ID";
            string value = str.substr(pos + 1);
            if (checkValue(value))
            {
                cout << " and " << value << " is correct value" << endl << endl;
                return true;
            }
            else
            {
                cout << ", but " << value << " is wrong value" << endl<< endl;
                return false;
            }
        }
        else
        {
            cout << ID << " is wrong ID" << endl << endl;
            return false;
        }
    }
    else
        return false;
}

bool checkParams(string str)
{
    int pos;
    string param;
    while (str != "")
    {
        pos = str.find(',');
        if (pos != string::npos)
        {
            param = str.substr(0, pos);
            str = str.substr(pos + 1);
        }
        else
        {
            param = str;
            str = "";
        }
        if (!checkParam(param))
            return false;
    }
    return true;
}

int main()
{
    string input;
    getline(cin, input);
    cout << endl;
    if (checkConst(input))
    {
        int pos = input.find(':');
        if (pos != string::npos)
        {
            string someStr = input.substr(6, pos - 6);
            if (checkID(someStr))
            {
                cout << someStr << " is correct ID" << endl << endl;
                input = input.substr(pos);
                if (checkRecord(input))
                {
                    input = input.substr(8);
                    pos = input.find("; end");
                    if (pos != string::npos)
                    {
                        someStr = input.substr(0, pos);
                        if (someStr.size() != 0)
                        {
                            if (checkFields(someStr))
                            {
                                cout << "All fields are okay" << endl << endl;
                                input = input.substr(pos + 5);
                                pos = input.find(" = (");
                                int posHelp = input.find(');');
                                if ((pos != string::npos) && (posHelp != string::npos))
                                {
                                    someStr = input.substr(pos + 4, posHelp - 5);
                                    if (someStr.size() != 0)
                                    {
                                        if (checkParams(someStr))
                                            cout << "All params are okay" << endl << endl << "Everything is fine" << endl;
                                        else
                                            cout << "There is error in params" << endl;
                                    }
                                    else
                                        cout << "There is no params in record" << endl;
                                }
                                else
                                    cout << "There is error in params" << endl;
                            }
                            else
                                cout << "There is an error in fields" << endl;
                        }
                        else
                            cout << "There is no fields in record" << endl;
                    }
                    else
                        cout << "There is no end or semicolon after fields" << endl;
                }
                else
                    cout << "Incorrect record declaration" << endl;
            }
            else
                cout << someStr << " is not correct ID" << endl;
        }
        else
            cout << "There is no record ID" << endl;
    }
    else
        cout << "Incorrect const declaration" << endl;
}
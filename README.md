![](https://img.shields.io/badge/Microverse-blueviolet)

# Ruby - Capstone project: Custom Linter for ruby

This project is built to adapt to programming best practices like a warning for correct indentation, restricting the number of methods per class, number of classes, and modules per file.
-It shows a warning when there is a missing indentation for the class method or loop
-gives warning on an excessive number of classes per file
-gives warning on the excessive number of methods per file 
-like when methods are more than the specified limit

## Built With


- <code><img height="20" src="https://www.ruby-lang.org/images/header-ruby-logo.png"></code> Ruby Language <br>
- ![Git](https://img.shields.io/badge/-Git-05122A?style=flat&logo=git)&nbsp; Git<br>
- ![GitHub](https://img.shields.io/badge/-GitHub-05122A?style=flat&logo=github)&nbsp; GitHub<br>
- ![Visual Studio Code](https://img.shields.io/badge/-Visual%20Studio%20Code-05122A?style=flat&logo=visual-studio-code&logoColor=007ACC)&nbsp; VScode


## Getting Started

**To get a local copy up and running follow these simple steps.**

- `git clone https://github.com/wajahat414/Ruby_capstone_custom_Linter.git`
- `cd Ruby_capstone_custom_Linter`
- Open Ruby file on your editor
- Open your terminal(Command Prompt) and type bin/main.rb

Testing With Rspec
- Test cases have been written carefully to make sure the public methods work as expected
- From the Terminal run the command
$ rspec
### How to use
## Instruction for testing a file containing Ruby Code
-its very simple just copy the file in the Folder name test
-if there are multiple files and directories then also copy them in the test directory
-Now just Run the command Ruby bin/main.rb
-You will get all the Warnings and instructions for improving your code
-BY Default Method limit is 3 per file and the number of allowed classes per file is 1 
-But this limit can be changed 

### Good code example
class any
def playerturn(cell_num, turn)
if cell_num >= 1 && cell_num <= 9 && board[cell_num - 1] == cell_num
board[cell_num - 1] = if turn.zero?
'X'
else
'O'
end
return false
end
end
end
# In this case no warning will be shown

### Bad Code example

class any
def playerturn(cell_num, turn)
if cell_num >= 1 && cell_num <= 9 && board[cell_num - 1] == cell_num
board[cell_num - 1] = if turn.zero?
'X'
else
'O'
end
return false
end
end
end
# Now our application will show a warning that there is no indentation for class and method along with line and filename


### Setup


### Install

-No installation required

## Authors

👤 **Author**


- GitHub: [wajahat akram](https://github.com/wajahat414)
- Twitter: [wajahat akram](https://twitter.com/wajahat414)


## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](https://github.com/wajahat414/HTML-CSS-Capstone-Project/issues).

## Show your support

Give an ⭐️ if you like this project

## Acknowledgments

- Microverse (https://www.microverse.org/)
- The Odin Project (https://www.theodinproject.com/)

## 📝 License

This project is [MIT](/LICENSE) licensed.
# Pascal interpreter written in Swift

Simple Swift interpreter for the Pascal language inspired by the [Let’s Build A Simple Interpreter](https://ruslanspivak.com/lsbasi-part1/) article series.

### What is implemented

* standard types (integer, real, boolean, string)
* arithmetic expressions
* function calls
* procedure calls
* recursion
* loops (for, repet until, while)
* logical conditions (if)
* standard Pascal functions (writeln, write, readln, read, random)
* one-dimensional arrays

There are a few sample Pascal programs in the [Examples directory](Examples), like a simple [number guessing game](Examples/game.pas) and a [factorial computation](Examples/factorial.pas).

## Scructure

### Lexer

The [Lexer](PascalInterpreter/PascalInterpreter/Lexer/Lexer.swift) reads the Pascal program as `String` (a sequence of characters) and converts it into a sequence of [Tokens](PascalInterpreter/PascalInterpreter/Lexer/Token.swift). You can see the result by trying it out in the Playground or on the [unit tests](PascalInterpreter/PascalInterpreterTests/LexerTests.swift).

![Lexer](Images/lexer.png)

### Parser

The [Parser](PascalInterpreter/PascalInterpreter/Parser/Parser.swift) reads the sequence of tokens produced by the Lexer and builds an [Abstract Syntax Tree representation](PascalInterpreter/PascalInterpreter/Parser/AST.swift) (AST for short) of the Pascal program according to the [grammar](grammar.md). 

You can see what the AST looks like in the [unit tests](PascalInterpreter/PascalInterpreterTests/ParserTests.swift) or in the Playground where you can also use the `printTree()` method on any AST to see its visual representation printed into the console.

![Parser](Images/parser.png)

### Semantic analyzer

The [Semantic analyzer](PascalInterpreter/PascalInterpreter/Semantic%20analyzer/SemanticAnalyzer.swift) does static semantic checks on the Pascal program AST. It currently checks if all the used variables are declared beforehand and if there are any duplicate declarations. The result of semantic analysis is a [Symbol table](PascalInterpreter/PascalInterpreter/Semantic%20analyzer/SymbolTable.swift) that holds all the symbols used by a Pascal program, currently built in types (Integer, Real, Boolean, String) and declared variable names. 

Implemented checks

* Check if a variable was declared with a known type (Integer, Real)
* Check if a variable was declared before usage
* Check if variable is not declared more than once
* Check if a procedure was declared
* Check if a procedure is called with the correct number of parameters

### Interpreter

The [Interpreter](PascalInterpreter/PascalInterpreter/Interpreter/Interpreter.swift) reads the AST representing the Pascal program from Parser and interprets it by walking the AST recursively. It can handle basic Pascal programs.

At the end of the Pascal program interpretation you can check the resulting memory state (see [unit tests](PascalInterpreter/PascalInterpreterTests/InterpreterTests.swift)) or print it in the Playground using `printState()`.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

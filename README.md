# Countdown Numbers Game Solver Written in Racket

## Information at a Glance
**Author:** Ross Byrne <br>
**Language:** [Racket](http://racket-lang.org/)  <br>
**Project:** Solve Countdown Numbers Game with Racket <br>
**Project For:** Fourth Year Software Development Module, Theory of Algorithms <br>
**Lecturer:** Ian McLoughlin

## Introduction

As part of my Fourth Year module, Theory of Algorithms, we were asked to solve the countdown numbers game using the Racket functional programming language. One of the main motivations for this project was to gain experience solving a problem that sounds very straight forward but in reality, is not as straight forward as it first appears.

Another learning outcome was learning how to use the functional programming language Racket, which we have never used before. 

## About the Countdown Numbers Game
In the Countdown Numbers game contestants are given six random numbers
and a target number. The target number is a randomly generated three digit
integer between 101 and 999 inclusive. The six random numbers are selected
from the following list of numbers: (1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 25, 50, 75, 100). <br>

Contestants must use the four basic operations: add, subtract, multiply
and divide, with the six random numbers to calculate the target number
if possible. They don’t have to use all six of the numbers, however each of
the six random numbers can only be used once. If the same number appears
twice in the list of six then it may be used twice.

## My Solution

In my solution, when the __main.rkt__ file, which is the main file, is run, the program will solve the problem using the target number: 200 and the list of numbers: (100, 25, 10, 2, 2, 1).

Once that is complete, the user can use the function __solvecount__ and add their our target number and list of 6 numbers. If the target number is not between 101 and 999 or the numbers are not from the available pool of numbers, an error message will be displayed.

# Setup

## Installing Racket
The first thing that is required, is to have Racket installed. Information on how to do this, can be found [here](https://download.racket-lang.org/).

## Running The Project

With Racket installed, navigate to the main folder and open __main.rkt__ in the Racket IDE Dr Racket.

Once the file is open, press f5 to start running it. As stated above, it will automatically solve the problem with the target number: 200 and the list of 6 numbers: (100, 25, 10, 2, 2, 1).
Once the solutions are found, a list of all the solutions are printed to the screen followed by a message informing the user how many solutions were found. This is because 6000 or more solutions can be found depending on the target number and list of 6 numbers selected.

Once the first solution is displayed, the user can use the __solvecount__ function to try a different target number and set of 6 numbers. 

The user can achieve this by typing the following:
```
(solvecount 424 (list 1 2 3 4 5 6))
```
The first parameter is the target number, in this example, 424.<br>
The second parameter is the list of 6 numbers, in this case: (list 1 2 3 4 5 6).

## Program output

The solutions that are returned from the program are in Reverse Polish Notation format. Information on Reverse Polish Notation or RPN, can be found [here](https://en.wikipedia.org/wiki/Reverse_Polish_notation).

An example of what one of the Reverse Polish Notation solutions looks like, is as follows:
```Racket
(100 1 2 2 / + *)
```
This solution evaluates to 200. This can be achieved by doing the following:

2 / 2 = 1 <br>
1 + 1 = 2 <br>
100 * 1 = 200

The last solutions to be printed out will be the solutions with the least amount of numbers used to evaluate to the target number.

If there are no solutions because the target number cannot be reached, an empty list is returned and a message saying there are 0 solutions.

An empty list in Racket looks like the following:
```Racket
'()
```



# What I Learned

# Brief Outline Of How it Works

# Detailed Code & Functionality Walk Through

# References
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



# What I Learned

# Brief Outline Of How it Works

# Detailed Code & Functionality Walk Through

# References
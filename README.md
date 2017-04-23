# Countdown Numbers Game Solver Written in Racket

## Information at a Glance
**Author:** Ross Byrne <br>
**Language:** [Racket](http://racket-lang.org/)  <br>
**Project:** Solve Countdown Numbers Game with Racket <br>
**Project For:** Fourth Year Software Development Module, Theory of Algorithms <br>
**Lecturer:** Ian McLoughlin

## Introduction

As part of my Fourth Year module, Theory of Algorithms, we were asked to solve the countdown numbers game using the Racket functional programming language. One of the main motivations for this project was to gain experience solving a problem that sounds very straight forward but in reality, is not as straight forward as it first appears. Another learning outcome was learning how to use the functional programming language Racket, which we have never used before. 

For anyone interested in looking through my racket code, you will be happy to know that almost every line of code is commented explaining what is happening. There is also a paragraph at the top of every function outlining what the function is doing.

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

### Note
I allocated 5000MB of RAM to racket, to use when running the script. I think 4GBs is probably enough but 5GBs definitely works.

On my laptop, the script only takes about 1 minute to finish executing. I am however using Ubuntu with an i7 CPU, 12GBs of RAM and an SSD. Results may vary.

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
# What I've Learned

I've learned a lot from completing this project but I'll outline the two main take homes for me after finishing the project.

## Planning
The main thing I've learned has been planning. The importance of forward thinking and planning was very clear when solving this problem. This is because it wasn't just one or two tasks that needed solving, there was the overall problem and then each small component that the problem needed to be broken down into to actually solve the problem.

I feel this has greatly improved by problem solving skills as well as planning skills. When solving the problem, I just thought about it for a few weeks before even attempting to write any code. I believe this was why when I started coding, I was able to step by step solve the problem and develop a working solution without many problems.

## Racket
Although it feels like I've only just scratched the surface with Racket, I have definitely learned a lot. I feel very confident that I could solve any problem I can solve in another programming language, in Racket.

I'm not sure when I will use Racket again but it is an option for me with future problems. I can really see the power of functional programming languages when it comes to these types of problems. I don't think it would be harder to solve this problem in something like Java, but I feel like it would take a lot more code to achieve the same solution I have in Racket.

# Detailed Outline of How The Program Works

The main function for the solution is called __solvecount__ and can be found at the bottom of the racket file __main.rkt__.

Almost every single line of code in the __main.rkt__ file is commented. For a more in depth description of exactly how something is achieved, have a look at the code and the comments.

There will not be any code snippets here because it will just make an already complicated explanation of how the project works, even more confusing and complicated. So this will just be a verbal explanation that explains the steps involved in solving the problem. It does explain how the important bits of code works, but without quoting a load of code.

## Step One
The main function takes a number, which is the target number and a list, which is the list of 6 numbers that are from the pool of available numbers. The target number and list of numbers are validated. This makes sure the target number is a number between 101 and 999 and that the list of numbers is 6 numbers long and that all numbers in the list can be found in the pool of available numbers.

## Step Two
The program uses Reverse Polish Notation (RPN) to evaluate the possible solutions. So to do this, first a list of all RPN patterns is generated. This includes all of the possible patterns for 6 numbers, 5 numbers, 4 numbers, 3 numbers and 2 numbers. This is required because not all of the 6 numbers are required to reach the target number.

## Step Three
The RPN patterns are validated, to make sure they are valid RPN patterns. This function is very similar to the function that actually evaluates the Reverse Polish Notation, which is explained below.

## Step Four
We get the cartesian product of lists size 5, 4, 3, 2 and 1 of the 4 operators allowed. These operators are the addition, subtraction, multiplication and division operators. The cartesian product is a way of getting all of the possible combinations of 4 items, in lists that size are larger then the original. It also works for generating lists that are smaller then the original size. Our list of operators is a list of size 4.

## Step Five
Then, we generate all of the unique permutations of the 6 numbers. We can't stop there though, 6 all they way down to 2 numbers could be used. We also generate all the combinations of the 6 number list, of size 2, 3, 4 and 5. Then we get the unique permutations of those lists as well.

## Step Six (Not quite a step but the explanation is important)
The lists of RPN patterns, operators and numbers are all organized very specifically when they are generated. All three of the lists are organized in the same way, so lets use the list of numbers to explain their structure. 

In the one list that represents all of the possible numbers, from size 6 - 2, there are 5 lists. The first list is the list of all the permutations of the 6 numbers, in lists of size 6. The second list is all of the permutations of the 6 numbers, in lists size 5, the third list is of numbers in lists size 4, the fourth is lists size 3 and the fifth and last list is the list of numbers, of size 2.

The RPN patterns and operators are organized the same way. So the first list that is nested in each, being the RPN patterns, operator combinations and number permutations, the first list is generated for 6 numbers, the second is generated for 5 and so on down to the fifth list being generated for 2 numbers.

This is important because when solving the problem, we have to solve all of the equations with 6 numbers first, then move on one by one. It is designed this why to be as efficient as possible. The computer cannot calculate all of the equations in one go because there could be 15 million of them for 6 numbers alone. This is why we calculate all of the equations with 6 numbers, filter out the incorrect equations and only store the correct one before moving on and calculating the rest. Too much memory is used otherwise.

## Step Seven
We generate the cartesian product of RPN patterns, operators and numbers. We do this the same way as we do when generating them. A list with 5 lists. The first being the cartesian product of the patterns, operators and numbers for 6 numbers, all the way down to the fifth list being for 2 numbers.

## Step Eight
Once this list with 5 massive lists in it is generated, we assign it to a variable called x so we don't have to waste time regenerating it.

## Step Nine
One at a time, we evaluate each of the 5 lists, the first being for 6 numbers. Once the first list is evaluated, all of the equations are passed to a function that only returns the list of RPN patterns, operators and numbers of equations that evaluate to the target number. This list is then appended to a list that will hold all of the solutions. Then the rest of the lists are evaluated the same, one at a time and appended to the list of solutions.

To evaluate the RPN, the valid RPN pattern is passed into the function along with the list of operators and numbers. A stack is also used, which starts off empty. The pattern is checked, if there is a 1, it represents a number and a number is added to the top of the stack. This continues until a -1 is found in the pattern. Then, the first two numbers on the top of the stack are taken off, the operator is applied to them and the result is added back on top of the stack. This continues until there are no more items left in the RPN pattern list. The stack is left with one value on it, which is the result of the calculation.

## Step Ten
The list of all the RPN patterns, operators and numbers that evaluate to the target number are saved to a variable so they do not have to be calculated again.

## Step Eleven
This list of solutions is passed to a function that formats them into Reverse Polish Notation. This function is similar to the evaluation but justs adds them to a list instead of evaluating them.

## Step Twelve
The list of formatted Reverse Polish Notation solutions are printed to the screen. The list is then counted and a message is displayed after the list is finished printing out. This message informs the user how many solutions were found because there is probably going to be more solutions then can be counted manually. The last solutions to be printed out, are the solutions that used the least amount of numbers to evaluate to the target number.

# References
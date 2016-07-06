Welcome to our programming tutorial. Do you per chance want to learn programming? Well that's good because that's what this tutorial teaches.

Have you ever seen a computer program before? Well I've prepared one here for you. Click run, see what it does and if you're up to it change it to greet yourself instead of the world.

Task: change the "quoted" text

    :::python
    print "Hello, World!"

Larger programs are a sequence of instructions. Here's the biggest program I've ever written. It's made up of two print instructions, each on its own line.

If you spell print any differently python will get mad at you (and it doesn't always say what's wrong). Remember, to the computer Print PRINT print pRiNt are all different spellings.

Why don't you go ahead and beat my programming record by extending this to 3 lines.

Task: add a third print instruction below the other two

    :::python
    print "there once was a village"
    print "and in that village lived..."

I like your style. Remember a long long time ago when you told the computer to greet you? Well wouldn't it be cool if the computer asked your name and then greeted you. Then you could show your friends and it would get their names right as well. Is this possibily what the next program does?

Notice that name doesn't have any quotes. This is known as a variable and stores the result from input. We then use that variable to print out our response.

Task: run this program. you can also play around with it or skip ahead to the challenge

    :::python
    name = input("What is your name?")
    print "Hello " + name + "!"

# Challenge 1

Welcome to your first challenge. The point of challenges is to test what you've learnt so far. You'll be asked to write a simple program without looking anything up. If you don't pass you can revise and try again.

For this challenge \*theme song plays\*. Write a program that prints a list of your favourite things. You should include at least three items.

    :::python
    # Write your program here

Well done on passing your fist challenge. It wasn't really that hard was it?

Now that you've mastered printing text to the screen, it's time to revisit those variables (oh boy!). They're really not that hard when you think of them like labelled packing boxes.

For this code we've started with one box labelled name. Guess what we store in that box. That's right the name of a person called "Steve".

How about you go ahead and make another variable called pet. In that variable store your favourite animal, be it "Dog", "Cat", "Horse", or "Platypus". After print it out on a new line.

Task: add a second variable and print statement to the program

    :::python
    # store our name in the box called name
    name = "Steve"
    # and get that name back
    print name

Python allows us to join many pieces of text together using the + symbol. It doesn't always look easy to read when we use it with plain text. But we can use it with the variables we've been learning to make whole syntances.

Using this amazing new knowledge, we can quiz the user for a bunch of details and give them back a description of everything someone meeting them needs to know.

Task: use input to get the values for name and hairType

    :::python
    print "this " + "is" + " a sentence"
    name = "Steve"
    hairType = "no"
    print "I am " + name + " who has " + hairType + " hair"

# Challenge

You have made it far my friend. The road has been paved with your factory. People far and wide have heard your name. Now it is time for your second challenge.

For this challenge. Make a program that asks the user what their favourite animal is. Some questions about it. Then prints out a description.

    :::python
    # Write your program here

Python know about more things than just text. In fact it can do math as well (thank goodness it can, because I can't). But before we do any math it would be good to know how python sees numbers. We can use a handy dandy tool called introspection (it's like inspection, in the intro). Here I've listed the 4 main value types. Pretty ain't it.

* 'string' (a chunk of text)
* 'integer' (a number without any decimal points)
* 'float' (a number with decimal points)
* 'boolean' (a value representing either True or False)

Task: none this time

    :::python
    print type("a chunk of text")
    print type(5)
    print type(5.1)
    print type(True)

Now for that exciting maths we've been waiting for. That's really all you wanted to learn from programming isn't it. Well here it is

Task: be in awe of maths

    :::python
    print 1 + 1

Oh. I suppose you wanted something real fancy like. Well maybe later. But it's great to see you all excited by maths.

For now I thought you might like to write programs that change their behaviour based on input. You know, for like games and stuff.

Task: use the tools you've learnt so far and come up with a simple story game

    :::python
    name = input("May I kindly get your name?")
    # remember Steve is not the same as steve
    if name == "steve":
    	print "Welcome old friend"
    else:
    	print "Intruder! Guards! Intruder! Guards!"

Why did you learn types? We're not even using them. Well before you go ahead and say that (I know that's what you were thinking). All input starts as text. So if you want to ask someone for their age you'll still get text and not a number. If you try and use it as a number you'll either have your program crash or do weird things. So we simple convert it to a number. Behold.

That's all fine and dandy. But what happens if you ask Python for a number from something that just isn't a number. Well I don't know but you can find out.

Task: convert something that isn't a number to a number

Task: get two numbers from input, add them together and print them out

Two tasks this time. Aren't you lucky

    :::python
    age = input("I don't mean to pry. But what is your age?")
    print type(age)
    age = int(age)
    print type(age)

Here's a treat. Or a trick if you're that way inclined. Show this to someone who's not as good a programmer as you. It'll surprise them.

Computers have two ways of dividing numbers. The normal way, and the "integer division" way. The trick here is recognising when each one occurs. If neither number includes a decimal point, the answer won't either.

Task: confuse a friend

    :::python
    print 5 / 2
    print 5.0 / 2

# Challenge

Welcome welcome. Come one come all to the final challenge. You have learnt a lot so far, are you ready to put it all on the line?

For this challenge you will have to combine everything you've practised so far. So don't worry if it takes more than one attempt.

* You will have to ask for two input values. The first is text. The second is an integer number.
* If the number is below 100, print out one response. Otherwise print out a different response
* The number that was inputted also needs to be outputted as part of the two responses

Good luck. See you on the finish line

    :::python
    # Write your program here

Well done. Quite an impressive show. With your new found skills, what will you do? How about moving on to our applications of programming tutorial. Where you'll learn some new python skills as well as start to write real applications.

    :::python
    # End of tutorial

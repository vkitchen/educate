Welcome. I take it you're here to learn to program? To start off with I have prepared an example for you.

See what it does, and if you're upto it change what's between the "quotes" so that it greets you instead of the world.

    :::python
    print "Hello, World!"

Computer programs are written step by step. A new instruction on each line. Almost like poetry.

Can you finish this one off for me? I'm never very good at them

    :::python
    print "there once was a village"
    print "and in that village lived..."

That was a really cool poem. But we could have written it just on paper. How about we make full use of the computer and make that poem interactive.

What else can you ask the user?

    :::python
    print "I want to tell you a story"
    print "But first can you answer this quiz"
    name = input("What is your name?")
    age = input("How old are you?")
    print "Hello " + name + " aged " + age

# Challenge

For this challenge. Write a program that prints a list of your favourite things. You should include at least three items.

    :::python
    # Write your program here

When we were dealing with input we saw something which we call variables. `name = input("How old are you?")`. In this code the variable is name. We distinguish it from text by not putting speech marks around it.

A variable is like a box which we can store things in. We write a name on the side of the box that describes what we've stored. And later we can take that thing out of the box.

    :::python
    # store our name in the box called name
    name = "Steve"
    # and get that name back
    print name

We can have more than one variable and give them different names.

We can also join pieces of text together to make whole sentences.

    :::python
    print "this " + "is" + " a sentence"
    name = "Steve"
    hairType = "no"
    print "I am " + name + " who has " + hairType + " hair"

# Challenge

For this challenge. Make a program that asks the user what their favourite animal is. Some questions about it. Then prints out a description.

    :::python
    # Write your program here

When we write our programs. We process data. To make it easier we've defined different types of values. The common ones are:
* 'string' (a chunk of text)
* 'integer' (a number without any decimal points)
* 'float' (a number with decimal points)
* 'boolean' (a value representing either True or False)

    :::python
    print type("a chunk of text")
    print type(5)
    print type(5.1)
    print type(True)

If we have two values of the same type. We can do a comparison between them. The comparison will result in a boolean

    :::python
    print "is 5 less than 6"
    print 5 < 6
    print type(5 < 6)
    print "" # a blank line
    print "is 5 greater than 6"
    print 5 > 6
    print type(5 > 6)
    print "" # a blank line
    print "does 5 equal 6"
    print 5 == 6
    print type(5 == 6)

Now we can check what the user has entered.

    :::python
    number = input("Please kind sir, a number")
    print "Is your number less than 100"
    print number < 100

And even cooler

    :::python
    # manually convert to an int as all input is text by default
    number = int(input("A number less than 100 please"))
    if number < 100:
    	print("Thank you")
    else:
    	print("Hey. This isn't right at all")

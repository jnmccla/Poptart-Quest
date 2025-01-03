== theStore
You're feeling a little {patienceLevel} by the time you get to the store, your stomach rumbling for those good good toasted pastries. You better not waste any time.
Where do you go?
* [The breakfast aisle.]
#CLEAR
    ->breakfast
* [The produce section.]
#CLEAR
~patienceLevel++
    ->produce
* [You changed your mind. Back home you go!]
~store = "failure"
#CLEAR
{firstChoice == "store":->kitchen|->disappointment}


=breakfast
{You find the breakfast aisle fairly easily, and it only takes a few more steps to get to the poptart section. There are a <i>lot</i> of flavors. Like a <i><b>lot</b></i>.|You're back staring at the variety of poptarts available to you.}
{patienceLevel > craving: It's kind of overwhelming, to be honest. Your head spins with the possibilities.}
* {patienceLevel < overwhelmed} [What are my options?]
#CLEAR
    ->poptartList
* [Choose one at random.]
    You choose a box at random and check out as quickly as you can. As the cashier hands you your bag, you finally take a peek at the box.
    ~store = "success"
    {firstChoice != "store":
    ~ finalChoice = "{~smores|brown sugar cinnamon|chocolate|root beer|pumpkin|pear|grape|{firstChoice}}"
    - else:
    ~ finalChoice = "{~smores|brown sugar cinnamon|chocolate|root beer|pumpkin|pear|grape}"
    }
     
        {finalChoice == firstChoice:
        Hell yeah, they have {firstChoice}!
        -else:
        Oh, {finalChoice}? Maybe not your first pick, but should be tasty!
        }

    ** [Continue home]
    #CLEAR
    ->toasterTime
+ [Actually, let's {check out|go back to} the produce aisle.]
    #CLEAR
    ~patienceLevel++
    ->produce
* [Change your mind. You got poptarts at home.]
#CLEAR
    ~store = "failure"
    {firstChoice == "store":->kitchen|->disappointment}
=poptartList
For your own sanity, you ignore the ones that have some sort of branding crossover, which leaves a much more reasonable amount left:
* [smores]
#CLEAR
    ~finalChoice = "smores"
    ->checkOut
* [brown sugar cinnamon]
#CLEAR
    ~finalChoice = "brown sugar cinnamon"
    ->checkOut
* [chocolate]
#CLEAR
    ~finalChoice = "chocolate"
    ->checkOut
* [root beer]
#CLEAR
    ~finalChoice = "root beer"
    ->checkOut
* [pumpkin]
#CLEAR
    ~finalChoice = "pumpkin"
    ->checkOut
* [pear]
#CLEAR
    ~finalChoice = "pear"
    ->checkOut
* [grape]
#CLEAR
    ~finalChoice = "grape"
    ->checkOut
* {firstChoice != "store"} [{firstChoice}]
    ~finalChoice = firstChoice
    #CLEAR
    ->checkOut
* [Choose one at random.]
#CLEAR
   ->random
* [Change your mind. You got poptarts at home.]
#CLEAR
    ~store = "failure"
    {firstChoice == "store":->kitchen|->disappointment}
=checkOut
You grab your pack of {finalChoice} and head to the register. {patienceLevel > craving:You can't focus on anything but the poptarts, rushing through the necessary movements to pay for them.|You make polite conversation with the cashier, but your eyes stay glued to your box of delights.}
Finally, you can go home.
~store = "success"
* [Continue home.]
->toasterTime

=random
 You choose a box at random and check out as quickly as you can. As the cashier hands you your bag, you finally take a peek at the box.
    ~store = "success"
     {firstChoice != "store":
    ~ finalChoice = "{~smores|brown sugar cinnamon|chocolate|root beer|pumpkin|pear|grape|{firstChoice}}"
    - else:
    ~ finalChoice = "{~smores|brown sugar cinnamon|chocolate|root beer|pumpkin|pear|grape}"
    }
   
        {finalChoice == firstChoice:
        Hell yeah, they have {firstChoice}!
        -else:
        Oh, {finalChoice}? Maybe not your first pick, but should be tasty!
        }

    * [Continue home]
    #CLEAR
    ->toasterTime


=produce
Are... Are you sure? The produce section? For poptarts? {|Again?}

+[Nah, I'm just fucking with you. To the breakfast aisle!]
    ->breakfast
+[Yeah. I've {|still} got a good feeling about the produce section.]
    ~patienceLevel++
-
Uh. Okay. You're in the produce section. {|Again.}
-(check)
What do you check {first|next}?
{patienceLevel < overwhelmed:
* {firstChoice != "store"} [The {firstChoice} section.]
    ~patienceLevel++
    ->berry
* {firstChoice == "store"} [The {~blueberry|strawberry|cherry} section.]
    ~patienceLevel++
    ->berry
* [Amongst the pumpkins.]
    ~patienceLevel++
    #CLEAR
    ->pumpkin
* [Behind some pears.]
    ~patienceLevel++
    #CLEAR
    ->pear
* [Give up and go to the breakfast aisle.]
#CLEAR
    ->breakfast
* Give up and go home.
    ~store = "failure"
    #CLEAR
    {firstChoice == "store":->kitchen|->disappointment}
    }
{patienceLevel == overwhelmed:
    This is pointless. You need poptarts <i>now</i> or you will perish from hunger.
    *[Fine. I'll go to the breakfast aisle.]
    #CLEAR
        -> breakfast
    *[Fine. I'll go back home.]
        ~store = "failure"
        #CLEAR
        {firstChoice == "store":->kitchen|->disappointment}
    *[There's something here, I know it!]
    #CLEAR
        ->produceBadEnd
}
{patienceLevel > overwhelmed:
Nothing. You wasted too much time.
* There were never any poptarts.
#CLEAR
    ->produceBadEnd
    }


= berry
You move around the cartons, but to no avail. While there is the fruit that makes up your delicious poptarts, there are none of the actual poptarts.
 * [Back to the produce section.]
 #CLEAR
        ->check
    * [Give up and go to the breakfast aisle.]
    #CLEAR
        ->breakfast
    * [Give up and go home.]
        ~store = "failure"
        #CLEAR
         {firstChoice == "store":->kitchen|->disappointment}
= pumpkin
    You search between all thirteen pumpkins, but not a box of poptarts in sight. But maybe you missed one?
    - (recheck)
    * [Check again.]
        You check again. Yep. Just twelve pumpkins. Not a crumb of a poptart in sight.
        ->recheck
    * [Back to the produce section.]
    #CLEAR
        ->check
    * [Give up and go to the breakfast aisle.]
    #CLEAR
        ->breakfast
    * [Give up and go home.]
        ~store = "failure"
        #CLEAR
         {firstChoice == "store":->kitchen|->disappointment}
= pear
The pile of pears are perched rather pecariously in a peculiar pyramid arrangement.
You very carefully move them, like one of those mobile games where you have to sort the colors that are all mixed in different bottles until each bottle only has one color, with one bottle to spare. Except nothing like that at all.
The point is, there aren't any poptarts here.
 * [Back to the produce section.]
 #CLEAR
        ->check
    * [Give up and go to the breakfast aisle.]
    #CLEAR
        ->breakfast
    * [Give up and go home.]
        ~store = "failure"
        #CLEAR
         {firstChoice == "store":->kitchen|->disappointment}
=produceBadEnd
As Icarus before you, you have flown too close to the sun.
In your strange attempt to find your preferred breakfast treat within the freshest offering of your local Hoggly Woggly, you have gone mad with hunger.
You grab the nearest selection of produce and bite into it with wild abandon.
It's a cucumber.
You spit it out.
An orange meets the same fate.
* Then a carrot.
-
* Then a peach.
-
When the store associates are finally forced by management to try to calm you down, it is far, far too late.
* [Collapse]
-
They find you laying in a pile of lettuce, onions, grapes, and other such vegetables and fruits with a single bite taken out. And also the many, many single bites your gullet rejected. Poptarts were the only thing that could sustain you, and you squandered your precious time in finding them.
->starve











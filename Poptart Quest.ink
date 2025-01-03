INCLUDE functions.ink
INCLUDE toaster maintenance.ink
INCLUDE store time.ink


#title: Poptart Quest
#author: ambrolen
LIST pastryPatience = calm, antsy, distracted, craving, obsessed, overwhelmed, peaked
VAR patienceLevel = calm
VAR firstChoice = ""
VAR secondChoice = ""
VAR thirdChoice = ""
VAR finalChoice = ""
VAR toastLevel = ""
LIST toasterCheck = plug, tray, slot
LIST plugStatus = in, out
VAR plugIs = ""
LIST trayStatus = full, empty
VAR trayIs = ""
LIST slotStatus = stuffed, clear
VAR slotIs = ""
VAR randNumb = 1
~randNumb = RANDOM(1,2)
VAR store = "no"




You wake up in the morning with a very particular craving.
* Poptarts!
-
Yes, indeed, the strong need to have a simple pack of poptarts of the brand or off-brand variety has taken ahold of your every cell.
* [Do your morning hygeine.]
 ~ patienceLevel ++
        Right, okay, fine. You go to the bathroom and brush your teeth and wash your face and shave and brush your hair and trim your ear hair and whatever else nonsense you need to do. <i>Now</i> can you go get your poptarts?
        ** [Yeah, alright then.]
        #CLEAR
        ->kitchen
* [Head straight for the kitchen.]
#CLEAR
->kitchen
= kitchen
{firstChoice != "store":
You make a beeline for the cabinet you keep the poptarts in, throwing open the door with abandon!
There it is -- your delectable morning treat.
It's a variety pack, containing Strawberry, Cherry, and Blueberry flavors. Which one will you choose?
- else:
After a waste of time and gas, you're back in front of your cabinet. The same three choices taunt you from the box art.
Which will you choose?
}
* [Strawberry]
    ~ firstChoice = "strawberry"
    ->chance
* [Cherry]
    ~ firstChoice = "cherry"
    ->chance
* [Blueberry]
    ~ firstChoice = "blueberry"
    ->chance
* {!theStore}[None of these will do. To the store!]
    ~patienceLevel++
    ~firstChoice = "store"
    -> toTheStore
=chance
~ temp faveChance = RANDOM(1,100)
{faveChance == 100:
    Yes, you still have a pack of the {firstChoice} flavor!
    You carefully unwrap your poptarts and stick them in the toaster, setting it to your preferred toastiness level.
    You watch the toaster, mouth watering in anticipation, until finally -- finally! -- your tarts do what they were named for: pop up from the toaster, just the way you like them.
    You gingerly move one to a plate, but you can't wait for it to cool down any longer before you take a bite of the other.
    Pefection, thine name is {firstChoice} poptarts.
    -> goodEnd
    
    - else:
    -> disappointment
    }
= disappointment
{came_from(-> chance):
Unfortunately, it seems you've already eaten through all the {firstChoice}.
    - else:
    After a waste of time and gas, you're back with the two choices you initially rejected. What do you choose?
    }
* {firstChoice != "strawberry"} [Strawberry]
    ~ secondChoice = "strawberry"
* {firstChoice != "cherry"} [Cherry]
    ~ secondChoice = "cherry"
* {firstChoice != "blueberry"} [Blueberry]
    ~ secondChoice = "blueberry"
* {!theStore}[Unacceptable. To the store!]
    ~ patienceLevel++
    ~ secondChoice = "store"
    #CLEAR
    -> toTheStore
-
~ temp crumbledTart = RANDOM(1,100)
{ crumbledTart == 1:
    Your heart sinks as you grab the pack of {secondChoice} poptarts. You can feel through the package that it's completely smooshed. Absolutely unsalvageable. It was the last one, too.
    You'll have to settle for <>
    {firstChoice != "strawberry" && secondChoice != "strawberry": 
    ~thirdChoice = "strawberry"
    strawberry. 
        }
    {firstChoice != "blueberry" && secondChoice != "blueberry": 
    ~thirdChoice = "blueberry"
    blueberry. 
        }
    {firstChoice != "cherry" && secondChoice != "cherry": 
    ~thirdChoice = "cherry"
    cherry. 
        }
    * [Accept your fate and move on.]
    ~finalChoice = thirdChoice
    #CLEAR
        ->toasterTime
    * {!theStore}[No! Go to the store and get the {firstChoice} poptarts you <i>really</i> want!]
        ~patienceLevel++
        #CLEAR
        ->toTheStore
    }
  
    
    ->secondPlace
= secondPlace
Yes! There was one more {secondChoice} remaining. That means you'll have to contend with {firstChoice != "strawberry" && secondChoice != "strawberry":strawberry}{firstChoice != "cherry" && secondChoice != "cherry":cherry}{firstChoice != "blueberry" && secondChoice != "blueberry":blueberry} next time, but that's a problem for future you.
~ finalChoice = secondChoice
-> toasterTime
= toasterTime
{store == "failure": 
Future you who succeeded in a trip to the store.
Ah, well.
You open the pack of {finalChoice} pastries and pop them in the toaster.
    }
{store == "success":
    You're back with your bounty, feeling the shine of success. Though your stomach rumbles insistently. All in good time! Surely the fruits of hard labor taste sweeter than just grabbing whatever you had left in your cabinet, right?
    You open the box{finalChoice == "pumpkin": and pause. It looks like a pack is already missing? But the box was sealed. Whatever! You still have packs left, and that's all that matters! You|,} take out a pack, and, heh, <i>pop</i> the delicious pastries into the toaster.
    }
{store == "no":
You grab the pack of {finalChoice} poptarts and, heh, <i>pop</i> them into the toaster.
}
But just <i>how</i> toasty do you want them?

*[Lightly toasted]
    ~ toastLevel = "light"
*[Golden brown]
    ~ toastLevel = "medium"
*[Verging on burnt.]
    ~ toastLevel = "burnt"
    
-
#CLEAR
You {toastLevel == "light":barely nudge the dial}{toastLevel == "medium":turn the dial toward the middle}{toastLevel == "burnt":turn the dial up to eleven} and press the lever down.
~ plugIs = plugStatus(randNumb)
~ trayIs = trayStatus(randNumb)
~ slotIs = slotStatus(randNumb)
{plugIs ? in && trayIs ? empty && slotIs ? clear:
    It works without a hitch! Not that you should have expected any different -- you keep your toaster in tip top shape just for such occasions. One must always be ready for a morning pastry.
    -> goodEnd
    - else:
    -> borken
    }


== toTheStore
{firstChoice == "store": None of these flavors are what you want this morning, so off to the store you go!|No, fuck this! You're going to get {firstChoice} poptarts or die trying. Or maybe you'll find an even better flavor!}
->theStore
== starve
You don't eat your poptarts in time and starve to death! :(
<b>GAME OVER</b>
    -> END
== goodEnd
{patienceLevel > craving:
    You can't wait to take them to sit and eat properly -- you take a bite standing at the kitchen counter. The paste is hot, and you know you'll regret the burn on your tongue later, but the crust is {toastLevel == "light":soft}{toastLevel == "medium":crisp}{toastLevel == "burnt":crunchy}, just the way you like it, and the {finalChoice} filling, divine.
    You gorge until there is naught but crumbs, and those you lick off your fingers and plate.
    
    You did it. You ate poptarts for breakfast! :D
    
    <b>Poptarts devoured!</b>
- else:
    You carry the plate of poptarts with you like a holy relic. When you finally sit, you do not immediately unhinge your jaw and swallow them whole like you so desperately want to. Instead, you take a small bite, careful of the steaming paste as you do.
    The crust is {toastLevel == "light":soft}{toastLevel == "medium":crisp}{toastLevel == "burnt":crunchy}, just the way you like it, and the filling, divine. {store == "success":You're glad you went to the store to get these {finalChoice} poptarts. They are truly worth it. You savor every bite.|You savor every bite of your {finalChoice} poptart.}
    Alas, all good things must come to an end. Eventually, all that is left are crumbs.
    
    You did it. You ate poptarts for breakfast! :D
    
    <b>Poptarts acquired!</b>
    }

->END









== borken
Your poptarts immediately come back up{toastLevel == "light":, and not because of the short time you wanted them toasted. They're not even warm!|.}

-(opts)
*(plugCheck){toasterCheck !? plug}[Check the power cable.]
#CLEAR
    ->isPlug
*(trayCheck){toasterCheck !? tray}[Check the crumb tray.]
#CLEAR
    ->isTray
    
*(slotCheck){toasterCheck !? slot}[Check for stuck food.]
#CLEAR
    ->isSlot
    
*{slotCheck}{trayCheck}{plugCheck} [Try again.]
You've checked everything. It has to work now, right?
    -> tryAgain
= isPlug
{plugIs ? out:
        ~ patienceLevel++
        Oh. Looks like you forgot to plug it in.
        * [Plug it in]
        ~ plugIs = in
        You plug the toaster in.
            -> opts
        * Starve
        #CLEAR
            ->starve
        }
    {plugIs ? in:
        {slotCheck: Oh yeah. You had just plugged this thing back in! All good to go here.|The plug is snugly in the socket. Guess that's not your issue!}
        -> opts
        }
  
= isTray
{trayIs ? full:
    ~ patienceLevel++
        Oof. You haven't cleaned this thing out in <i>a while</i>. There are crumbs and re-solidified butter from toast and bagels, and some sprinkles and a little goo from your many other poptart cravings. Some of the leavings scraped off onto your counter as you took the tray out. You need to add "cleaning the toaster" to your chore rotation.
        * [Clean the toaster.]
        ~ trayIs = empty
        You shake the tray out over the trash can, then bang it on the side a few times. Not as much gunk came off as you hoped, so off to the sink!
        The gunk is no match for hot, soapy water and the third scrub brush you tried!
        You leave it on a towel to dry, then wipe off the excess crumbs from the counter, then give the tray another wipe down before sticking it back in.
        Good to go!
            -> opts
        * Starve
        #CLEAR
            ->starve
        }
    {trayIs ? empty:
        The tray is clean as a whistle. Which is good, because you cleaned it last night, so it would be weird if it hadn't been.
        -> opts
        }

= isSlot
You take out a plate and gingerly set the {finalChoice} poptarts on it so you can look in the toaster's guts.
    {slotIs ? stuffed:
        ~ patienceLevel++
        Oh. Oh no. How did you not notice all this bread crammed in here?? You're surprised you haven't started a fire by now, or that you didn't notice the poptarts were sitting up too high when you put them in.
        * [Clear it out.]
        ~ slotIs = clear
        You {plugIs ? in:unplug the toaster|grab the unplugged toaster (which also <i>probably</i> didn't help with the toaster not working)} and shake it out in the trashcan, which gets out some crumbs, but not the bulk of the food.

            Triple checking the plug is truly not in the socket, as though it could have snuck its way back in while you were shaking it out, you grab a fork and dig around in the slots to loosen the food.
            It takes a few minutes of the back and forth: dig out some food, shake out some more, dig out more food, shake again, but finally the slots are clear of food.
            You gently put your poptarts back in their rightful place.
            -> opts
        * Starve
        #CLEAR
            ->starve
        }
    {slotIs ? clear:
        You don't see anything stuck in the slots. Which is good, because you think otherwise would be a fire hazard, and you like to think you're more safety-minded than that.
        -> opts
        }

= tryAgain

Eureka! It works!
*[Enjoy the fruits of your labor.]
#CLEAR
->goodEnd






== function changeStateTo(ref stateVariable, stateToReach)
~ stateVariable -= LIST_ALL(stateToReach)

~ stateVariable += stateToReach

== function randStatus(x)
~ randNumb = RANDOM(1,2)

== function came_from(-> x)
~ return TURNS_SINCE(x) == 0

/*
== function checkToaster
{plugStatus ? in && trayStatus ? empty && slotStatus ? clear:
    ~toasterStatus += good
    ~return "fixed"
    - else:
        ~return "broken"
    }
    */
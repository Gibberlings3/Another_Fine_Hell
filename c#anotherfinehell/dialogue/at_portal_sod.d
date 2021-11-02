

/* add to De Lancie's dialogue once the portal is open */

EXTEND_BOTTOM bddelanc 72
++ @0 /* It's me, <CHARNAME>. There is an open portal to Avernus here... */ DO ~SetGlobal("bd_delancie_talk","bd4300",2)~ GOTO 73
END

EXTEND_BOTTOM bddelanc 73
++ @1 /* What do your sages say? Any hint as to what I'm supposed to do? */ + at_portal_01
END

I_C_T bddelanc 73 C#AfHSoD_bddelanc_73
== bddelanc @2 /* <CHARNAME>, Corporal Duncan witnessed what happened in there. We know it was your blood that opened the portal. We are in contact with our sages at Waterdeep and Baldur's Gate this instance. There must be a way for you to close the portal. Closing it is the only thing that will spare us all of being overrun by fiends - and Dragonspear Wars repeating all over again. */
END

INTERJECT bddelanc 75 C#AfHSoD_bddelanc_75
== bddelanc @3 /* Wait... Our mages are signalling me. */
END
IF ~~ THEN EXTERN bddelanc at_portal_01

APPEND bddelanc
IF ~~ THEN at_portal_01
SAY @4 /* There is a message from the sages. It says... the portal was awakened by divine blood, so the blood of a fiend master will shut it down again. */
++ @5 /* Looks like going after Caelar and Hephernaan and entering the portal is the only way for me to achieve this. */ + at_portal_04
++ @6 /* You're seriously expecting me to go and get it, don't you? */ + at_portal_03
++ @7 /* Oh, great. I'll let you know when one is coming through, then. Now open the door. */ + at_portal_03
END

IF ~~ THEN at_portal_02
SAY @8 /* One moment - how is the status? Can we *do* something from here? WHAT DO YOU MEAN, "MAGICAL BARRIER"?! GET TO IT, FOR THE SAKE OF THE GODS! */
= @9 /* Excuse this, <CHARNAME>, we *are* trying here, but this magic is strong. I'll need to focus on what is going on at this side of the door now. It was your blood that opened this mess, do not flee from your responsibility to do all you can to clean it up! Be the gods with you - with all of us. */
COPY_TRANS bddelanc 75
END

IF ~~ THEN at_portal_03
SAY @10 /* You *are* our greatest hope currently. */
IF ~~ THEN + at_portal_04
END

IF ~~ THEN at_portal_04
SAY @11 /* <CHARNAME>, a lot of people are... aware of your Bhaal heritage. What happened here will make it much worse. Show them that you are no threat but the hero you ascended to in Baldur's Gate! */
IF ~~ THEN + at_portal_02
END
END //APPEND


/* after portal is closed again */

I_C_T bddelanc 79 C#AfHSoD_bddelanc_79
== bddelanc IF ~!IsValidForPartyDialogue("VOGHILN")~ THEN @12 /* <CHARNAME>, you return victorious, a hero to the people. But let us not forget that the main threat of what happened here today was because of you - your Bhaalspawn blood opened the portal to Avernus, threatening the lands to be overrun by fiends! */
= @13 /* We will celebrate tonight and welcome you in our midths - but we will double the guards, because your presence is bound to stir trouble, one way or the other. */
END

I_C_T BDVOGHIJ 46 C#AfHSoD_bddelanc_79 //same interjection as above, should only play once
== bddelanc @14 /* <CHARNAME>, you return victorious, a hero to the people. But let us not forget that the main threat of what happened here today was because of you - your Bhaalspawn blood opened the portal to Avernus, threatening the lands to be overrun by fiends. */
= @15 /* We will celebrate tonight and welcome you in our midst - but we will double the guards, because your presence is bound to stir trouble, one way or the other. */
END

I_C_T bdbence 64 C#AfHSoD_bdbence_64
== bdbence @16 /* There is more than one even amongst the soldiers who fear you for what you are and what happened here because of your blood. But you are true hero material, so act as such in the future, too! */
END

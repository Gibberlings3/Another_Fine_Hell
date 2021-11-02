/* Portal is only set to dormant, not closed completely yet: Aun will warn */

I_C_T bddelanc 81 C#AfH_PortalQuest
== bdaun IF ~InMyArea("bdaun") !StateCheck("bdaun",CD_STATE_NOTVALID)~ THEN @0 /* I need to warn you. The portal is set to dormant again - this is all that could be done for now. A way has to be found to close it forever, or the danger of it opening again will always be present. The Order of the Aster will share their knowledge with your sages, my lords. */
== bddelanc IF ~InMyArea("bdaun") !StateCheck("bdaun",CD_STATE_NOTVALID)~ THEN @1 /* Yes, our sages already warned us about it. This is grave news, but we feared it would not be that easy. We will combine forces to close this threat for good. Thank you for your offer, Master Argent. */
END

I_C_T3 bddelanc 79 C#AfH_PortalQuest
== bdaun IF ~InMyArea("bdaun") !StateCheck("bdaun",CD_STATE_NOTVALID)~ THEN @0 /* I need to warn you. The portal is set to dormant again - this is all that could be done for now. A way has to be found to close it forever, or the danger of it opening again will always be present. The Order of the Aster will share their knowledge with your sages, my lords. */
== bddelanc IF ~InMyArea("bdaun") !StateCheck("bdaun",CD_STATE_NOTVALID)~ THEN @1 /* Yes, our sages already warned us about it. This is grave news, but we feared it would not be that easy. We will combine forces to close this threat for good. Thank you for your offer, Master Argent. */
== bddelanc IF ~OR(2) !InMyArea("bdaun") StateCheck("bdaun",CD_STATE_NOTVALID)~ THEN @2 /* The grave news is that the portal is only set to dormant again - this is all that could be done for now. A way has to be found to close it forever, or the danger of it opening again will always be present. I feared it would not be that easy. We will make sure there won't be any threat from the portal for now. */
END

I_C_T BDVOGHIJ 46 C#AfH_PortalQuest //same interjection as above, should only play once
== bdaun IF ~InMyArea("bdaun") !StateCheck("bdaun",CD_STATE_NOTVALID)~ THEN @0 /* I need to warn you. The portal is set to dormant again - this is all that could be done for now. A way has to be found to close it forever, or the danger of it opening again will always be present. The Order of the Aster will share their knowledge with your sages, my lords. */
== bddelanc IF ~InMyArea("bdaun") !StateCheck("bdaun",CD_STATE_NOTVALID)~ THEN @1 /* Yes, our sages already warned us about it. This is grave news, but we feared it would not be that easy. We will combine forces to close this threat for good. Thank you for your offer, Master Argent. */
== bddelanc IF ~OR(2) !InMyArea("bdaun") StateCheck("bdaun",CD_STATE_NOTVALID)~ THEN @2 /* The grave news is that the portal is only set to dormant again - this is all that could be done for now. A way has to be found to close it forever, or the danger of it opening again will always be present. I feared it would not be that easy. We will make sure there won't be any threat from the portal for now. */
END
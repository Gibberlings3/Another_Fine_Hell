/* PC and dead Skie were discovered by Duncan and Corwin */


ADD_STATE_TRIGGER BDBENCE 6 ~False()~

APPEND BDBENCE

/* "bdcut60a.bcs" triggered by "bd4100.bcs": Bence Duncan and other soldiers find the PC at the scene. 
Global("bd_plot","global",590) */

/* original dialogue of Bence sets "SetGlobal("bd_plot","global",591)" which triggers all the "PC is a murderer" NPC responses. Need to prevent that.
Will work with variable "C#AfHSoD_RevisedEnd","GLOBAL" instead.
Bence also triggers "bdcut60b.bcs" which make Corwin and others appear. */

/* first dialogue, only Bence. Global("bd_plot","global",590) */
IF WEIGHT #-1
~Global("bd_plot","global",590) Global("C#AfHSoD_RevisedEnd","GLOBAL",0)~ THEN totalrevised_bence
SAY #%eet_2%39373 /* ~What have you done, <CHARNAME>? WHAT HAVE YOU DONE?~ [BD39373] */
= @0 /* You... you were responsible for Skie's safety! And now she is laying here, dead and soaked in her own blood?! She is dead! The daughter of Duke Silvershield was killed! */
  IF ~~ THEN DO ~SetGlobal("C#AfHSoD_RevisedEnd","GLOBAL",1)
StartCutSceneMode()
StartCutSceneEx("bdcut60b",TRUE)~ EXIT
END
END //APPEND

/* second dialogue, started by Corwin if Corwin is not dead, otherwise Bence. 
originally started by Global("bd_plot","global",591) in bd4100.bcs after "bdcut60b.bcs" run.
For my ending, I'll add new trigger script blocks to bd4100.bcs for Global("C#AfHSoD_RevisedEnd","GLOBAL",1) 
Leads to bdbence 73 which will trigger the "bdcut61.bcs" (walk through the crowd) */

APPEND bdcorwin 
IF WEIGHT #-1
~Global("C#AfHSoD_RevisedEnd","GLOBAL",1)~ THEN totalrevised_corwin
  SAY #%eet_2%69745 /* ~No. NO. This—it can't be. It just—it can't!~ */
= #%eet_2%39386 /* ~I hope you've got a good explanation for this, <CHARNAME>.~ [BD39386] */
IF ~~ THEN EXTERN bdbence totalrevised_bence_00
END
END //APPEND
APPEND bdcorwij 
IF WEIGHT #-1
~Global("C#AfHSoD_RevisedEnd","GLOBAL",1)~ THEN totalrevised_corwin
  SAY #%eet_2%69745 /* ~No. NO. This—it can't be. It just—it can't!~ */
= #%eet_2%39386 /* ~I hope you've got a good explanation for this, <CHARNAME>.~ [BD39386] */
IF ~~ THEN EXTERN bdbence totalrevised_bence_00
END
END //APPEND

APPEND bdbence 
IF WEIGHT #-1
~Global("C#AfHSoD_RevisedEnd","GLOBAL",1)~ THEN totalrevised_bence_00
SAY @1 /* [Bence Duncan]Tell us what happened! */
++ @2 /* I don't know what happened - it's all a blur. But I believe to have been deceived to kill Skie. I am truly sorry. */ + totalrevised_bence_02
++ @3 /* It was a mighty illusion, by a new enemy who is stalking me for some time now. Skie got caught up in it when I tried to defend myself - I am sorry. */ + totalrevised_bence_05
++ @4 /* It was the Hooded Man. I think he wanted to... test something, but it eludes my mind why Skie would have to die for this. */ + totalrevised_bence_05
++ @5 /* I didn't kill her, if that is what you think. This was a setup. */ + totalrevised_bence_01
++ @6 /* Like HELL I was responsible - YOU were responsible. Don't blame me for YOUR incompetence! */ + totalrevised_bence_06
++ @7 /* However this came to be, the danger seems to be over for now. */ + totalrevised_bence_03
END

END //APPEND

CHAIN
IF ~~ THEN BDBENCE totalrevised_bence_01
@8 /* [Bence Duncan]There is no murder weapon - where is the murder weapon?! We need to secure the surroundings - NOW! */
== BDCORWIN IF ~InMyArea("Corwin") !InParty("Corwin") !StateCheck("Corwin",CD_STATE_NOTVALID)~ THEN #%eet_2%39393 /* ~Well, you better figure out what happened and be quick about it. Duke Silvershield's justice may not wait on the law.~ */
== BDCORWIJ IF ~InMyArea("Corwin") InParty("Corwin") !StateCheck("Corwin",CD_STATE_NOTVALID)~ THEN #%eet_2%39393 /* ~Well, you better figure out what happened and be quick about it. Duke Silvershield's justice may not wait on the law.~ */
END
IF ~~ THEN + totalrevised_bence_04

APPEND BDBENCE 

IF ~~ THEN totalrevised_bence_02
SAY @9 /* [Bence Duncan]You - you would have caused the blow that killed her?! */
IF ~~ THEN + totalrevised_bence_01
END

IF ~~ THEN totalrevised_bence_03
SAY #%eet_2%44329 /* ~I wish I could believe that.~ [BD44329] */
IF ~~ THEN + totalrevised_bence_01
END

IF ~~ THEN totalrevised_bence_04
SAY @10 /* [Bence Duncan]This is affiliated to your evil godly heritage, I am sure of it. Just like Sarevok, all you bring to the people around you is destruction and death! The gods alone know what you did down there to survive Avernus! */
IF ~~ THEN + totalrevised_bence_07
END

IF ~~ THEN totalrevised_bence_05
SAY @11 /* [Bence Duncan]That information is of great value to Duke Silvershield. He will be more than eager to hear about who is responsible for his daughter's death! */
IF ~~ THEN + totalrevised_bence_01
END

IF ~~ THEN totalrevised_bence_06
SAY @12 /* [Bence Duncan]You insolent - */
IF ~~ THEN + totalrevised_bence_01
END
END //APPEND

CHAIN
IF ~~ THEN BDBENCE totalrevised_bence_07
#%eet_2%44320 /* ~You know what I've got to do, <CHARNAME>.~ [BD44320] */
= @13 /* [Bence Duncan]Celebrations are over. This morning brings mornful events which leaves all of us sobered and with a bitter taste in the mouth despite the great victory you were crucial part in yesterday. We will depart immediately and bring Skie to the ducal clerics - and you will come with us. */
= #%eet_2%44332 /* ~Come along, <CHARNAME>.~ [BD44332] */
END
IF ~~ THEN DO ~StartCutSceneMode()
SetGlobal("bd_plot","global",592) SetGlobal("C#AfHSoD_RevisedEnd","GLOBAL",1)
StartCutScene("c#afh61")~ EXIT


/* No leaving of NPCs yet!
"c#afh61" moves group to bd0112.are (for "walk through the crowd")
in area bd0112.are, chapter is set to 13 if not already and cutscene "bdcut61a.bcs" is started which is the actual walk through the crowd.
-remove the "boos" from "bdcut61a.bcs" [no, Minsc, not talking about your hamster] as well as the negative remarks. The returning soldiers are still seen as victorious after defeating Caelar.

bdchains: negative responses from the crowd. Deactivate those by replacing "SetGlobal("BD_STOP_OT"" in bdcut61a.bcs (added own cheers for "Global("C#AfHSoD_BD_STOP_OT"" into bdchains.bcs).

"bdcut61a.bcs" calls "bdcut61t.bcs" which transfsfers the PC to trial scene on podest in "bd0035.are".
Duke Belt starts dialogue.
*/


/* PC on podest. Duke Belt starts dialogue until commotion by Duke Silvershield */
ADD_STATE_TRIGGER bdbelt 0 ~False()~
ADD_STATE_TRIGGER bdbelt 1 ~False()~

CHAIN
IF WEIGHT #-1
~AreaCheck("bd0035") Global("C#AfHSoD_RevisedEnd","GLOBAL",1)~ THEN BDBELT totalrevised_trialscene
@14 /* [Duke Belt]Citizens of Baldur's Gate! We are gathered to account for a great victory. Caelar is defeated! With the help of <CHARNAME>, the hero of Baldur's Gate, her malicious plans were stopped and a hellmouth was closed! All hail the hero of Baldur's Gate - and Dragonspear Castle! */
DO ~SetGlobal("C#AfHSoD_RevisedEnd","GLOBAL",2)~
= @15 /* [Duke Belt]But this great victory would not have been possible without the sacrifices of those that are no longer with us. We mourn the losses of our fallen soldiers, amongst them Skie Silvershield, our Duke Silvershield's daughter who was killed in mysterious circumstances. The palace priests are with the wounded now, to heal and resurrect where possible. */
== BDNOBL90 @16 /* [female Bystander in public hearing SoD]There was a portal to Avernus? The gods help us! */
== BDCOMM90 @17 /* [male Bystander in public hearing SoD]<CHARNAME> is a child of Bhaal! Just like Sarevok! Don't hide this from the people! */
== bdbelt @18 /* [Duke Belt]<CHARNAME>, what was a mere rumor when you defeated Sarevok is a public knowledge now - that you, too, are a child of Bhaal. Citizens of Baldur's Gate! Yes, it is true, <CHARNAME> is a child of Bhaal. */
== BDCOMM90 #%eet_2%69764 /* Child of murder! Evil poisons your blood! */
== bdbelt #%eet_2%69766 /* ~The mark of Bhaal does not in itself prove guilt. But it does cast a darker shadow of suspicion upon the accused. We cannot forget that Sarevok, another spawn of Bhaal, brought our city to the brink of war.~ [BD69766] */
= @19 /* <CHARNAME>'s Bhaal heritage might come as a shock to many of us, but sometimes it needs an outstanding person to be the hero of the people. <CHARNAME> proved to be the savior of this city, and not only once, but twice! */
END
COPY_TRANS BDBELT 1

ADD_STATE_TRIGGER bdbelt 2 ~False()~

CHAIN
IF WEIGHT #-1
~AreaCheck("bd0035") Global("C#AfHSoD_RevisedEnd","GLOBAL",2)~ THEN BDBELT totalrevised_trialscene_01
@20 /* [Duke Belt]Corporal Bence Duncan bore witness to the crucial incidents involving Caelar's dangerous dealings with a portal to Avernus at Dragonspear Castle and <CHARNAME>'s heroic deeds to close it. Corporal, please share your recollections. */
DO ~SetGlobal("C#AfHSoD_RevisedEnd","GLOBAL",3)~
== bdbence @21 /* Caelar and her advisor opened a portal to Avernus that lay dormant in the castle basement. It was <CHARNAME> and <PRO_HISHER> friends who not only defeated Caelar and her treacherous crusade, but did not hesitate to venture into the abyss to collect the fiend blood needed to seal the rift. */
== BDNOBL90 @22 /* [female Bystander in public hearing SoD]<CHARNAME> descended into Avernus? And came out unscarthed?! Who would survive such a deed without losing their soul? */
== bdbelt @23 /* Despite <PRO_HISHER> Bhaal heritage, <CHARNAME> stood a shining beacon against the dangers we were facing, for the good of this city, of the whole Sword Coast! Let <CHARNAME>'s deeds be the base to judge <PRO_HIMHER> on! */
== BDCOMM90 @24 /* [male Bystander in public hearing SoD]Huzzah to our hero! Huzzah <CHARNAME>! You are the city's protector! */
END
IF ~~ THEN DO ~SetGlobal("bd_mdd1697_plot","global",10)~ EXTERN BDBELT 6

EXTEND_BOTTOM BDBELT 7 
IF ~Global("C#AfHSoD_RevisedEnd","GLOBAL",3)~ THEN + before_silvershield_commotion
END

APPEND BDBELT 
IF ~~ THEN before_silvershield_commotion
SAY @25 /* This is a day of victory! Now we - what is that commotion? */
COPY_TRANS bdbelt 13
END
END //APPEND

EXTEND_BOTTOM BDENTAR 0
IF ~GlobalGT("C#AfHSoD_RevisedEnd","GLOBAL",0)~ THEN + totalrevised_trialscene_04
END

CHAIN
IF ~~ THEN BDENTAR totalrevised_trialscene_04
@26 /* My Skie! She is gone... It wasn't enough to slay her bodily and leave me childless. The murderer of my Skie destroyed her soul, too! Do you hear me, you monster? I will get to you, wherever you are! */
DO ~SetGlobal("C#AfHSoD_RevisedEnd","GLOBAL",5)~
= #%eet_2%69799 /* ~Tell me what you did with it, fiend! Before they send you to the gallows, tell me, what did you do with the dagger?~ [BD69799] */
== BDBELT @27 /* Entar, whatever happened, let us first talk in quiet about it. */
== BDENTAR @28 /* <CHARNAME>! You got my little girl killed! She was with you, and now her soul is gone - she is lost forever! */
== bdbelt #%eet_2%70374 /* ~You do not want to do this, Entar...~ [BD70374] */
== bdentar @29 /* Do not tell me what I want - I KNOW what I want. I want the murderer of my little Skie... I want her soul back! */
== BDNOBL90 @30 /* [female Bystander in public hearing SoD]The Silvershield gal's soul disappeared? How is that even possible? */ 
== BDCOMM90 @31 /* [male Bystander in public hearing SoD]It's the Bhaalchild! It's <CHARNAME>! In Avernus <PRO_HESHE> made a pact with the fiends and now they are taking our souls! */ 
== BDNOBL90 @32 /* [female Bystander in public hearing SoD]<CHARNAME> is even more dangerous than Sarevok! The gods help us against this Bhaalchild! */
== BDCOMM90 @33 /* [male Bystander in public hearing SoD]No, <CHARNAME> is a hero! All praise <CHARNAME>, the Bhaalspawn who will rise above all others! */
END
IF ~~ THEN DO ~AddJournalEntry(@90000,QUEST)~ EXTERN bdentar 4

APPEND bdbelt
IF WEIGHT #-1 
~Global("C#AfHSoD_RevisedEnd","GLOBAL",5)~ totalrevised_trialscene_05
SAY @34 /* Despite the tragic events, this is a day for celebration! Everyone, feast in the knowledge of our victory! - <CHARNAME>, we need to go. Let us retreat before this gets any more out of hand. */
IF ~~ THEN DO ~SetGlobal("C#AfHSoD_RevisedEnd","GLOBAL",6) SetGlobal("bd_player_exiled","global",1)
StartCutSceneMode()
StartCutSceneEx("c#afh62",FALSE)~ EXIT
END
/* "c#afh62" teleports group to Dukes in Palace ground floor (custom area c#afh2) Parts taken from "bdcut62.bcs". SetGlobal("bd_player_exiled","global",1) needs to be set so other mods know the Dukes let PC go. */
END //APPEND

/* PC in palace ground floor */

/* first: Duke Belt and Silvershield. This meeting ends with the PC going alone to his room. */

BEGIN c#afhent

BEGIN c#afhblt
IF WEIGHT #-1
~Global("C#AfHSoD_RevisedEnd","GLOBAL",6)~ THEN inside_palace
SAY @35 /* <CHARNAME>, das Wissen um die Gefährlichkeit Eures Bhaalerbes breitet sich aus. Es geht das Gerücht um, dass Ihr in Avernus einen Pakt mit den Teufeln geschlossen hättet, um mächtiger zu werden. */
++ @36 /* You're not serious. */ + inside_palace_02
++ @37 /* Something like that was to be expected, I fear. */ + inside_palace_02
++ @38 /* You do not believe this yourself, do you? */ + inside_palace_01
++ @39 /* Hmm... not a bad idea indeed. Shame I didn't think of this sooner. */ + inside_palace_01
END

IF ~~ THEN inside_palace_01
SAY @40 /* We do believe these to be mere rumors. */
IF ~~ THEN + inside_palace_02
END

IF ~~ THEN inside_palace_02
SAY #%eet_2%69828 /* ~There are as many people in this city ready to fight and die for you as there are those baying for your blood. Baldur's Gate is in turmoil.~ [BD69828] */
= #%eet_2%69826 /* ~But you are the slayer of Sarevok. The hero of Baldur's Gate. The champion of Dragonspear. Your service to the Sword Coast is beyond dispute.~ [BD69826] */
= #%eet_2%69827 /* ~Unfortunately, your heritage is now also beyond dispute. There can be no peace for a child of Bhaal. Those near you will inevitably suffer, as Skie did—that is your nature.~ [BD69827] */
= #%eet_2%69829 /* ~After extensive deliberations, Eltan, Liia Jannath, and I have decided it would be best for all if you—and the darkness within you—left Baldur's Gate as quietly as possible.~ [BD69829] */
++ @41 /* Ich verstehe. Wenn es der Stadt hilft, zur Ruhe zu kommen, dann werde ich gehen. */ + inside_palace_03
++ @42 /* Ihr schickt mich fort? Einfach so, nach allem, was ich für Baldurs Tor getan habe? */ + inside_palace_03
++ @43 /* "As quietly as possible"? Ihr wollt nicht, dass ich wiederkomme, oder? */ + inside_palace_03
++ @44 /* Wo soll ich denn hin? */ + inside_palace_03
++ @45 /* Ihr habt mir gar nichts zu sagen. Ich bin der Held dieser Stadt und werde hierbleiben, solange ich will. */ + inside_palace_03
END

IF ~~ THEN inside_palace_03
SAY @46 /* Wir, die Herzöge dieser Stadt und alle bei klarem Verstand sind nicht blind gegenüber Euren außergewöhnlichen Errungenschaften für diese Stadt, <CHARNAME>. Aber wir müssen auch an die Sicherheit und den Frieden in Baldurs Tor denken - und dieser ist durch Eure Anwesenheit nun bedroht. Wenn Euch auch nur etwas an dieser Stadt liegt, dann bereitet Euch freiwillig auf eine Abreise vor. */
IF ~~ THEN + skie_implications
IF ~GlobalGT("C#AfH_PortalQuest","GLOBAL",0)~ THEN + portal_quest
END

IF ~~ THEN portal_quest
SAY @47 /* Wir schicken Euch nicht einfach fort. Wir haben einen sehr wichtigen Auftrag für Euch. Das Portal unter der Burg Drachenspeer - es ist noch immer schlafend. Blut mit göttlichem Einschlag könnte es jederzeit wieder wecken - Euer Blut, aber auch das eines anderen Bhaalkindes. Wir sitzen sprichwörtlich auf einem Pulverfass, das die Schwertküste weiterhin bedroht - und von dem nun obendrein viele wissen. */
= @48 /* Findet einen Weg, das Portal für immer zu verschließen, <CHARNAME>. Das ist die Aufgabe, die wir Euch stellen. Ihr seid der Held von Baldurs Tor - werdet diesem Namen gerecht und befreit uns von dieser Gefahr. Beweist im gleichen Zug, dass niemand hier sich vor Euch und Eurem Bhaalerbe fürchten muss. */
++ @49 /* Das werde ich gerne tun. Habt Ihr Hinweise, wie ich vorgehen soll? */ + portal_quest_02
++ @50 /* Wie stellt ihr Euch das vor? */ + portal_quest_02
++ @51 /* Ach, das Blut des Höheren Teufels aus Avernus selbst zu besorgen hat noch nicht gereicht, ja? */ + portal_quest_01
++ @52 /* Ich sehe nicht, warum ich das machen sollte. */ + portal_quest_01
++ @53 /* Ich gehe, wenn Ihr darauf besteht und mich fortschickt, aber das Portal ist Euer Problem. */ + portal_quest_01
++ @54 /* Ihr habt mir gar nichts zu befehlen. */ + portal_quest_01
END

IF ~~ THEN portal_quest_01
SAY @55 /* Wir können Euch nicht dazu zwingen, das Portal zu schließen. Aber seid Euch gewiss, dass es die Voraussetzung dafür ist, dass Ihr hier wieder unbeschwert durch die Straßen wandeln könnt. Helft Ihr uns nicht, die Gefahr durch das Portal zu bannen, dann können wir Euch hier nicht mehr willkommen heißen - dem Frieden in dieser Stadt zuliebe. */ 
IF ~~ THEN + portal_quest_02
END

IF ~~ THEN portal_quest_02
SAY @56 /* Euer Weg wird Euch als erstes nach Amn leiten - das Land, mit dem Ihr uns vor einem Krieg bewahrt habt. Die Magier, die sich am besten mit dem Verschließen von Portalen auskennen, werden Incantatrices genannt, und Ihr werdet sie in Amn finden. */
= @57 /* Nehmt dieses Schreiben. Es ist an den Botschafter der Verhüllten Magier in Athkatla, der Hauptstadt von Amn, gerichtet. Dieses Schreiben macht es deutlich, dass es sich um ein Gesuch der Herzöge von Baldurs Tor handelt und mit der entsprechenden Dringlichkeit behandelt werden sollte. */
= @58 /* Wir werden parallel zu Eurer Reise die Autoritäten in Athkatla von Eurem Erscheinen informieren - nicht bezüglich Eures Bhaalerbes oder was hier geschah, sondern als Abgesandter auf der Suche nach einem Weg, das Portal für immer zu schließen. */
IF ~~ THEN DO ~GiveItemCreate("c#afhpss",Player1,1,0,0) SetGlobal("C#AfHSoD_RevisedEnd","GLOBAL",7)
SetGlobal("C#AfH_PortalQuest","GLOBAL",2)~ UNSOLVED_JOURNAL @90001 + skie_implications
END

IF ~~ THEN skie_implications
SAY @59 /* Damit wären wir bei der zweiten Sache. Skies Seele ist verschwunden, und das hat unter den Leuten zu den wildesten Verschwörungen über Eure Rolle darin geführt, die die erwähnten Gerüchte noch befeuert haben. Einige glauben, dass Ihr in Avernus für einen Pakt mit den Teufeln die Seelen der Bürger von Baldurs Tor verkauft hättet. */
++ @60 /* (seufz) */ + skie_implications_03
++ @61 /* Was genau ist denn mit Skies Seele geschehen? */ + skie_implications_03
++ @62 /* Ich habe damit nichts zu tun, das wisst Ihr hoffentlich. */ + skie_implications_02
+ ~GlobalGT("C#AfH_PortalQuest","GLOBAL",0)~ + @63 /* Hmm, that's not a bad idea, actually. You said the portal can be repopened with my blood? */ + skie_implications_01
END

IF ~~ THEN skie_implications_01
SAY @64 /* This is not a joking matter! */
IF ~~ THEN + skie_implications_03
END

IF ~~ THEN skie_implications_02
SAY @65 /* [Duke Belt]We know from Corporal Duncan that he found you unconscious at the crime scene, while the murder weapon was missing. */
IF ~~ THEN + skie_implications_03
END

IF ~~ THEN skie_implications_03
SAY #%eet_2%69810 /* ~Peering into the Weave, our diviners determined that Skie Silvershield's soul now languishes within an artifact called the Soultaker Dagger. All efforts to locate the dagger have amounted to naught.~ [BD69810] */
= #%eet_2%69811 /* ~While her essence is imprisoned thus, Skie can never be returned to life. If we had the Soultaker, she might possibly be restored, and confirm your innocence—if indeed you are innocent.~ [BD69811] */
++ @66 /* So you do doubt my innocence on Skie's fate? */ + totalrevised_accusations_02
++ @67 /* This is horrible! I am so sorry. */ + totalrevised_accusations_02
++ @68 /* What will we do now? */ + totalrevised_accusations_02
++ @69 /* Why would I care? */ + totalrevised_accusations_01
END

IF ~~ THEN totalrevised_accusations_01
SAY @70 /* [Duke Belt]Do not take this lightly, <CHARNAME>. */
IF ~~ THEN + totalrevised_accusations_02
END

IF ~~ THEN totalrevised_accusations_02
SAY @71 /* We do believe that you were a victim in this yourself - but that it was clearly you who was the real target of this attack, not Skie. Your guilt in this is not about what you did, but what you *are*. */
IF ~~ THEN + skie_implications_04
END

IF ~~ THEN skie_implications_04
SAY @72 /* What do you know about the whereabouts of the murder weapon, the Soultaker dagger? */
  IF ~  OR(2)
CheckStatGT(Player1,16,INT)
CheckStatGT(Player1,16,WIS)
~ THEN REPLY #%eet_2%69800 /* ~Dagger...? There was a dagger, I remember. What became of it I do not know. ~ */ + silvershield_plea
  + ~CheckStatLT(Player1,17,INT)
CheckStatLT(Player1,17,WIS)~ + @73 /* I do not remember there being a dagger. */ + silvershield_plea
  IF ~~ THEN REPLY #%eet_2%69802 /* ~What are you going on about? I know nothing of any dagger.~ */ + silvershield_plea
  IF ~~ THEN REPLY #%eet_2%69803 /* ~I have nothing to say to you.~ */ + silvershield_plea
END

/* the following will allow only one romance interest to speak (in case the player has a multi romance tweak), but it will at least not let the dialogue break in case multi romances are active */
IF ~~ THEN byefornow_01
SAY @74 /* Help us, <CHARNAME>, and there will be a chance the city comes to rest again. Do what we requested of you and we *will* be able to soothe any remaining riots that are occuring in your name on our city's street. */
IF ~~ THEN + byefornow_02
IF ~Global("bd_corwin_romanceactive","global",2)~ THEN DO ~ActionOverride("Corwin",SetDialog("BDSCHAE2"))~ + byefornow_02
IF ~Global("bd_dorn_romanceactive","global",2)~ THEN DO ~ActionOverride("Dorn",SetDialog("bddorn"))~ + byefornow_02
IF ~Global("bd_glint_romanceactive","global",2)~ THEN DO ~ActionOverride("Glint",SetDialog("bdglint"))~ + byefornow_02
IF ~Global("bd_neera_romanceactive","global",2)~ THEN DO ~ActionOverride("Neera",SetDialog("bdneera"))~ + byefornow_02
IF ~Global("bd_rasaad_romanceactive","global",2)~ THEN DO ~ActionOverride("Rasaad",SetDialog("bdrasaad"))~ + byefornow_02
IF ~Global("bd_safana_romanceactive","global",2)~ THEN DO ~ActionOverride("Safana",SetDialog("bdsafana"))~ + byefornow_02
IF ~Global("bd_viconia_romanceactive","global",2)~ THEN DO ~ActionOverride("Viconia",SetDialog("bdviconi"))~ + byefornow_02
IF ~Global("bd_voghiln_romanceactive","global",2)~ THEN DO ~ActionOverride("Voghiln",SetDialog("bdvoghil"))~ + byefornow_02
END


CHAIN
IF ~~ THEN c#afhblt byefornow_02
@75 /* Wir werden den heutigen Tag nutzen, um Vorbereitungen für Eure Abreise zu treffen. Ihr werdet nicht ohne Ausrüstung und auch nicht ohne Unterstützung gehen müssen. */
== c#afhblt IF ~!InMyArea("%IMOEN_DV%") !Dead("%IMOEN_DV%")~ THEN @76 /* Imoen, Eure Freundin aus Kindheitstagen, ist bereits jetzt unterwegs, um weitere Reisegefährten zu finden. */
= @77 /* Sortiert Eure Ausrüstung und ruht Euch noch einmal aus. Morgen früh werden wir Euch unbemerkt aus der Stadt bringen. */ DO ~SetGlobal("C#AfHSoD_RevisedEnd","GLOBAL",8)~

/* non default NPCs say good-bye */
== bdcorwij IF ~!Global("bd_corwin_romanceactive","global",2) InMyArea("Corwin") InParty("Corwin") !StateCheck("Corwin",CD_STATE_NOTVALID)~ THEN @78 /* [Captain Corwin]Duty calls me, <CHARNAME> - not all of us can just leave when tides get too high. I guess I will stay near until this is over. */
== bdjaheij IF ~InMyArea("Jaheira") InParty("Jaheira") !StateCheck("Jaheira",CD_STATE_NOTVALID)~ THEN @79 /* [Jaheira]You came a long way. We promised Gorion to watch over you, and you outgrew any help we could give you to fight your foes. From now on, it will be we watching you so you will not succumb to your heritage. */
== bdkhalij IF ~InMyArea("Khalid") InParty("Khalid") !StateCheck("Khalid",CD_STATE_NOTVALID) !Dead("Jaheira")~ THEN @80 /* [Khalid]G-Gorion would be proud of your achievements. We will come with you and help with the t-task the Dukes gave you. */
== bdkhalij IF ~InMyArea("Khalid") InParty("Khalid") !StateCheck("Khalid",CD_STATE_NOTVALID) Dead("Jaheira")~ THEN @81 /* [Khalid]G-Gorion would be proud of your achievements. I will come with you and help with the t-task the Dukes gave you. */
== bddynahj IF ~InMyArea("Dynaheir") InParty("Dynaheir") !StateCheck("Dynaheir",CD_STATE_NOTVALID)~ THEN @82 /* [Dynaheir]A mighty Bhaalspawn you became. Your journey is not over, and so is not ours, either. */
== bdminscj IF ~InMyArea("Minsc") InParty("Minsc") !StateCheck("Minsc",CD_STATE_NOTVALID)~ THEN @83 /* [Minsc]Boo is sad that little Skie is dead. There will be more evil to kick, and Boo said that this is something Minsc should look foreward to. */
== bdglintj IF ~!Global("bd_glint_romanceactive","global",2) InMyArea("Glint") InParty("Glint") !StateCheck("Glint",CD_STATE_NOTVALID)~ THEN @84 /* [Glint]Ah, this is goodbye I think, <CHARNAME>. I will head my own may and tell the great story of <CHARNAME> to all family along the Sword Coast! */
== bdrasaaj IF ~!Global("bd_rasaad_romanceactive","global",2) InMyArea("Rasaad") InParty("Rasaad") !StateCheck("Rasaad",CD_STATE_NOTVALID)~ THEN @85 /* [Rasaad]Duty calls me, <CHARNAME>. We will meet again, I am sure of it. */
== bdbaeloj IF ~InMyArea("Baeloth") InParty("Baeloth") !StateCheck("Baeloth",CD_STATE_NOTVALID)~ THEN @86 /* [Baeloth]Complications, complications - I'll be on my way then. */
== bdviconj IF ~!Global("bd_viconia_romanceactive","global",2) InMyArea("Viconia") InParty("Viconia") !StateCheck("Viconia",CD_STATE_NOTVALID)~ THEN @87 /* [Viconia]Travelling with you no longer grants the protection I need, <CHARNAME>. I will go on my own from here. */
== bdvoghij IF ~!Global("bd_voghiln_romanceactive","global",2) InMyArea("Voghiln") InParty("Voghiln") !StateCheck("Voghiln",CD_STATE_NOTVALID)~ THEN @88 /* [Voghiln]Let us have a mug of ale together when you'll be in town, <CHARNAME>. Until then, this scald will go his own way again! */
== bdmkhiij IF ~InMyArea("MKhiin") InParty("MKhiin") !StateCheck("MKhiin",CD_STATE_NOTVALID)~ THEN @89 /* [MKhiin]<CHARNAME> has all the attention now. M'Khiin prefers to be in the shadows. Our paths will separate here. */
== bdedwinj IF ~InMyArea("Edwin") InParty("Edwin") !StateCheck("Edwin",CD_STATE_NOTVALID)~ THEN @90 /* [Edwin]We were victorious! (Well, that wasn't a suprise, considering I was part of it.) Now, I need to take care of my own things - before the name of Edwin the Red Wizard will be besmudged by those silly rumors those mindless apes are spreading. */
== bdsafanj IF ~!Global("bd_safana_romanceactive","global",2) InMyArea("Safana") InParty("Safana") !StateCheck("Safana",CD_STATE_NOTVALID)~ THEN @91 /* [Safana]I'll be somewher else, <CHARNAME> - away from all the attention of assassins and murderers. See you around! */
== bddornj IF ~!Global("bd_dorn_romanceactive","global",2) InMyArea("Dorn") InParty("Dorn") !StateCheck("Dorn",CD_STATE_NOTVALID)~ THEN @92 /* [Dorn]I have a call I need to follow, <CHARNAME>. Hiding and fleeing like a coward is not part of that. Farewell. */
== bdneeraj IF ~!Global("bd_neera_romanceactive","global",2) InMyArea("Neera") InParty("Neera") !StateCheck("Neera",CD_STATE_NOTVALID)~ THEN @93 /* [Neera]Er... I'll go on my own, <CHARNAME>. I'll have my own quest to see through, and I don't want to end like Skie there - pretty dead, you know. You go revive Skie and fight off more assassins, or whatever it will be that you do. I'm sure you'll manage without me. See you. */
== bdimoen IF ~InParty("%IMOEN_DV%") InMyArea("%IMOEN_DV%") !StateCheck("%IMOEN_DV%",CD_STATE_NOTVALID)~ THEN @216 /* ~[Imoen]You just rest here, <CHARNAME>, okay? I'll go and have a look around who of our old friends might still be around. This is important things we have to do!~ */
END
IF ~~ THEN EXIT
/* romance candidates will give goodbye dialogues here if they are in the group */
IF ~Global("bd_corwin_romanceactive","global",2)~ THEN DO ~SetGlobal("C#AfHSoD_RIdone","GLOBAL",1)~ EXTERN BDSCHAE2 0_changes
IF ~Global("bd_dorn_romanceactive","global",2)~ THEN DO ~SetGlobal("C#AfHSoD_RIdone","GLOBAL",1)~ EXTERN bddorn 51_changes
IF ~Global("bd_glint_romanceactive","global",2)~ THEN DO ~SetGlobal("C#AfHSoD_RIdone","GLOBAL",1)~ EXTERN bdglint 28_changed
IF ~Global("bd_neera_romanceactive","global",2)~ THEN DO ~SetGlobal("C#AfHSoD_RIdone","GLOBAL",1)~ EXTERN bdneera 120_revised_changes
IF ~Global("bd_rasaad_romanceactive","global",2)~ THEN DO ~SetGlobal("C#AfHSoD_RIdone","GLOBAL",1)~ EXTERN bdrasaad 80_changes
IF ~Global("bd_safana_romanceactive","global",2)~ THEN DO ~SetGlobal("C#AfHSoD_RIdone","GLOBAL",1)~ EXTERN bdsafana 106_changes
IF ~Global("bd_viconia_romanceactive","global",2)~ THEN DO ~SetGlobal("C#AfHSoD_RIdone","GLOBAL",1)~ EXTERN bdviconi 36_changes
IF ~Global("bd_voghiln_romanceactive","global",2)~ THEN DO ~SetGlobal("C#AfHSoD_RIdone","GLOBAL",1)~ EXTERN bdvoghil 75_changes


/* All NPCs except BGII default crew leave and PC gets teleported into PC's quarters.  player's and Imoen's chests should collect their things... */

CHAIN
IF ~~ THEN c#afhblt silvershield_plea
@94 /* Duke Silvershield is here as a father in turmoil, <CHARNAME>. Listen to what he has to say. */
== c#afhent @95 /* You! <CHARNAME>! You have to hunt the murderer... You are the only one who was there. Surely you will remember who did it. Go after the murderer and find my little Skie's soul! A father begs of you, <CHARNAME>. My little girl... my Skie... */
END
  IF ~~ THEN REPLY #%eet_2%69795 /* ~I don't know what happened to Skie. But I intend to find out.~ */ DO ~SetGlobal("C#AfH_SouldaggerQuest","GLOBAL",1)
//#70073 Skie's Soul
AddJournalEntry(@90002,QUEST)
AddJournalEntry(@90003,QUEST)~ EXTERN c#afhblt byefornow_01
++ @96 /* I can't promise anything. */ DO ~SetGlobal("C#AfH_SouldaggerQuest","GLOBAL",1)
AddJournalEntry(@90002,QUEST)
AddJournalEntry(@90003,QUEST)~ EXTERN c#afhblt byefornow_01
  IF ~~ THEN REPLY #%eet_2%69796 /* ~Cease your whimpering, man. You're embarrassing yourself.~ */ DO ~SetGlobal("C#AfH_SouldaggerQuest","GLOBAL",1)
AddJournalEntry(@90002,QUEST)
AddJournalEntry(@90003,QUEST)~ EXTERN c#afhblt byefornow_01


/* PC is free to roam the room, sort their gear etc. but can't leave the level. Clicking on the bed will trigger a rest if all visitors are done. Hooded Man will come *after* the sleeping - it's illogical that the PC would just go to bed after having that visit. */
/* I tried to be as true to the original dialogues as possible. I'm not fond of circumventing all the existing dialogue states but using existing states would have been a mess and since this happens without NPCs present this will not eat any NPC replies. */

/* Visits */
/* romance interests will visit if they weren't in group */

/* visit of Corwin. She will come always, also if romance dialogue already played downstairs. If she wasn't in group, only the romance dialogue will play. */

/* Corwin, romance case */

/* set her dialogue back to joined in case this dialogue happens inside the first level of the palace whit Corwin in the group */
EXTEND_BOTTOM BDSCHAE2 20
IF ~Inparty(Myself) AreaCheck("c#afh2")~ THEN DO ~SetDialog("bdcorwij")~ EXIT
END
EXTEND_BOTTOM BDSCHAE2 21
IF ~Inparty(Myself) AreaCheck("c#afh2")~ THEN DO ~SetDialog("bdcorwij")~ EXIT
END
EXTEND_BOTTOM BDSCHAE2 23
IF ~Inparty(Myself) AreaCheck("c#afh2")~ THEN DO ~SetDialog("bdcorwij")~ EXIT
END
EXTEND_BOTTOM BDSCHAE2 24
IF ~Inparty(Myself) AreaCheck("c#afh2")~ THEN DO ~SetDialog("bdcorwij")~ EXIT
END

APPEND BDSCHAE2
IF WEIGHT #-1
~AreaCheck("c#afh3")
Global("C#AfH_jail_visitors","c#afh3",2)
Global("C#AfHSoD_RIdone","GLOBAL",0)
Global("bd_corwin_romanceactive","global",2)
~ THEN BEGIN 0_changes
  SAY #%eet_2%54610 /* ~<CHARNAME>. How are you?~ [BD54610] */
/* not in group (c#afh3.are - set variables */
  IF ~!InParty(Myself)~ THEN REPLY #%eet_2%54611 /* ~I've had better days.~ */ DO ~SetGlobal("C#AfH_jail_visitors","c#afh3",6)
SetGlobal("C#AfH_visit_player","locals",1)
~ GOTO 1_revised_changes
  IF ~!InParty(Myself)~ THEN REPLY #%eet_2%54612 /* ~Corwin. Thank the gods. You've got to get me out of here.~ */ DO ~SetGlobal("bd_jail_visitors","c#afh3",6)
SetGlobal("C#AfH_visit_player","locals",1)
~ GOTO 6_changes
  IF ~!InParty(Myself)~ THEN REPLY #%eet_2%54613 /* ~You shouldn't be here, Corwin. Go, now.~ */ DO ~SetGlobal("bd_jail_visitors","c#afh3",6)
SetGlobal("C#AfH_visit_player","locals",1)
~ GOTO 22_changes

/* if in group (c#afh2.are) - no variable setting */
  IF ~InParty(Myself)~ THEN REPLY #%eet_2%54611 /* ~I've had better days.~ */ GOTO 1_revised_changes
  IF ~InParty(Myself)~ THEN REPLY @97 /* Schael, please come with me when I'll leave tomorrow. */ GOTO 6_changes
  IF ~InParty(Myself)~ THEN REPLY #%eet_2%54613 /* ~You shouldn't be here, Corwin. Go, now.~ */ GOTO 22_changes
END

IF ~~ THEN BEGIN 1_revised_changes
  SAY @98 /* You could have worse. Eltan and Belt moved mountains trying to calm the people and keeping you out of their reach. */
  IF ~~ THEN REPLY @99 /* I need your help, Schael. Come with me. Let us find Skie Silvershield's killer together. Please. */ GOTO 6_changes
  IF ~~ THEN REPLY #%eet_2%54617 /* ~If you expect me to thank the Grand Dukes for their hospitality, you're going to be gravely disappointed.~ */ GOTO 4_revised_changes
  IF ~~ THEN REPLY @100 /* Let the people come. I'll send them to wherever Caelar is now. */ GOTO 2_changes
END

IF ~~ THEN BEGIN 2_changes
  SAY #%eet_2%54619 /* ~Gods help me. How could I have missed this? How did I never see you for the monster you are?~ [BD54619] */
  IF ~~ THEN GOTO 14_changes
END

IF ~~ THEN BEGIN 3_revised_changes
  SAY @101 /* You threw the city in chaos. You threaten what I treasure the most - the safety and peace of the people in this city. */
  IF ~~ THEN GOTO 13_changes
END

IF ~~ THEN BEGIN 4_revised_changes 
  SAY #%eet_2%54620 /* ~I was gravely disappointed before I ever came here.~ [BD54620] */
  ++ @102 /* In me? Why? */ + 3_revised_changes
  IF ~~ THEN REPLY #%eet_2%70317 /* ~I'm truly sorry you've had to endure this, Schael.~ */ GOTO 13_changes
  IF ~~ THEN REPLY #%eet_2%54621 /* ~Yet you did come here. Why?~ */ GOTO 8_changes
  IF ~~ THEN REPLY #%eet_2%54622 /* ~I'm not thrilled myself.~ */ GOTO 11_changes
  IF ~~ THEN REPLY @103 /* And yet here you are. Why? Not to come with me, I presume. You'd never defy your beloved Flaming Fist. */ GOTO 5_changes
  IF ~!InParty(Myself)~ THEN REPLY #%eet_2%70319 /* ~And so you came here seeking solace. I've none to give, and wouldn't offer it to you even if I did. Get out. You sicken me. Go!~ */ GOTO 23
  IF ~InParty(Myself)~ THEN REPLY @104 /* And so you are here seeking solace. I've none to give, and wouldn't offer it to you even if I did. Get out. You sicken me. Go! */ GOTO 23
END

IF ~~ THEN BEGIN 5_changes
  SAY #%eet_2%54625 /* ~I would have, you know. If you'd asked me, I would have followed you anywhere, happily. It wasn't so long ago.~ [BD54625] */
  IF ~~ THEN GOTO 14_changes
END

IF ~~ THEN BEGIN 6_changes
  SAY #%eet_2%54626 /* ~I can't do it. I'm sorry, <CHARNAME>. There's only one way you're leaving here.~ [BD54626] */
  ++ @105 /* You mean without you, I guess. It doesn't have to be this way! I believe in us, Corwin. */ + 7_changes
  IF ~~ THEN REPLY #%eet_2%54628 /* ~We can leave here together—take Rohma and go some place no one will ever find us. Please, Schael, don't give up. There's still a future for us—if you want it.~ */ GOTO 10_changes
  IF ~~ THEN REPLY @106 /* So it seems. Because you're obviously too scared to risk loving again. */ GOTO 23
  IF ~!InParty(Myself)~ THEN REPLY #%eet_2%54630 /* ~If you've not come to help me, why are you here?~ */ GOTO 8_changes
END

IF ~~ THEN BEGIN 7_changes
  SAY #%eet_2%54631 /* ~I don't know what to believe anymore.~ [BD54631] */
  IF ~~ THEN GOTO 13_changes
END

IF ~~ THEN BEGIN 8_changes
  SAY #%eet_2%70320 /* ~I needed to see you one last time. Needed to tell you how I feel...~ */
  IF ~~ THEN GOTO 9_changes
END

IF ~~ THEN BEGIN 9_changes
  SAY #%eet_2%70321 /* ~It doesn't matter. I wish it did, but in the end, it doesn't.~ [BD70321] */
  IF ~~ THEN GOTO 14_changes
END

IF ~~ THEN BEGIN 10_changes
  SAY #%eet_2%54636 /* ~You think I'd turn my back on the Flaming Fist? On my father? I thought you knew me.~ [BD54636] */
  IF ~~ THEN GOTO 14_changes
END

IF ~~ THEN BEGIN 11_changes
  SAY #%eet_2%54637 /* ~I could kill you, <CHARNAME>. If it weren't for Rohma, I'd do it, you know. I would. You need to know how angry I am, to understand the rage I feel.~ [BD54637] */
  IF ~~ THEN REPLY @107 /* Wait, what? Why? What have I done? */ GOTO 12_revised_changes
  IF ~~ THEN REPLY #%eet_2%54639 /* ~I'm not exactly doing a jig here, you know. ~ */ GOTO 12_revised_changes
  IF ~~ THEN REPLY #%eet_2%54640 /* ~You come to me and speak of rage? Come closer, Corwin. I would touch you one last time, and show you what true rage is.~ */ GOTO 23
END

IF ~~ THEN BEGIN 12_revised_changes 
  SAY @108 /* Your glib tongue betrays you, <CHARNAME>. A city is in chaos, people are fighting over you in the streets, and all you offer is another quip. The city deserves better than that. As do I. */ 
  IF ~~ THEN GOTO 3_revised_changes
END

IF ~~ THEN BEGIN 13_changes
  SAY #%eet_2%54642 /* ~It doesn't matter. I wish it did, but in the end, it doesn't. If it weren't this, it would have been something else. I thought we could be together, that you and Rohma and I had a future...~ [BD54642] */
  IF ~~ THEN GOTO 14_changes
END

IF ~~ THEN BEGIN 14_changes 
  SAY #%eet_2%54643 /* ~Even after everything that's happened in my life, I'm still just a stupid girl, blinded by—whatever it was I thought we had.~ [BD54643] */
  IF ~~ THEN REPLY #%eet_2%54644 /* ~It was love, Schael. It was real.~ */ GOTO 16_changes
  IF ~~ THEN REPLY #%eet_2%54645 /* ~Love makes fools of us all.~ */ GOTO 16_changes
  IF ~~ THEN REPLY #%eet_2%54646 /* ~You know what we had. Deny it if you must. I know the truth.~ */ GOTO 17_changes
IF ~~ THEN EXIT //##
END

/* IF ~~ THEN BEGIN 15 */

IF ~~ THEN BEGIN 16_changes
  SAY #%eet_2%70322 /* ~I... believe you. And I love you, too. I hope you'll find some comfort in that. We're just two people. Our feelings mean little beyond these walls.~ */
  IF ~~ THEN GOTO 18_changes
END

IF ~~ THEN BEGIN 17_changes
  SAY #%eet_2%70323 /* ~I'll not deny my feelings for you. Not ever. But how I feel means little beyond these walls.~ */
  IF ~~ THEN GOTO 18_changes
END

IF ~~ THEN BEGIN 18_changes
  SAY #%eet_2%54648 /* ~Love conquers all. I'm not feeling particularly victorious right now. Are you?~ [BD54648] */
  IF ~~ THEN REPLY #%eet_2%54649 /* ~I don't. But I still have hope.~ */ GOTO 20
  IF ~~ THEN REPLY #%eet_2%70325 /* ~So long as you love me, I have hope.~ */ GOTO 20
  IF ~~ THEN REPLY #%eet_2%54650 /* ~Don't turn away from me, Schael. I need you.~ */ GOTO 24
  IF ~~ THEN REPLY @109 /* I'll say it one more time. Come with me, Schael. Please. */ GOTO 21
END

/* IF ~~ THEN BEGIN 20 unchanged */

/* IF ~~ THEN BEGIN 21 unchanged */

IF ~~ THEN BEGIN 22_changes
  SAY #%eet_2%54653 /* ~We had something, didn't we? I wasn't just fooling myself.~ [BD54653] */
  IF ~~ THEN REPLY #%eet_2%54654 /* ~We had everything. And whoever stole it from us will pay a terrible price.~ */ GOTO 23
  IF ~~ THEN REPLY #%eet_2%54655 /* ~If you fooled yourself, I did the same.~ */ GOTO 24
  IF ~~ THEN REPLY @110 /* You tell me. What you do for me here and now - or don't do for me - will let us both know how deep and true your feelings are. */ GOTO 24
END

/* IF ~~ THEN BEGIN 23 unchanged */

/* IF ~~ THEN BEGIN 24 unchanged */




/* Corwin, non-romance case. The devs wanted her to want the PC to sacrifice temselves, so I'll have her set her mind on that, too. */

IF WEIGHT #-1
~AreaCheck("c#afh3")
Global("C#AfH_jail_visitors","c#afh3",2)
OR(2)
	!Global("bd_corwin_romanceactive","global",2)
	Global("C#AfHSoD_RIdone","GLOBAL",1)
~ THEN BEGIN 25_changed
  SAY #%eet_2%39419 /* ~Good morning, <CHARNAME>.~ [BD39419] */
  IF ~~ THEN REPLY #%eet_2%39420 /* ~Is it morning? It's hard to tell in here.~ */ DO ~SetGlobal("C#AfH_jail_visitors","c#afh3",3)
SetGlobal("C#AfH_visit_player","locals",1)
~ GOTO 30_changed
  IF ~~ THEN REPLY #%eet_2%39421 /* ~You're half right. Why have you come here?~ */ DO ~SetGlobal("C#AfH_jail_visitors","c#afh3",3)
SetGlobal("C#AfH_visit_player","locals",1)
~ GOTO 31_changed
  IF ~~ THEN REPLY #%eet_2%39425 /* ~Why are you here?~ */ DO ~SetGlobal("C#AfH_jail_visitors","c#afh3",3)
SetGlobal("C#AfH_visit_player","locals",1)
~ GOTO 31_changed
END

IF ~~ THEN BEGIN 30_changed
  SAY #%eet_2%39437 /* ~I'm not here to discuss the time. I'm here to ask you to end this madness. The city's endured much of late—the iron crisis, Sarevok, the crusade... Now this.~ */
  IF ~~ THEN GOTO 32_revised_changed
END

IF ~~ THEN BEGIN 31_changed
  SAY #%eet_2%39438 /* ~I'm here to ask you to end this madness. The city's endured much of late—the iron crisis, Sarevok, the crusade... Now this.~ */
  IF ~~ THEN GOTO 32_revised_changed
END

IF ~~ THEN BEGIN 32_revised_changed
  SAY @101 /* You threw the city in chaos. You threaten what I treasure the most - the safety and peace of the people in this city. */
= @111 /* The dark days must end. And they won't, not with you hiding and leaving, all in secret. If you care for Baldur's Gate, even a little... admit your responsibility for what is happening outside right now. Go out and accept the punishment given to you by the ones trying to hold the peace in this city. Show the teffified people that you are not an immortal, godly being. */ 
++ @112 /* You are seriously expecting me to sacrifice my life - for bringing peace to Baldur's Gate? */ + 35_changed
  IF ~~ THEN REPLY #%eet_2%39440 /* ~I've fought and bled for Baldur's Gate. I've nearly died for it more times than I can count. I care about the city—but I also care about justice.~ */ + 33_revised_changed
++ @113 /* You even sure this would work the way you intended?... */ + 38_changed
  IF ~~ THEN REPLY #%eet_2%39442 /* ~You'd have me throw myself on the sword for what? The benefit of those who betrayed me?~ */ GOTO 38_changed
  IF ~~ THEN REPLY #%eet_2%39441 /* ~I'd be more than happy to declare my innocence while languishing somewhere else.~ */ GOTO 35_changed
END

IF ~~ THEN BEGIN 33_revised_changed
  SAY @114 /* It doesn't matter. The city is all that matters now. My father taught me that a hero - a real hero - is prepared to sacrifice <PRO_HIMHER>self for the greater good. They called you the hero of Baldur's Gate. Now you have the chance to earn the name. */ 
  IF ~~ THEN GOTO 34_changed
END

IF ~~ THEN BEGIN 34_changed
  SAY #%eet_2%59733 /* ~Goodbye, <CHARNAME>.~ */
  IF ~~ THEN DO ~AddJournalEntry(@90004,QUEST)~ EXIT
END

IF ~~ THEN BEGIN 35_changed
  SAY #%eet_2%39445 /* ~You don't get it, do you? You can't see beyond yourself to understand what's truly at stake here. This isn't about you. It's about Baldur's Gate. The city's been through so much of late—the iron crisis, Sarevok, the crusade... and now this.~ */
  IF ~~ THEN GOTO 33_revised_changed
END

IF ~~ THEN BEGIN 38_changed
  SAY #%eet_2%39448 /* ~For the benefit of those who still believe in you. They called you the hero of Baldur's Gate. A true hero will sacrifice <PRO_HIMHER>self for the greater good. Give the city a chance to heal. Please.~ */
  IF ~~ THEN GOTO 34_changed
END

END //APPEND



/* Visit other romance interests. Remove their accusations. 
Global("bd_player_exiled","global",1) is set so I don't need to account for the reply options that assume the PC is found guilty. */

/* Dorn. Take the focus away from the murder. He'll much more enjoy the general riots on the streets. The play of innuendo about the chains needed to go. Sorry. */

/* set his dialogue back to joined in case this dialogue happens inside the first level of the palace whith Dorn in the group */
EXTEND_BOTTOM BDDORN 62
IF ~Inparty(Myself) AreaCheck("c#afh2")~ THEN DO ~SetDialog("bddornj")~ EXIT
END

APPEND BDDORN

IF WEIGHT #-1
~AreaCheck("c#afh3")
Global("chapter","global",13)
Global("C#AfH_jail_visitors","c#afh3",5)
Global("bd_dorn_romanceactive","global",2)
~ THEN BEGIN 51_changes
  SAY #%eet_2%54326 /* ~<CHARNAME>. ~ */
/* not in group (c#afh3.are) - set variables */
  IF ~!InParty(Myself)~ THEN REPLY #%eet_2%54327 /* ~Dorn. ~ */ DO ~SetGlobal("C#AfH_jail_visitors","c#afh3",6)
SetGlobal("bd_visit_player","locals",1)
~ GOTO 53_changes
  IF ~!InParty(Myself)~ THEN REPLY @115 /* I freed you once. It's time you returned the favor. I could use your help when leaving tomorrow. */ DO ~SetGlobal("C#AfH_jail_visitors","c#afh3",6)
SetGlobal("C#AfH_visit_player","locals",1)
~ GOTO 53_changes
  IF ~!InParty(Myself)~ THEN REPLY #%eet_2%54329 /* ~What are you doing here?~ */ DO ~SetGlobal("C#AfH_jail_visitors","c#afh3",6)
SetGlobal("C#AfH_visit_player","locals",1)
~ GOTO 53_changes
  IF ~!InParty(Myself)~ THEN REPLY #%eet_2%54330 /* ~I've nothing to say to you.~ */ DO ~SetGlobal("C#AfH_jail_visitors","c#afh3",6)
SetGlobal("C#AfH_visit_player","locals",1)
~ GOTO 54

/* if in group (c#afh2.are) - no variable setting */
  IF ~InParty(Myself)~ THEN REPLY #%eet_2%54327 /* ~Dorn. ~ */ GOTO 53_changes
  IF ~InParty(Myself)~ THEN REPLY @116 /* I could use your help when leaving tomorrow. */ GOTO 53_changes
  IF ~InParty(Myself)~ THEN REPLY #%eet_2%54330 /* ~I've nothing to say to you.~ */ GOTO 54
END

IF ~~ THEN BEGIN 53_changes
  SAY #%eet_2%54335 /* ~I came to express my admiration.~ */
  IF ~~ THEN GOTO 55_changes
END

IF ~~ THEN BEGIN 55_changes
  SAY #%eet_2%54337 /* ~I can hardly believe you had it in you. Yet again, Bhaalspawn, you impress me. You are more worthy than I'd imagined.~ */
  ++ @117 /* What exactly are you referring to? */ + 56_changes
  IF ~~ THEN REPLY @118 /* I've a confession. I didn't actually plan on anything that happens in the city currently. */ GOTO 58_changes
  IF ~~ THEN REPLY @119 /* Yes, that's me. Bhaalspawn number one, bringing cities to fall. */ GOTO 56_changes
  IF ~~ THEN REPLY @120 /* Are we talking about the riots in the city or the believe I took Skie's soul to sell it off to fiends? */ GOTO 63_changes
END

IF ~~ THEN BEGIN 56_changes
  SAY @121 /* The chaos! The destruction! There is riots and crimes all over the streets. I couldn't have served my lord any better than what you did, <CHARNAME>. */
IF ~~ THEN + 59_changes
END

IF ~~ THEN BEGIN 58_changes
  SAY #%eet_2%54343 /* ~That is disappointing, if it is true. Though it would explain your carelessness.~ */
  IF ~~ THEN GOTO 56_changes
END

IF ~~ THEN BEGIN 59_changes
  SAY @122 /* And the killing of the Duke's daughter on top of it. */
  IF ~~ THEN GOTO 63_changes
END

IF ~~ THEN BEGIN 61_changes
  SAY @123 /* Go, <CHARNAME>, bring chaos and death to other places like you did here. I will stay for you and harvest what you sowed, and I will do so in your name. */
  IF ~~ THEN GOTO 61
END

IF ~~ THEN BEGIN 63_changes
  SAY #%eet_2%54344 /* ~Though I approve of the murder, I cannot condone your sloppiness. Killing her so openly, splashing her blood around until you dripped with it... attractive, but sloppy.~ */
  IF ~~ THEN REPLY #%eet_2%54345 /* ~That's because I didn't actually kill her.~ */ GOTO 67_changes
  IF ~~ THEN REPLY #%eet_2%54346 /* ~You don't mind that I'm a murderer? You just don't like my technique?~ */ GOTO 67_changes
  IF ~~ THEN REPLY #%eet_2%54347 /* ~I'm sorry my murder doesn't meet your high standards.~ */ GOTO 67_changes
  ++ @124 /* Come with me when I'll leave, Dorn. */ + 61_changes
END

IF ~~ THEN BEGIN 67_changes
  SAY #%eet_2%54357 /* ~I wish it could be otherwise. The sight of you with Skie's blood plastering your shirt to your chest was... exciting.~ */
  IF ~~ THEN GOTO 61_changes
END

END //APPEND



/* Glint */

/* set his dialogue back to joined in case this dialogue happens inside the first level of the palace whith Glint in the group -> at exit state */

APPEND BDGLINT

IF WEIGHT #-1
~AreaCheck("c#afh3")
Global("chapter","global",13)
Global("C#AfH_jail_visitors","c#afh3",5)
Global("bd_glint_romanceactive","global",2)
~ THEN BEGIN 28_changed
  SAY #%eet_2%54825 /* ~Heya.~ [BD54825] */
/* not in group (c#afh3.are) - set variables */
  IF ~!InParty(Myself)~ THEN REPLY #%eet_2%54826 /* ~It's you, Glint. I feared—I was afraid I'd never see you again.~ */ DO ~SetGlobal("C#AfH_jail_visitors","c#afh3",6)
SetGlobal("C#AfH_visit_player","locals",1)
~ GOTO 45_changed
+ ~!InParty(Myself)~ + @125 /* I need to leave soon. Come with me, Glint. */ DO ~SetGlobal("C#AfH_jail_visitors","c#afh3",6)
SetGlobal("C#AfH_visit_player","locals",1)
~ + add_03
+ ~!InParty(Myself)~ + @126 /* I am being sent away from Baldur's Gate, but I don't want you to share this fate. This is goodbye. */ DO ~SetGlobal("C#AfH_jail_visitors","c#afh3",6)
SetGlobal("C#AfH_visit_player","locals",1)~ + add_04
  IF ~!InParty(Myself)~ THEN REPLY #%eet_2%54828 /* ~Go away, Glint. I don't want to talk to you.~ */ DO ~SetGlobal("C#AfH_jail_visitors","c#afh3",6)
SetGlobal("C#AfH_visit_player","locals",1)
~ GOTO 29_changed
  IF ~!InParty(Myself)~ THEN REPLY #%eet_2%54829 /* ~Don't. Don't say that word. It's not for you.~ */ DO ~SetGlobal("C#AfH_jail_visitors","c#afh3",6)
SetGlobal("C#AfH_visit_player","locals",1)
~ GOTO 29_changed

/* if in group (c#afh2.are) - no variable setting */
+ ~InParty(Myself)~ + @125 /* I need to leave soon. Come with me, Glint. */ + 48_changed
+ ~InParty(Myself)~ + @126 /* I am being sent away from Baldur's Gate, but I don't want you to share this fate. This is goodbye. */ + add_04
  IF ~InParty(Myself)~ THEN REPLY #%eet_2%54828 /* ~Go away, Glint. I don't want to talk to you.~ */ GOTO 29_changed
  IF ~InParty(Myself)~ THEN REPLY #%eet_2%54829 /* ~Don't. Don't say that word. It's not for you.~ */ GOTO 29_changed
END

IF ~~ THEN BEGIN 29_changed
  SAY #%eet_2%54830 /* ~Don't do this, <CHARNAME>. Not now.~ [BD54830] */
  IF ~~ THEN REPLY #%eet_2%54831 /* ~What would you have me do, then? Thrash and rage and scream at the injustice of it all?~ */ GOTO 31_changed
+ ~!InParty(Myself)~ + @125 /* I need to leave soon. Come with me, Glint. */ + add_03
+ ~InParty(Myself)~ + @125 /* I need to leave soon. Come with me, Glint. */ + 48_changed
++ @126 /* I am being sent away from Baldur's Gate, but I don't want you to share this fate. This is goodbye. */ + add_04
  IF ~~ THEN REPLY #%eet_2%54833 /* ~I said go. Get out of here!~ */ GOTO 42_changed
END

IF ~~ THEN BEGIN 31_changed
  SAY #%eet_2%54835 /* ~Do you think that would help?~ [BD54835] */
  IF ~~ THEN REPLY #%eet_2%54836 /* ~No.~ */ GOTO 32_changed
  IF ~~ THEN REPLY #%eet_2%54837 /* ~It couldn't hurt.~ */ GOTO 38_changed
+ ~!InParty(Myself)~ + @125 /* I need to leave soon. Come with me, Glint. */ + add_03
+ ~InParty(Myself)~ + @125 /* I need to leave soon. Come with me, Glint. */ + 48_changed
++ @126 /* I am being sent away from Baldur's Gate, but I don't want you to share this fate. This is goodbye. */ + add_04
++ #%eet_2%54828 /* ~Go away, Glint. I don't want to talk to you.~ */ GOTO 42_changed
END

IF ~~ THEN BEGIN 32_changed
  SAY #%eet_2%54839 /* ~I wouldn't, then.~ [BD54839] */
+ ~!InParty(Myself)~ + @125 /* I need to leave soon. Come with me, Glint. */ + add_03
+ ~InParty(Myself)~ + @125 /* I need to leave soon. Come with me, Glint. */ + 48_changed
++ @126 /* I am being sent away from Baldur's Gate, but I don't want you to share this fate. This is goodbye. */ + add_04
++ #%eet_2%54828 /* ~Go away, Glint. I don't want to talk to you.~ */ GOTO 42_changed
END

IF ~~ THEN BEGIN 38_changed
  SAY #%eet_2%54853 /* ~I'd give it a try, then. Eh, preferably after I leave.~ [BD54853] */
+ ~!InParty(Myself)~ + #%eet_2%54855 /* ~I assume you mean after WE leave.~ */ + add_03
+ ~InParty(Myself)~ + #%eet_2%54855 /* ~I assume you mean after WE leave.~ */ + 48_changed
++ @126 /* I am being sent away from Baldur's Gate, but I don't want you to share this fate. This is goodbye. */ + add_04
++ #%eet_2%54828 /* ~Go away, Glint. I don't want to talk to you.~ */ GOTO 42_changed
END

IF ~~ THEN BEGIN 41_revised_changed
  SAY @127 /* I could say I love you, and I wouldn't be lying. But I would be lying if I said I loved you more than I do living a family life. There's a lot of people on the streets who're clearly looking for any excuse to cut down a dashing gnome in the prime of his life if he'll associate himself with you. */ 
IF ~~ THEN + add_02
END

IF ~~ THEN BEGIN 42_changed
  SAY #%eet_2%54858 /* ~Goodbye. If we don't see each other again, I—I want you to know the time we spent together was, it was... I'm sorry. I can't do this. Forgive me. I can't.~ [BD54858] */
  IF ~~ THEN EXIT
  IF ~InParty(Myself)~ THEN DO ~SetDialog("bdglintj")~ EXIT
END

IF ~~ THEN BEGIN 44_changed
  SAY #%eet_2%70331 /* ~Good, that's good. Keep your spirits up.~ [BD70331] */
IF ~~ THEN + 41_revised_changed
END

IF ~~ THEN BEGIN 45_changed
  SAY #%eet_2%54861 /* ~You almost didn't. I needed some time to come to terms with what you—what they say you did. And I still haven't.~ [BD54861] */
IF ~~ THEN + add_01
END

IF ~~ THEN BEGIN 48_changed
  SAY #%eet_2%70334 /* ~I needed some time to come to terms with what you—what they say you did.~ [BD70334] */
  IF ~~ THEN GOTO add_01
END

IF ~~ THEN BEGIN 49_changed
  SAY #%eet_2%70335 /* ~I don't want to believe it either. So I won't.~ [BD70335] */
IF ~~ THEN + 41_revised_changed
END

IF ~~ THEN BEGIN 52_changed
  SAY #%eet_2%54866 /* ~You're a child of Bhaal. Is it possible you killed her without realizing?~ [BD54866] */
++ @128 /* Gods, Glint, is that what you are asking yourself? It's me - <CHARNAME>! You know me. I haven't changed! */ + 44_changed
  IF ~~ THEN REPLY #%eet_2%54867 /* ~I don't want to believe it. But... I can't lie to you, Glint. I don't know. Once, I thought myself free of my father's influence. Now I question everything I've ever seen and done.~ */ GOTO 49_changed
  IF ~~ THEN REPLY #%eet_2%54868 /* ~I can't deny the possibility. I really want to, though.~ */ GOTO 49_changed
  IF ~~ THEN REPLY #%eet_2%54869 /* ~I was born to murder. These hands were made to kill. My eyes were made to watch my victims clutch desperately for life as it slips away, my ears to hear their final rattling breath. To kill someone and not know it? Impossible.~ */ GOTO 54_changed
END

IF ~~ THEN BEGIN 54_changed
  SAY #%eet_2%54871 /* ~So you didn't kill her because you'd enjoy killing her too much not to take credit for killing her if you had killed her. I'll be honest: That's not the strongest defense I've ever heard.~ [BD54871] */
IF ~~ THEN + 41_revised_changed
END

IF ~~ THEN add_01
SAY @129 /* Of course I know that you didn't sell our souls to the fiends. And I also know that you do not strive to devour the city to become more powerful. I also do not believe that you killed Skie, although it was a shock, seeing you with her like that. But... */
IF ~~ THEN + 52_changed
END

IF ~~ THEN add_02
SAY @130 /* You know I set out to check on my family and relatives. I'm a family man, really - and that's hard to do if one needs to hide and flee. I am sorry, <CHARNAME>. */
IF ~~ THEN + 42_changed
END

IF ~~ THEN add_03
SAY @131 /* I know the Dukes want you to leave. Imoen already asked me to come with you, but... I won't, <CHARNAME>. */
IF ~~ THEN + 48_changed
END

IF ~~ THEN add_04
SAY @132 /* You're making what I want to tell you much easier. */
IF ~~ THEN + add_03
IF ~InParty(Myself)~ THEN + 48_changed
END

END //APPEND




/* Neera */
/* set her dialogue back to joined in case this dialogue happens inside the first level of the palace whith Neera in the group */
EXTEND_BOTTOM BDNEERA 123
IF ~Inparty(Myself) AreaCheck("c#afh2")~ THEN DO ~SetDialog("bdneeraj")~ EXIT
END
EXTEND_BOTTOM BDNEERA 146
IF ~Inparty(Myself) AreaCheck("c#afh2")~ THEN DO ~SetDialog("bdneeraj")~ EXIT
END
EXTEND_BOTTOM BDNEERA 148
IF ~Inparty(Myself) AreaCheck("c#afh2")~ THEN DO ~SetDialog("bdneeraj")~ EXIT
END

APPEND bdneera

IF WEIGHT #-1
~AreaCheck("c#afh3")
Global("chapter","global",13)
Global("C#AfH_jail_visitors","c#afh3",5)
Global("bd_neera_romanceactive","global",2)
~ THEN BEGIN 120_revised_changes
  SAY @133 /* Wow. Hiding behind an army of soldiers isn't a good look for you. */
/* not in group (c#afh3.are) - set variables */
  IF ~!InParty(Myself)~ THEN REPLY @134 /* Neera! Come with me when I get out of here. */ DO ~SetGlobal("C#AfH_jail_visitors","c#afh3",6)
SetGlobal("C#AfH_visit_player","locals",1)
~ GOTO 121_changes
  IF ~!InParty(Myself)~ THEN REPLY @135 /* I'm in here because the Dukes made it clear it's the best for the city right now. */ DO ~SetGlobal("C#AfH_jail_visitors","c#afh3",6)
SetGlobal("C#AfH_visit_player","locals",1)
~ GOTO 121_changes
  IF ~!InParty(Myself)~ THEN REPLY #%eet_2%53208 /* ~The jesters' guild suffered a great loss when you decided to pursue magic.~ */ DO ~SetGlobal("C#AfH_jail_visitors","c#afh3",6)
SetGlobal("C#AfH_visit_player","locals",1)
~ GOTO 131_changes
  IF ~!InParty(Myself)~ THEN REPLY #%eet_2%53209 /* ~I'm glad to see you too.~ */ DO ~SetGlobal("C#AfH_jail_visitors","c#afh3",6)
SetGlobal("C#AfH_visit_player","locals",1)
~ GOTO 133_changes

/* if in group (c#afh2.are) - no variable setting */
  IF ~InParty(Myself)~ THEN REPLY @134 /* Neera! Come with me when I get out of here. */ GOTO 126_changes
  IF ~InParty(Myself)~ THEN REPLY @135 /* I'm in here because the Dukes made it clear it's the best for the city right now. */ GOTO 121_changes
  IF ~InParty(Myself)~ THEN REPLY #%eet_2%53208 /* ~The jesters' guild suffered a great loss when you decided to pursue magic.~ */ GOTO 131_changes
  IF ~InParty(Myself)~ THEN REPLY #%eet_2%53209 /* ~I'm glad to see you too.~ */ GOTO 133_changes
END

IF ~~ THEN BEGIN 121_changes
  SAY @136 /* You and Skie, <CHARNAME>. Explain it to me what happened there, please. I need to understand. */
  IF ~~ THEN REPLY @137 /* Someone murdered her. Not me. I don't know who, or how they did it. */ GOTO 122_changes
  IF ~~ THEN REPLY @138 /* You actually consider it was me? Go, then. I've no use for you. */ GOTO 122_changes
END

IF ~~ THEN BEGIN 122_changes
  SAY #%eet_2%53214 /* ~You didn't do it?~ [BD53214] */
++ #%eet_2%53215 /* ~Of course I didn't do it! I don't know who did—I don't know how. And I won't find out while I'm stuck in here.~ */ GOTO 124_changes
  IF ~OR(2)
!Class(Player1,PALADIN_ALL)
Kit(Player1,Blackguard)
~ THEN REPLY #%eet_2%70275 /* ~I couldn't have done it. I could never fall so far as that.~ */ GOTO 124_changes
  IF ~  Class(Player1,PALADIN_ALL)
!Kit(Player1,Blackguard)
~ THEN REPLY #%eet_2%70276 /* ~I didn't, Neera. Have you no faith in me?~ */ GOTO 125_changes
  IF ~~ THEN REPLY #%eet_2%53216 /* ~Try to think, just once in your godsforsaken life. Where's the benefit in killing Skie Silvershield? What would killing the daughter of a Grand Duke gain me, other than a death sentence?~ */ GOTO 128_changes
  IF ~~ THEN REPLY #%eet_2%53217 /* ~You doubt me? Then go. Get out of here—now!~ */ GOTO 123
END

IF ~~ THEN BEGIN 124_changes
  SAY #%eet_2%53219 /* ~I'm sorry, <CHARNAME>. I believe you—I do—but...~ [BD53219] */
  IF ~~ THEN GOTO add_01
END

IF ~~ THEN BEGIN 125_changes
  SAY #%eet_2%70277 /* ~I believe you, <CHARNAME>. I do. For all the good it does.~ */
  IF ~~ THEN REPLY #%eet_2%70278 /* ~It means everything to me. Now you must leave me. You deserve a better life than you'll ever find at my side.~ */ GOTO 134
  IF ~~ THEN REPLY #%eet_2%70279 /* ~If you do believe me, then come with me when I'll get out of here.~ */ GOTO 126_changes
  IF ~~ THEN REPLY #%eet_2%70280 /* ~It's a cold comfort, but I'll take what comfort I can get in this place. What will you do now?~ */ GOTO 136
END

IF ~~ THEN BEGIN 126_changes
  SAY #%eet_2%53233 /* ~I can't do that.~ [BD53233] */
  IF ~~ THEN GOTO add_01
END

IF ~~ THEN BEGIN 128_changes
  SAY #%eet_2%53224 /* ~Yeah... That makes sense.~ [BD53224] */
  IF ~~ THEN GOTO 124_changes
END

IF ~~ THEN BEGIN 131_changes
  SAY #%eet_2%53230 /* ~I always thought I'd missed my calling.~ [BD53230] */
  IF ~~ THEN REPLY @139 /* Come with me, Neera. */ GOTO 121_changes
  IF ~~ THEN REPLY #%eet_2%70282 /* ~I am glad to see you one last time, Neera. But you must leave. You deserve a better life than you'll ever get at my side.~ */ GOTO 134
END

IF ~~ THEN BEGIN 133_changes
  SAY #%eet_2%53234 /* ~And I'm glad you're okay—at least for the moment.~ [BD53234] */
  IF ~~ THEN GOTO 126_changes
END

IF ~~ THEN add_01
SAY @140 /* Do you have an idea what is going on outside? On the streets? The Dukes aren't hiding you here for nothing, I can tell you. Being associated with you is currently... not the most healthy thing that can happen to someone, you know. */
  IF ~~ THEN REPLY #%eet_2%53221 /* ~I understand. At least someone believes me. That matters. Go, get out of here. I need to be alone now.~ */ GOTO 148
  IF ~~ THEN REPLY #%eet_2%53227 /* ~So what will you do now?~ */ GOTO 136
  IF ~~ THEN REPLY #%eet_2%53222 /* ~I thought we had something, Neera.~ */ GOTO 129
  IF ~~ THEN REPLY #%eet_2%53223 /* ~I'm a child of Bhaal. They'll take no chances with me, not after what happened with Sarevok.~ */ GOTO 148
END

END //APPEND

/* Rasaad */
/* set his dialogue back to joined in case this dialogue happens inside the first level of the palace whit Rasaad in the group */
EXTEND_BOTTOM bdrasaad 84
IF ~Inparty(Myself) AreaCheck("c#afh2")~ THEN DO ~SetDialog("bdrasaaj")~ EXIT
END
EXTEND_BOTTOM bdrasaad 94
IF ~Inparty(Myself) AreaCheck("c#afh2")~ THEN DO ~SetDialog("bdrasaaj")~ EXIT
END
EXTEND_BOTTOM bdrasaad 96
IF ~Inparty(Myself) AreaCheck("c#afh2")~ THEN DO ~SetDialog("bdrasaaj")~ EXIT
END

APPEND BDRASAAD

IF WEIGHT #-1
~AreaCheck("c#afh3")
Global("chapter","global",13)
Global("C#AfH_jail_visitors","c#afh3",5)
Global("bd_rasaad_romanceactive","global",2)
~ THEN BEGIN 80_changes
  SAY #%eet_2%53481 /* ~I should have expected this.~ [BD53481] */
/* not in group (c#afh3.are) - set variables */
+ ~!InParty(Myself)~ + #%eet_2%53483 /* ~What do you mean by that?~ */ DO ~SetGlobal("C#AfH_jail_visitors","c#afh3",6)
SetGlobal("C#AfH_visit_player","locals",1)~ + 81_changes
+ ~!InParty(Myself)~ + #%eet_2%53482 /* ~Rasaad... don't look at me like that.~ */ DO ~SetGlobal("C#AfH_jail_visitors","c#afh3",6)
SetGlobal("C#AfH_visit_player","locals",1)~ + 88_changes
+ ~!InParty(Myself)~ + @141 /* I need to leave soon. Come with me. */ DO ~SetGlobal("C#AfH_jail_visitors","c#afh3",6)
SetGlobal("C#AfH_visit_player","locals",1)~ + 88_changes
+ ~!InParty(Myself)~ + #%eet_2%53488 /* ~Leave me. I can't bear to look at you right now.~ */ DO ~SetGlobal("C#AfH_jail_visitors","c#afh3",6)
SetGlobal("C#AfH_visit_player","locals",1)~ + 89_changes

/* if in group (c#afh2.are) - no variable setting */
+ ~InParty(Myself)~ + #%eet_2%53483 /* ~What do you mean by that?~ */ + 81_changes
+ ~InParty(Myself)~ + #%eet_2%53482 /* ~Rasaad... don't look at me like that.~ */ + 88_changes
+ ~InParty(Myself)~ + @141 /* I need to leave soon. Come with me. */ + 88_changes
+ ~InParty(Myself)~ + #%eet_2%53488 /* ~Leave me. I can't bear to look at you right now.~ */ + 89_changes
END

IF ~~ THEN BEGIN 81_changes
  SAY #%eet_2%70286 /* ~Your father's darkness is within you. You fight it, I know, but it is a battle I fear you cannot win.~ */
= @142 /* I understand it now. Even if you are victorious and do not fall for the darkness, it will still be your heritage that will spread chaos and destruction wherever you go. */
  IF ~~ THEN REPLY @143 /* Please, Rasaad. You can't believe I wanted what is happening outside. */ GOTO 82_changes
  IF ~~ THEN REPLY #%eet_2%70288 /* ~I'm beginning to think you may be right. Best you leave this place, and me along with it. You deserve better than I can give you.~ */ GOTO 84
  IF ~~ THEN REPLY #%eet_2%70289 /* ~You think so little of me? Begone, then. I've no use for you.~ */ GOTO 95
END

IF ~~ THEN BEGIN 82_changes
  SAY #%eet_2%70290 /* ~I do not. But what I believe matters little.~ */
  IF ~~ THEN REPLY #%eet_2%70291 /* ~It matters to me. It means everything.~ */ GOTO 83_changes
  IF ~~ THEN REPLY #%eet_2%70292 /* ~That's true enough, unfortunately. But I appreciate it nonetheless.~ */ GOTO 83_changes
  IF ~~ THEN REPLY #%eet_2%70293 /* ~Then I guess this is where we part ways.~ */ GOTO 84
END

IF ~~ THEN BEGIN 83_changes
  SAY @144 /* I am glad to know I offer some comfort to you. */ 
IF ~~ THEN + 91_changes
END

IF ~~ THEN BEGIN 87_changes
  SAY #%eet_2%53490 /* ~Why? Can I not look upon the one I called friend, the one I called... something more?~ [BD53490] */
IF ~~ THEN + 81_changes
END

IF ~~ THEN BEGIN 88_changes
  SAY #%eet_2%53494 /* ~What I see is what I should have seen all along.~ [BD53494] */
  IF ~~ THEN GOTO 81_changes
END

IF ~~ THEN BEGIN 89_changes
  SAY #%eet_2%53495 /* ~You SHOULD quail before me. My intentions were pure. My emotions were real. YOU were the one who led me astray.~ [BD53495] */
  IF ~~ THEN GOTO 81_changes
END

IF ~~ THEN BEGIN 91_changes
  SAY #%eet_2%53497 /* ~Someone who gives in to any whim or desire that crosses their mind cannot be trusted. This I knew. I ignored my rational thoughts and allowed my feelings to grow.~ [BD53497] */
++ @145 /* Is that what we had comes down to? That you don't trust your feelings because you gave in to "whim or desire"? I thought what we had was real, Rasaad. */ + 84
  IF ~~ THEN REPLY #%eet_2%53498 /* ~We did nothing wrong, Rasaad. Whatever you believe of me now, I never lied to you.~ */ GOTO 84
  IF ~~ THEN REPLY @146 /* If you honestly believe all I ever bring to people is death and chaos, then there was never anything real between us. */ GOTO 92
++ #%eet_2%53484 /* ~Go away. Go away! ~ */ + 93
END

END //APPEND

/* Safana */
/* set her dialogue back to joined in case this dialogue happens inside the first level of the palace whit Safana in the group */
EXTEND_BOTTOM bdsafana 105
IF ~Inparty(Myself) AreaCheck("c#afh2")~ THEN DO ~SetDialog("bdsafanj")~ EXIT
END

APPEND bdsafana

IF WEIGHT #-1
~AreaCheck("c#afh3")
Global("chapter","global",13)
Global("C#AfH_jail_visitors","c#afh3",5)
Global("bd_safana_romanceactive","global",2)
~ THEN BEGIN 106_changes
  SAY #%eet_2%53750 /* ~Funny. I always thought in this sort of situation I'd be on the other side of the bars.~ [BD53731] */
/* not in group (c#afh3.are) - set variables */
+ ~!InParty(Myself)~ + @147 /* Safana, come with me when I'll leave this place. It'll all settle down, believe me! */ DO ~SetGlobal("C#AfH_jail_visitors","c#afh3",6)
SetGlobal("C#AfH_visit_player","locals",1)~ + 107_changes
+ ~!InParty(Myself)~ + @148 /* Bars? More of a golden cage I would say. */ DO ~SetGlobal("C#AfH_jail_visitors","c#afh3",6)
SetGlobal("C#AfH_visit_player","locals",1)~ + 111_changes
  IF ~!InParty(Myself)~ THEN REPLY @149 /* To be honest, so did I. And I expected it to be real bars - in your case. */ DO ~SetGlobal("C#AfH_jail_visitors","c#afh3",6)
SetGlobal("C#AfH_visit_player","locals",1)~ GOTO 109_changes
  IF ~!InParty(Myself)~ THEN REPLY #%eet_2%53734 /* ~Did you come here to mock me?~ */ DO ~SetGlobal("C#AfH_jail_visitors","c#afh3",6)
SetGlobal("C#AfH_visit_player","locals",1)~ GOTO 110_changes

/* if in group (c#afh2.are) - no variable setting */
+ ~InParty(Myself)~ + @147 /* Safana, come with me when I'll leave this place. It'll all settle down, believe me! */ + 107_changes
+ ~InParty(Myself)~ + @148 /* Bars? More of a golden cage I would say. */ + 111_changes
  IF ~InParty(Myself)~ THEN REPLY @149 /* To be honest, so did I. And I expected it to be real bars - in your case. */ GOTO 109_changes
  IF ~InParty(Myself)~ THEN REPLY @150 /* Are you mocking me? */ GOTO 110_changes
END

IF ~~ THEN BEGIN 107_changes
  SAY #%eet_2%53735 /* ~Believing you is what got me INTO this mess in the first place!~ [BD53735] */
  IF ~~ THEN GOTO 111_changes
END

IF ~~ THEN BEGIN 109_changes
  SAY #%eet_2%53736 /* ~Really? You give me attitude at a time like this?~ [BD53736] */
  IF ~~ THEN GOTO 111_changes
END

IF ~~ THEN BEGIN 110_changes
  SAY #%eet_2%53737 /* ~Maybe I did. Maybe you DESERVE it.~ [BD53737] */
  IF ~~ THEN GOTO 111_changes
END

IF ~~ THEN BEGIN 111_changes
  SAY #%eet_2%53738 /* ~I shouldn't be surprised but, damn it, I am. You really had me fooled, champ. One hundred percent sucker, that's me.~ [BD53738] */
IF ~~ THEN + 115_changes
END

IF ~~ THEN BEGIN 115_changes
  SAY #%eet_2%70304 /* ~There's nothing you can say, nothing that matters now. I cared for you, but you aren't just you. Everywhere you go, your father follows. You can't escape him, and I can't ignore him, not anymore.~ */
  IF ~~ THEN GOTO 105
END

END //APPEND


/* Viconia */
/* set his dialogue back to joined in case this dialogue happens inside the first level of the palace whith Dorn in the group */
EXTEND_BOTTOM BDVICONI 46
IF ~Inparty(Myself) AreaCheck("c#afh2")~ THEN DO ~SetDialog("bdviconj")~ EXIT
END

APPEND bdviconi

IF WEIGHT #-1
~AreaCheck("c#afh3")
Global("chapter","global",13)
Global("C#AfH_jail_visitors","c#afh3",5)
Global("bd_viconia_romanceactive","global",2)
~ THEN BEGIN 36_changes
  SAY #%eet_2%53924 /* ~I never thought to see you like this, abbil. Blood on your hands and fear in your eyes. I thought you to be more clever.~ [BD53924] */
/* not in group (c#afh3.are) - set variables */
+ ~!InParty(Myself)~ + @151 /* Blood on my hands? You mean figuratively? You can't make me responsible for what is happening outside on the streets, or are you? */ DO ~SetGlobal("C#AfH_jail_visitors","c#afh3",6)
SetGlobal("C#AfH_visit_player","locals",1)~ + 39_changes
+ ~!InParty(Myself)~ + @152 /* Did you come here to taunt me or are you going to come with me when I'll leave this city? */ DO ~SetGlobal("C#AfH_jail_visitors","c#afh3",6)
SetGlobal("C#AfH_visit_player","locals",1)~ GOTO 44_changes
  IF ~!InParty(Myself)~ THEN REPLY #%eet_2%53927 /* ~I'm in no mood for idle chatter.~ */ DO ~SetGlobal("C#AfH_jail_visitors","c#afh3",6)
SetGlobal("C#AfH_visit_player","locals",1)~ GOTO 46

/* if in group (c#afh2.are) - no variable setting */
+ ~InParty(Myself)~ + @151 /* Blood on my hands? You mean figuratively? You can't make me responsible for what is happening outside on the streets, or are you? */ + 39_changes
+ ~InParty(Myself)~ + @152 /* Did you come here to taunt me or are you going to come with me when I'll leave this city? */ GOTO 44_changes
  IF ~InParty(Myself)~ THEN REPLY #%eet_2%53927 /* ~I'm in no mood for idle chatter.~ */ GOTO 46
END

IF ~~ THEN BEGIN 39_changes
  SAY #%eet_2%70306 /* ~You say that as though it matters. Innocent, guilty, it makes no difference in this world. Do you deserve the burden that has been imposed upon you? I know not.~ */
  IF ~~ THEN GOTO 45_revised_changes
END

IF ~~ THEN BEGIN 43_changes
  SAY #%eet_2%53933 /* ~You may claim your innocence, but... none of us are innocent. Least of all you.~ [BD53933] */
IF ~~ THEN + 46
END

IF ~~ THEN BEGIN 44_changes
  SAY #%eet_2%53937 /* ~Alas, I cannot. I would like to help you, murderer or no. You saved me in the past, and I would return the favor.~ [BD53937] */
  IF ~~ THEN GOTO 45_revised_changes
END

IF ~~ THEN BEGIN 45_revised_changes
  SAY @153 /* But if we were caught at your side, I would be executed without a thought by the brutes who overrun this city. My life is perilous enough. I cannot tie it to the life of a wanted Bhaalspawn. */
  IF ~~ THEN REPLY #%eet_2%53940 /* ~Then this is goodbye.~ */ GOTO 43_changes
  IF ~~ THEN REPLY #%eet_2%53939 /* ~You can't leave me like this. I'm innocent, I tell you! I'm INNOCENT!~ */ GOTO 39
  IF ~~ THEN REPLY #%eet_2%53941 /* ~I can't bear to have you think this of me, Viconia.~ */ GOTO 46
END

END //APPEND

/* Voghiln */
/* set his dialogue back to joined in case this dialogue happens inside the first level of the palace whit Corwin in the group */
EXTEND_BOTTOM BDVOGHIL 88
IF ~Inparty(Myself) AreaCheck("c#afh2")~ THEN DO ~SetDialog("bdvoghij")~ EXIT
END

APPEND bdvoghil

IF WEIGHT #-1
~AreaCheck("c#afh3")
Global("chapter","global",13)
Global("C#AfH_jail_visitors","c#afh3",5)
Global("bd_voghiln_romanceactive","global",2)
~ THEN BEGIN 75_changes
  SAY #%eet_2%54132 /* ~Though we have faced many hard times together, this may be the hardest, ja?~ [BD54132] */
/* not in group (c#afh3.are) - set variables */
  IF ~!InParty(Myself)~ THEN REPLY #%eet_2%54133 /* ~The hardest for me, or for you? You look defeated.~ */ DO ~SetGlobal("C#AfH_jail_visitors","c#afh3",6)
SetGlobal("C#AfH_visit_player","locals",1)
~ GOTO 76_changes
  IF ~!InParty(Myself)~ THEN REPLY @154 /* Voghiln, I didn't want for this chaos to happen. You know that, right? */ DO ~SetGlobal("C#AfH_jail_visitors","c#afh3",6)
SetGlobal("C#AfH_visit_player","locals",1)
~ GOTO 80_changes
  IF ~!InParty(Myself)~ THEN REPLY @155 /* Come with me when I'll leave the city, Voghiln. */ DO ~SetGlobal("C#AfH_jail_visitors","c#afh3",6)
SetGlobal("C#AfH_visit_player","locals",1)
~ GOTO 76_changes
  IF ~!InParty(Myself)~ THEN REPLY #%eet_2%54135 /* ~No, I'd say Hell was the hardest. This is difficult, but I'll get through it.~ */ DO ~SetGlobal("C#AfH_jail_visitors","c#afh3",6)
SetGlobal("C#AfH_visit_player","locals",1)
~ GOTO 77_changes

/* if in group (c#afh2.are) - no variable setting */
  IF ~InParty(Myself)~ THEN REPLY #%eet_2%54133 /* ~The hardest for me, or for you? You look defeated.~ */ GOTO 76_changes
  IF ~InParty(Myself)~ THEN REPLY @154 /* Voghiln, I didn't want for this chaos to happen. You know that, right? */ GOTO 80_changes
  IF ~InParty(Myself)~ THEN REPLY @155 /* Come with me when I'll leave the city, Voghiln. */ GOTO 76_changes
  IF ~InParty(Myself)~ THEN REPLY #%eet_2%54135 /* ~No, I'd say Hell was the hardest. This is difficult, but I'll get through it.~ */ GOTO 77_changes

END

IF ~~ THEN BEGIN 76_changes
  SAY #%eet_2%54136 /* ~I am... sad, mine friend. I have always been ready with a joke or a song to lift the spirits, but now... Voghiln the Mighty is empty.~ [BD54136] */
  IF ~~ THEN GOTO 78_revised_changes
END

IF ~~ THEN BEGIN 77_changes
  SAY #%eet_2%54137 /* ~Ever pragmatic, ja? You look at your situation with such clear eyes. But Voghiln the Mighty is saddened at the sight of you.~ [BD54137] */
  IF ~~ THEN GOTO 78_revised_changes
END

IF ~~ THEN BEGIN 78_revised_changes
  SAY @156 /* You were the hero - the champion! You saved the Sword Coast from Sarevok, from Caelar, from the hordes of the Nine Hells! "How can anyone believe you guilty of selling souls?" I said, pleading your case to whoever listened. */ 
  IF ~~ THEN GOTO 81_revised_changes
END

IF ~~ THEN BEGIN 80_changes
  SAY #%eet_2%54142 /* ~Your words lift a weight off Voghiln's heart. I did not wish to believe it of you.~ [BD54142] */
IF ~~ THEN + 76_changes
END

IF ~~ THEN BEGIN 81_revised_changes
  SAY @157 /* Alas, I am only a skald. A mighty skald, to be sure, but all mine honeyed words cannot turn the ear of a mob calling you a monster. */
  IF ~~ THEN GOTO 84_changes
END

IF ~~ THEN BEGIN 84_changes
  SAY #%eet_2%54152 /* ~Worse, mine efforts to free you have cast suspicion on Voghiln himself! There are whispers that I may have aided you, that our closeness has blinded me to your true nature.~ [BD54152] */
++ @158 /* Then... You've got to get out of here, Voghiln. Go, before you'll come to harm because of me. */ + 88
++ @159 /* Come with me when I'll leave this place tomorrow, Voghiln. */ + 85_revised_changes
  IF ~~ THEN REPLY #%eet_2%54154 /* ~Don't be a coward, Voghiln. Stay here and fight for me!~ */ GOTO 85_revised_changes
++ @160 /* I'm not surprised. Those gossips must be having a time with this news. */ + 88
++ @161 /* Well, then go, if you are scared. */ + 88
END

IF ~~ THEN BEGIN 85_revised_changes
  SAY @162 /* I must leave. I cannot help anyone if I am believed to be a minion to Bhaal's evil bidding. */
  IF ~~ THEN + 88
END
END //APPEND


/* Visit Hooded Man - need to take focus from PC being hunted for murder */

REPLACE_STATE_TRIGGER bdireni 66 ~AreaCheck("c#afh3")~

APPEND bdireni

IF WEIGHT #-1
~AreaCheck("c#afh3")
Global("C#AfH_jail_visitors","c#afh3",10)
~ THEN BEGIN 61_changes
  SAY #%eet_2%66663 /* ~Chains become you, child of Bhaal. The people you saved have turned on you, treating you as some nightmare made flesh. How does it feel to be trapped in a cell, after all you've done for this city?~ [BD66663] */
++ @163 /* I'm not in a cell, not even figuratively. On the contrary, I'm more exposed and known to people than I ever wanted. */ DO ~SetGlobal("C#AfH_jail_visitors","c#afh3",11)~ + 64
  IF ~~ THEN REPLY @164 /* This isn't right. I didn't want things to escalate like this, I could never do such a thing on purpose. This makes no sense! */ DO ~SetGlobal("C#AfH_jail_visitors","c#afh3",11)~ GOTO 62
  IF ~  CheckStatGT(Player1,15,WIS)
~ THEN REPLY #%eet_2%66665 /* ~You. You were there from the beginning. You're behind this. What game are you playing?~ */ DO ~SetGlobal("C#AfH_jail_visitors","c#afh3",11)~ GOTO 64
  IF ~~ THEN REPLY #%eet_2%66666 /* ~I'll be honest: It doesn't feel great.~ */ DO ~SetGlobal("C#AfH_jail_visitors","c#afh3",11)~ GOTO 62
++ @165 /* How did you get in here? This was supposed to be a secure place! Get out of here before I'll let the guards take you down! */ DO ~SetGlobal("C#AfH_jail_visitors","c#afh3",11)~ + 63
END
END //APPEND

REPLACE_STATE_TRIGGER bdireni 66 ~AreaCheck("c#afh3")
Global("C#AfH_jail_visitors","c#afh3",11)~

EXTEND_BOTTOM bdireni 69
IF ~Global("C#AfH_jail_visitors","c#afh3",11)~ THEN DO ~SetGlobal("C#AfH_jail_visitors","c#afh3",12)
AddJournalEntry(@90005,QUEST_DONE)
AddJournalEntry(@90006,QUEST) EscapeArea()~ EXIT
END




/* Duke Belt comes to see the PC out */

APPEND c#afhblt

IF ~Global("C#AfH_jail_visitors","c#afh3",14)~ THEN BEGIN 22_changes
  SAY #%eet_2%69820 /* ~How are you, <CHARNAME>?~ [BD69820] */
  IF ~~ THEN REPLY @217 /* ~Duke Belt—it is good to see you. I have news. I know who slew Skie now. It was the hooded man that was stalking me for my Bhaal heritage.~ */ DO ~SetGlobal("C#AfH_jail_visitors","c#afh3",15) SetGlobal("bd_plot","global",620)
~ GOTO 30_changes
  IF ~~ THEN REPLY @166 /* I'll be a damn sight better when I'm away from this city. */ DO ~SetGlobal("C#AfH_jail_visitors","c#afh3",15) SetGlobal("bd_plot","global",620)
~ GOTO totalrevised_end_00
  IF ~~ THEN REPLY #%eet_2%69823 /* ~Don't waste my time with idle conversation, Belt. I've no patience for it.~ */ DO ~SetGlobal("C#AfH_jail_visitors","c#afh3",15) SetGlobal("bd_plot","global",620)
~ GOTO 23_changes
END

IF ~~ THEN BEGIN 23_changes
  SAY #%eet_2%69824 /* ~As you wish.~ [BD69824] */
  IF ~~ THEN GOTO 32_changes
END

END //APPEND

CHAIN
IF ~~ THEN c#afhblt 30_changes
  #%eet_2%69831 /* ~You know the killer's name? You have proof?~ [BD69831] */
== BDMINSCJ IF ~IsValidForPartyDialogue("MINSC")~ THEN @218 /* ~[Minsc]Evil hooded man killed little Skie! We will kick his evil butt, won't we, Boo?~ */ DO ~SetGlobal("C#AfHSoD_MinscKnowsHM","GLOBAL",1)~
== BDJAHEIJ IF ~IsValidForPartyDialogue("JAHEIRA")~ THEN @219 /* ~[Jaheira]So this "Hooded Man" not only played with you but also didn't stop at killing our friends to do so. He is posing a much greater threat than we were aware of.~ */ DO ~SetGlobal("C#AfHSoD_JaheiraKnowsHM","GLOBAL",1)~
== BDDYNAHJ IF ~IsValidForPartyDialogue("DYNAHEIR")~ THEN @220 /* ~[Dynaheir]A skillful mage, interested in your Bhaal heritage, and not for friendly reasons. We will remain wary. The number of foes is numerous for a Bhaalchild.~ */ DO ~SetGlobal("C#AfHSoD_DynaheirKnowsHM","GLOBAL",1)~
== BDKHALIJ IF ~IsValidForPartyDialogue("KHALID")~ THEN @221 /* ~[Khalid]Then we know what to d-do!~ */ DO ~SetGlobal("C#AfHSoD_KhalidKnowsHM","GLOBAL",1)~
END
  IF ~~ THEN REPLY #%eet_2%69832 /* ~I have neither his name nor proof of his crime, but you must find him nonetheless, if you would see justice served.~ */ GOTO 31_changes
  IF ~~ THEN REPLY @167 /* I'll get you both. */ + totalrevised_end_00
  IF ~~ THEN REPLY #%eet_2%69834 /* ~I can offer you nothing more than my word that I speak the truth. If that is insufficient, so be it. Say your piece and begone.~ */ GOTO 23_changes


APPEND c#afhblt

IF ~~ THEN BEGIN 31_changes
  SAY #%eet_2%69835 /* ~Justice is an ideal we must all strive for. But circumstances do not allow for the ideal. The Council of Four must bow to the practical.~ [BD69835] */
  IF ~~ THEN GOTO totalrevised_end_00
END

END //APPEND

CHAIN
IF ~~ THEN c#afhblt 32_changes
  #%eet_2%69836 /* ~A guard will escort you out of the city. This is a poor reward for all you have done for us, I know, but it is the best we are allowed. Go someplace far from here, and do not return.~ [BD69836] */
= @168 /* Not until you did as we requested, <CHARNAME> - as we pleaded with you, as representatives of this city, as loving father. We all wish you success from the bottom of our hearts - for Skie, for the peace in this city, but also for your own sake. I thank you for all you did for us - and all you are about to do in the future. */
== c#afhblt IF ~!InPartyAllowDead("Jaheira") !InPartyAllowDead("Khalid") !InPartyAllowDead("Dynaheir") !InPartyAllowDead("Minsc") OR(4) !Dead("Jaheira") !Dead("Khalid") !Dead("Dynaheir") !Dead("Minsc")~ THEN  @169 /* Your friend Imoen managed to find compagnions so you do not have to go on this journey alone. They are awaiting you. */
END
IF ~~ THEN + 33_changes

APPEND c#afhblt

IF ~~ THEN BEGIN 33_changes
  SAY #%eet_2%69837 /* ~Fare thee well, <CHARNAME>.~ [BD69837] */
  IF ~~ THEN DO ~EscapeArea()~ EXIT
END

END //APPEND

CHAIN
IF ~~ THEN c#afhblt totalrevised_end_00
@170 /* Your heritage... what happened, it all poisoned the hearts of many people. It is no exaggeration to say that the city is being torn between those who would fight for you and those who want to see you put to death like Sarevok. */ 
= @171 /* The night did not help to cool the masses off. On the contrary, word about your blood opening the portal to Avernus got around. Rumors now state that Sarevok tried to start a war between people, but you could start a war using fiends! */
== c#afhblt IF ~GlobalGT("C#AfH_PortalQuest","GLOBAL",0)~ THEN @172 /* Take the note we gave you with you and make your way to find an Incantatrix who can close that portal, <CHARNAME>. I do not see another way to soothe the masses away from believing that you will come back, marching an army of fiends! */
== c#afhblt @173 /* [Duke Belt]Entar - Duke Silvershield already begged you to retrieve the dagger and save his daughter. I am reluctant to say that you will not be safe here until this is settled, <CHARNAME> - until the dagger is found and Skie's soul is freed. */ 
END
+ ~Global("C#AfH_PortalQuest","GLOBAL",0)~ + @174 /* Retrieving the dagger and freeing Skie is what honor dictates me to do. I will not rest until it is done. */ + totalrevised_end_04
+ ~GlobalGT("C#AfH_PortalQuest","GLOBAL",0)~ + @175 /* Retrieving the dagger and freeing Skie is what honor dictates me to do. I will not rest until it is done, as well as I will seek out the Cowled Wizards in Amn to close the portal. */ + totalrevised_end_04
+ ~GlobalGT("C#AfH_PortalQuest","GLOBAL",0)~ + @176 /* I will go to Amn and seek help with closing the portal, but I can't promise anything with regard to Skie yet - I have no idea where to start looking for the Hooded Man. */ + totalrevised_end_05
++ @177 /* Seems like this Hooded Man will not leave me in peace anyway, so I can as well go after him in persue of that dagger - and more. */ + totalrevised_end_04
++ @178 /* I didn't do anything wrong. I shouldn't have to leave the city in secret like a criminal. */ + totalrevised_end_02
++ @179 /* I couldn't care less. I found my way around the city while being outcast before. */ + totalrevised_end_01

APPEND c#afhblt 

IF ~~ THEN totalrevised_end_01
SAY @180 /* [Duke Belt]This time you will not find means to enter again. We will see to that. */
IF ~~ THEN + totalrevised_end_03
END

IF ~~ THEN totalrevised_end_02
SAY @181 /* [Duke Belt]I... I cannot guarantee your safety, <CHARNAME>. */
IF ~~ THEN + totalrevised_end_03
END

IF ~~ THEN totalrevised_end_03
SAY @182 /* [Duke Belt]Should Skie be saved, your name will be rehabilitated and you will be vindicated from any of those rediculous rumors about selling the people's souls to fiends... We can't dictate people's opinion on your Bhaal heritage, but we *can* work on reinstate your name and free passage in the city once Skie's soul will be with us again. */ 
IF ~~ THEN + 32_changes
END

IF ~~ THEN totalrevised_end_04
SAY @183 /* [Duke Belt]I am glad to hear that. */
IF ~~ THEN + totalrevised_end_03
END

IF ~~ THEN totalrevised_end_05
SAY @184 /* [Duke Belt]Your will to find her is all I need to hear. */
IF ~~ THEN + totalrevised_end_03
END

END //APPEND


REPLACE_STATE_TRIGGER bdff1709 0 ~False()~
REPLACE_STATE_TRIGGER bdff1709 1 ~False()~
REPLACE_STATE_TRIGGER bdff1709 2 ~AreaCheck("c#afh3")~

ADD_TRANS_ACTION bdff1709 BEGIN 0 END BEGIN END ~SetGlobal("C#AfH_NotYet","c#afh3",0)~
ADD_TRANS_ACTION bdff1709 BEGIN 3 END BEGIN END ~SetGlobal("C#AfH_NotYet","c#afh3",1)~

APPEND bdff1709 

IF ~~ THEN guard_01
SAY @185 /* [FF Soldier (male)]I have orders to guide you to the exit where your friends are waiting. I can lead you the direct way without being exposed. */
++ @186 /* I don't care. I'll go on my own and see what I'll find on the way. */ + guard_02
++ @187 /* Good point. Lead the way then. */ + guard_03
END

IF ~~ THEN guard_02
SAY @188 /* [FF Soldier (male)]Argh. Duke Belt will have my head for that - although only figuratively speaking. Well, I can't force you to come with me, so good luck down there. */ 
IF ~~ THEN DO ~SetGlobal("bd_plot","global",641)~ + 11
END

IF ~~ THEN BEGIN guard_03
  SAY #%eet_2%69839 /* ~Follow me.~ [BD69839] */
  COPY_TRANS bdff1709 5
END

END //APPEND

ADD_TRANS_TRIGGER bdff1709 5 ~False()~

EXTEND_BOTTOM bdff1709 5
++ @189 /* I think I can find my own way from here. Your escord is not needed. */ + guard_01
++ @190 /* Lead the way. */ + guard_03
END

EXTEND_BOTTOM bdff1709 10
  IF ~GlobalGT("C#AfHSoD_RevisedEnd","GLOBAL",0)
GlobalGT("bd_plot","global",641)~ THEN DO ~MoveToPointNoInterrupt([2815.2575])
DestroySelf()
~ UNSOLVED_JOURNAL @90008 EXIT
  IF ~GlobalGT("C#AfHSoD_RevisedEnd","GLOBAL",0)
GlobalLT("bd_plot","global",650)~ THEN DO ~EscapeArea()~ UNSOLVED_JOURNAL @90008 EXIT
END

EXTEND_BOTTOM bdff1709 12
  IF ~GlobalGT("C#AfHSoD_RevisedEnd","GLOBAL",0)~ THEN DO ~MoveToPointNoInterrupt([2815.2575])
DestroySelf()
~ UNSOLVED_JOURNAL @90008 EXIT
END

ALTER_TRANS bdff1709
	BEGIN 2 END
	BEGIN %responses_2% END
	BEGIN "EPILOGUE" ~GOTO 0~ END

ALTER_TRANS bdff1709
	BEGIN 4 END
	BEGIN %responses_4% END
	BEGIN "EPILOGUE" ~GOTO 0~ END

/* in the sewers. 
Corwin: verrennt sich in die Idee, dass der Hc sich der Bevölkerung stellen soll - also sich wegen des Mordes hinrichten lassen soll, damit die Stadt zur Ruhe kommt.
Bence springt einfach auf den Zug auf, weil er ein in Skie verliebter Trottel ist. */

/* SAY #39613 /* ~Hands in the air. Get away from the opening.~ [BD39613] */ */
INTERJECT bdschae2 39 C#AfHSoD_bdschae2_39
== bdschae2 @191 /* Slowly, <CHARNAME>. Very slowly! */
END
++ @192 /* What is this about, Corwin? The Dukes sent me out of the city, I'm just searching my own way out, that's all. */ + sewers_corwin_revised_01
++ @193 /* Are you threatening me? */ + sewers_corwin_revised_01

CHAIN
IF ~~ THEN bdschae2 sewers_corwin_revised_01
#%eet_2%39658 /* ~The city's tearing itself apart. It has to stop. It HAS to. And it won't until someone pays for what happened at Dragonspear. If you know anything about me, anything at all, you know I can't let you go.~ [BD39658] */
== bdbence #%eet_2%65157 /* ~You've earned your fate. We were fools to bring the child of Bhaal amongst us. Skie Silvershield paid for it with her life. You will pay with yours.~ [BD65157] */
END
++ @194 /* Skie? Are you making me responsible for her death? */ EXTERN bdbence sewers_bence_revised_01 
  IF ~  Global("bd_corwin_romanceactive","global",2)
Alignment(Player1,MASK_GOOD)
~ THEN REPLY #%eet_2%39615 /* ~Schael, please, I beg you, don't do this. I love you.~ */ GOTO 40_changed
  IF ~  Global("bd_corwin_romanceactive","global",2)
Alignment(Player1,MASK_LCNEUTRAL)
~ THEN REPLY @195 /* You would come at me like this? I thought we had something, you and I. */ GOTO 40_changed
  IF ~  Global("bd_corwin_romanceactive","global",2)
Alignment(Player1,MASK_EVIL)
~ THEN REPLY #%eet_2%39617 /* ~After all we've been through, this is what it comes to. I should have known you'd betray me in the end.~ */ GOTO 46
  IF ~~ THEN REPLY @196 /* And if I don't, what will you do? Cut me down? Are you aware you are acting against your superior's orders, Duke Eltan's - *all* Dukes of this city? */ + 50_changed

APPEND bdschae2

IF ~~ THEN BEGIN 40_changed
  SAY #%eet_2%39620 /* ~You think I want to do this? You think this isn't killing me? We should be together in my bedchamber or a meadow under a cloudless blue sky—ANYWHERE but here!~ [BD39620] */
  IF ~~ THEN GOTO 41_changed
END

IF ~~ THEN BEGIN 41_changed
  SAY #%eet_2%39621 /* ~But here we are. I have a job to do. You know me. You know I can't let you go.~ [BD39621] */
  IF ~~ THEN REPLY #%eet_2%39623 /* ~I know who murdered Skie. Come with me. Help me find him.~ */ EXTERN bdbence sewers_bence_revised_01 
++ @197 /* Well, you'll have to - by Duke Eltan's orders. Don't they mean anything to you? */ + 50_changed
  IF ~~ THEN REPLY #%eet_2%39624 /* ~You know what I'm capable of, Corwin. Please, don't try to stop me.~ */ GOTO 50_changed
  IF ~~ THEN REPLY #%eet_2%39625 /* ~Rohma's already lost a father. Don't make her lose a mother too.~ */ GOTO 53
END

IF ~~ THEN BEGIN 46_changed
  SAY #%eet_2%39634 /* ~I know what I saw. You were standing over the body of Skie Silvershield. Duke Entar's daughter. His DAUGHTER.~ [BD39634] */
  IF ~~ THEN REPLY #%eet_2%39635 /* ~Ah. I understand now. This is about Rohma.~ */ GOTO 48_changed
++ @198 /* So you decided to take justice into your own hands? Is that who you want to be? Is that how you serve your beloved city? By executing self-justice? */ + 55
++ @199 /* What you are doing here is wrong, and you know it. Duke Silvershield trusts in me to find the murder of his daughter, Duke Eltan ordered the Flaming Fist to guide me out of the city unharmed. Where does this leave you? */ + 55
++ @200 /* My conscience is clear, it is you who is trespassing. Come at me then, and face the consequences. */ EXTERN bdschae2 52 
END

IF ~~ THEN BEGIN 48_changed
  SAY #%eet_2%39644 /* ~Don't bring her into this. You won't like where that ends.~ [BD39644] */
++ @201 /* I don't like where we are now, Corwin. Come to your senses! What do you think what you are doing here will bring for you - other than taking the mother away from your daughter, one way or the other? */ + 55
++ @198 /* So you decided to take justice into your own hands? Is that who you want to be? Is that how you serve your beloved city? By executing self-justice? */ + 55
++ @199 /* What you are doing here is wrong, and you know it. Duke Silvershield trusts in me to find the murder of his daughter, Duke Eltan ordered the Flaming Fist to guide me out of the city unharmed. Where does this leave you? */ + 55
++ @200 /* My conscience is clear, it is you who is trespassing. Come at me then, and face the consequences. */ EXTERN bdschae2 52 
END

IF ~~ THEN BEGIN 50_changed
  SAY #%eet_2%65160 /* ~What I believe doesn't matter. All that matters is Baldur's Gate. What's happening can't be allowed to go on.~ [BD65160] */
  IF ~~ THEN EXTERN bdbence sewers_bence_revised_01
END

IF ~~ THEN BEGIN 58_changed
  SAY #%eet_2%62567 /* ~I believe you. I wish that mattered. But all that matters is Baldur's Gate. You have no idea of the chaos Skie's murder unleashed. The people loved you, and now they learn their hero is a child of Bhaal like Sarevok? The city is tearing itself apart because of you.~ [BD62567] */
++ @198 /* So you decided to take justice into your own hands? Is that who you want to be? Is that how you serve your beloved city? By executing self-justice? */ + 55
++ @199 /* What you are doing here is wrong, and you know it. Duke Silvershield trusts in me to find the murder of his daughter, Duke Eltan ordered the Flaming Fist to guide me out of the city unharmed. Where does this leave you? */ + 55
++ @200 /* My conscience is clear, it is you who is trespassing. Come at me then, and face the consequences. */ EXTERN bdschae2 52 
END

END //APPEND

INTERJECT bdbence 88 C#AfHSoD_bdbence_88
== bdschae2 @202 /* I'm letting <PRO_HIMHER> go. Stand down, Corporal. */
== bdbence IF ~Gender(Player1,FEMALE)~ THEN #%eet_2%39675 /* ~No—no! It's not enough. She has to die! Die in the name of Skie Silvershield! Kill her!~ [BD39675] */
== bdbence IF ~Gender(Player1,MALE)~ THEN #%eet_2%37554 /* ~No—no! It's not enough. He has to die! Die in the name of Skie Silvershield! Kill him!~ [BD37554] */
== bdschae2 @203 /* It's over, Corporal! We were... we were misguided. Stand down, that is an order! */
END
IF ~~ THEN DO ~SetGlobal("bd_mdd1725_ot","bd6000",1) SetGlobal("C#AfHSoD_PeacefulEnd","bd6000",1)~ EXTERN bdschae2 62


APPEND bdbence
IF ~~ THEN sewers_bence_revised_01
SAY #%eet_2%39689 /* ~This is about more than a girl now. Half the city wants you drawn and quartered; the other is ready to revolt on your behalf. Baldur's Gate survived Sarevok, the iron crisis, and Caelar's crusade... I'll not let it fall on your account.~ [BD39689] */
IF ~~ THEN + sewers_bence_revised_02
END

IF ~~ THEN sewers_bence_revised_02
SAY @204 /* Duke Eltan wants you out of the city, and that's what we will do - just a little bit more final than he anticipated. I am sure noone will cry over the loss of you! */
++ @205 /* You have lost your mind - both of you. */ EXTERN bdschae2 46_changed
++ @206 /* Corwin, please. I understand that the Corporal has problems grasping the truth, but this is not you. */ EXTERN bdschae2 58_changed
++ @207 /* I was sent to seek out Skie's murderer - I'm the only one who saw him up close! Do you want to deprive a mourning father of his only hope? */ EXTERN bdschae2 58_changed
++ @200 /* My conscience is clear, it is you who is trespassing. Come at me then, and face the consequences. */ EXTERN bdschae2 52 
END

END //APPEND

/* no Corwin: Bence will fight! */
I_C_T bdbence 93 C#AfHSoD_bdbence_93
== bdbence #%eet_2%65157 /* ~You've earned your fate. We were fools to bring the child of Bhaal amongst us. Skie Silvershield paid for it with her life. You will pay with yours.~ [BD65157] */
END

EXTEND_BOTTOM bdbence 93
++ @208 /* Why are you doing this? */ + 98
END


/* at the sewer exit. Imoen will be there. "Heya!" */

INTERJECT bdimoen 89 C#AfHSoD_bdimoen_89
== bdimoen @209 /* I mean, I *know* the Dukes would guarantee your free passage and all, but - did you see what is going on in the streets of the city? Think of all the crowds of people who took refuge - now imagine one half going against the other. It's *madness*! */
END
IF ~~ THEN DO ~SetGlobal("bd_plot","global",665)~ + sod_end

CHAIN
IF ~~ THEN bdimoen sod_end
@210 /* You know I went and looked for more compagnions the moment the Dukes mentioned they'd send you away. */
== bdimoen IF ~!Global("bd_meet_canon_party","bd6200",0)~ THEN @211 /* And I was successful! We don't have to go alone, <CHARNAME>. */
== bdimoen IF ~Global("bd_meet_canon_party","bd6200",0)~ THEN @212 /* I didn't find anyone else, <CHARNAME>. */
== bdimoen IF ~NumInPartyGT(1)~ THEN @213 /* Except for who is with us already, of course. */
== bdimoen @214 /* I will come with you anyway. I hope that's clear, eh, sleepyhead? */
END
IF ~~ THEN + 91
IF ~Global("C#IM_ImoenComesBackSoD","GLOBAL",1)~ THEN + 96 //I4E: Imoen went with the campaign

/* more reply options at clearing - what happened and where are we going */
CHAIN
IF ~~ THEN bdimoen skiemurderer
@222 /* ~[Imoen]Wow! That freaky hooded man would have killed Skie?!~ */
== BDKHALIJ IF ~Global("C#AfHSoD_KhalidKnowsHM","GLOBAL",0) IsValidForPartyDialogue("KHALID")~ THEN @221 /* ~[Khalid]Then we know what to d-do!~ */
== BDKHALIJ IF ~Global("C#AfHSoD_KhalidKnowsHM","GLOBAL",1) IsValidForPartyDialogue("KHALID")~ THEN @223 /* ~[Khalid]We will not stop until we f-found him!~ */
== BDKHALID IF ~!Dead("KHALID")
InMyArea("KHALID")
!InParty("KHALID")~ THEN @221 /* ~[Khalid]Then we know what to d-do!~ */
== BDJAHEIJ IF ~Global("C#AfHSoD_JaheiraKnowsHM","GLOBAL",0) IsValidForPartyDialogue("JAHEIRA")~ THEN @219 /* ~[Jaheira]So this "Hooded Man" not only played with you but also didn't stop at killing off friends to do so. This should serve as a warning what we'll have to expect from him if we do not treat him as the treat that he is.~ */
== BDJAHEIJ IF ~IsValidForPartyDialogue("JAHEIRA")~ THEN @224 /* ~[Jaheira]He certainly took a great interest in you, <CHARNAME>. Let's see whether it will be difficult to track him down - or whether he will make an appearance out of his own will. We should be prepared.~ */
== BDJAHEIR IF ~!Dead("JAHEIRA")
InMyArea("JAHEIRA")
!InParty("JAHEIRA")~ THEN @219 /* ~[Jaheira]So this "Hooded Man" not only played with you but also didn't stop at killing off friends to do so. This should serve as a warning what we'll have to expect from him if we do not treat him as the treat that he is.~ */
== BDJAHEIR IF ~!Dead("JAHEIRA")
InMyArea("JAHEIRA")
!InParty("JAHEIRA")~ THEN @224 /* ~[Jaheira]He certainly took a great interest in you, <CHARNAME>. Let's see whether it will be difficult to track him down - or whether he will make an appearance out of his own will. We should be prepared.~ */
== BDMINSCJ IF ~Global("C#AfHSoD_MinscKnowsHM","GLOBAL",0) IsValidForPartyDialogue("MINSC")~ THEN @218 /* ~[Minsc]Evil hooded man killed little Skie! We will kick his evil butt, won't we, Boo?~ */
== BDMINSC IF ~Global("C#AfHSoD_MinscKnowsHM","GLOBAL",0) !Dead("MINSC")
InMyArea("MINSC")
!InParty("MINSC")~ THEN @218 /* ~[Minsc]Evil hooded man killed little Skie! We will kick his evil butt, won't we, Boo?~ */
== BDDYNAHJ IF ~Global("C#AfHSoD_DynaheirKnowsHM","GLOBAL",0) IsValidForPartyDialogue("DYNAHEIR")~ THEN @220 /* ~[Dynaheir]A skillful mage, interested in your Bhaal heritage, and not for friendly reasons. We will remain wary. The number of foes is numerous for a Bhaalchild.~ */
== BDDYNAHE IF ~Global("C#AfHSoD_DynaheirKnowsHM","GLOBAL",0) !Dead("DYNAHEIR")
InMyArea("DYNAHEIR")
!InParty("DYNAHEIR")~ THEN @220 /* ~[Dynaheir]A skillful mage, interested in your Bhaal heritage, and not for friendly reasons. We will remain wary. The number of foes is numerous for a Bhaalchild.~ */
END
IF ~~ THEN EXTERN bdimoen skiemurderer_101

CHAIN
IF ~~ THEN bdimoen where_to
@225 /* ~Ookay - I see your point.~ */
== BDJAHEIJ IF ~GlobalGT("C#AfH_PortalQuest","GLOBAL",0) IsValidForPartyDialogue("JAHEIRA")~ THEN @226 /* ~[Jaheira]The Dukes sent us south, to Amn. This is where we should be headed.~ */
== BDJAHEIJ IF ~IsValidForPartyDialogue("JAHEIRA")~ THEN @227 /* ~[Jaheira]We do not know when and where the Hooded Man will seek you out again. We need to reach lands where your name is not tainted as the powerful Bhaal spawn you are, and where we can rest and gather our strength before the next confrontation.~ */
== BDJAHEIR IF ~GlobalGT("C#AfH_PortalQuest","GLOBAL",0) !Dead("JAHEIRA")
InMyArea("JAHEIRA")
!InParty("JAHEIRA")~ THEN @226 /* ~[Jaheira]The Dukes sent us south, to Amn. This is where we should be headed.~ */
== BDJAHEIR IF ~!Dead("JAHEIRA")
InMyArea("JAHEIRA")
!InParty("JAHEIRA")~ THEN @227 /* ~[Jaheira]We do not know when and where the Hooded Man will seek you out again. We need to reach lands where your name is not tainted as the powerful Bhaal spawn you are, and where we can rest and gather our strength before the next confrontation.~ */ 
== BDKHALIJ IF ~IsValidForPartyDialogue("KHALID")~ THEN @228 /* ~[Khalid]We should p-proceed south for now. Your name will not stir as much trouble there, which will give us time to come up with a plan.~ */
== BDKHALID IF ~!Dead("KHALID")
InMyArea("KHALID")
!InParty("KHALID")~ THEN @228 /* ~[Khalid]We should p-proceed south for now. Your name will not stir as much trouble there, which will give us time to come up with a plan.~ */
== BDDYNAHJ IF ~GlobalGT("C#AfH_PortalQuest","GLOBAL",0) IsValidForPartyDialogue("DYNAHEIR")~ THEN @229 /* ~[Dynaheir]Metamages - or Incantrices, as they are called - are very powerful magic wielders. The Dukes did wise to send thee after one of them.~ */
== BDDYNAHJ IF ~IsValidForPartyDialogue("DYNAHEIR")~ THEN @230 /* ~[Dynaheir]South is the obvious choice for now, as it seems.~ */
== BDDYNAHE IF ~GlobalGT("C#AfH_PortalQuest","GLOBAL",0) !Dead("DYNAHEIR")
InMyArea("DYNAHEIR")
!InParty("DYNAHEIR")~ THEN @229 /* ~[Dynaheir]Metamages - or Incantrices, as they are called - are very powerful magic wielders. The Dukes did wise to send thee after one of them.~ */
== BDDYNAHE IF ~!Dead("DYNAHEIR")
InMyArea("DYNAHEIR")
!InParty("DYNAHEIR")~ THEN @230 /* ~[Dynaheir]South is the obvious choice for now, as it seems.~ */
== BDMINSCJ IF ~IsValidForPartyDialogue("MINSC")~ THEN @231 /* ~[Minsc]Minsc is happy as long as there will be nuts for Boo! And evil butt to kick and free little Skie.~ */
== BDMINSC IF ~!Dead("MINSC")
InMyArea("MINSC")
!InParty("MINSC")~ THEN @231 /* ~[Minsc]Minsc is happy as long as there will be nuts for Boo! And evil butt to kick and free little Skie.~ */
== bdimoen @232 /* ~I guess south is a good way to go for now. And it's away from Baldur's Gate *and* Dragonspear Castle both!~ */
END
IF ~~ THEN EXTERN bdimoen where_to_01

APPEND bdimoen
IF ~~ THEN skiemurderer_101
SAY @233 /* ~[Imoen]We won't stop until we'll find him, <CHARNAME>! Will we?~ */
+ ~Global("C#AfHSoD_bdimoen101_WT","MYAREA",0)~ + @234 /* ~[PC Reply]We need to discuss where we will be going from here, the sooner the better.~ */ DO ~SetGlobal("C#AfHSoD_bdimoen101_WT","MYAREA",1)~ + where_to
COPY_TRANS bdimoen 101
END

IF ~~ THEN where_to_01
SAY ~[Imoen]Are we ready to go then?~
+ ~Global("C#AfHSoD_bdimoen101_HM","MYAREA",0)~ + @235 /* ~[PC Reply]The murderer of Skie - I know who it is, it was the hooded man that was stalking me for my Bhaal heritage.~ */ DO ~SetGlobal("C#AfHSoD_bdimoen101_HM","MYAREA",1)~ + skiemurderer
COPY_TRANS bdimoen 101
END
END //APPEND

/* More reply options. This comes here after using COPY_TRANS above */
/* bdimoen 101 ~Could we maybe talk about this someplace, you know—far away from here?~ [BD39717] */
EXTEND_BOTTOM bdimoen 101 
/* tell default NPCs about Hooded Man who killed Skie */
++ @235 /* ~[PC Reply]The murderer of Skie - I know who it is, it was the hooded man that was stalking me for my Bhaal heritage.~ */ DO ~SetGlobal("C#AfHSoD_bdimoen101_HM","MYAREA",1)~ + skiemurderer
++ @234 /* ~[PC Reply]We need to discuss where we will be going from here, the sooner the better.~ */ DO ~SetGlobal("C#AfHSoD_bdimoen101_WT","MYAREA",1)~ + where_to
END

I_C_T3 bdimoen 129 C#AfHSoD_bdimoen_129
== bdjaheij IF ~InMyArea("Jaheira") InParty("Jaheira") !StateCheck("Jaheira",CD_STATE_NOTVALID)~ THEN @215 /* [Jaheira]It might be good to clear our heads and think about how we'll go on about fulfilling what the Dukes asked of you, <CHARNAME>. With no means to track down the hooded man, it will be a long way ahead of us. */
END

-- SRC:
-- https://github.com/Difficulty-Immersion-Quality/DIQ-Misc-Patches/blob/main/DIQ%20Misc%20Patches/Mods/ManyMoreMonsters/ScriptExtender/Lua/MonsterJam/Wildlands.lua

--Why did I make so many things oh god
local Null = "NULL_00000000-0000-0000-0000-000000000000"
local Wyll = "S_Player_Wyll_c774d764-4a17-48dc-b470-32ace9ce447d"
local Zevlor = "S_DEN_TieflingLeader_475200ee-cc3c-4dbe-84b1-1820c02ea26a"
local LostID = "MMM_LOSTINTELLECT_c518330d-cc41-46f5-a9c7-bddc8738f993"
local Adam1 = "MMM_THIEFTRIO_ab8be8db-2ad3-4a8f-819f-e58a3d1eacc5"
local Mike1 = "MMM_THIEFTRIO_ccdeaaba-50e9-4e61-8f3c-912839e0a930"
local Liam1 = "MMM_THIEFTRIO_b07175bc-6ba7-4043-a9fb-9c36b9ab3af2"
local AmbushID1 = "998da1c1-b588-4d92-b673-7bad5c71095e"
local AmbushID2 = "75db3611-eca6-41b6-ac65-23a0efe7129c"
local AmbushMF = "b45c012b-05f9-4252-9960-fade2c05ee34"
local AmbushGob1 = "MMM_GOBCRASHAMBUSH_73519ba4-833f-4f9d-9eac-ab5a5b3983f8"
local AmbushGob2 = "MMM_GOBCRASHAMBUSH_0fc76ab7-46d9-4aaa-8019-0b1478e90cc4"
local AmbushGob3 = "MMM_GOBCRASHAMBUSH_d32a13dc-771a-4a96-94c6-ec728aa23613"
local Zakrug = "22d80f21-7f31-4240-b981-9137d53ad77d"
local Oof = "MMM_OOF_1119bea0-a63f-4617-99ab-7f0af17bfdf4"
local BridgeTroll = "MMM_BRIDGETROLL_711e0cb6-6d7d-4233-9157-2a218f5f348d"
local BugbearChallenger = "46545754-5089-4e85-b34d-81395e5ebb44"
local Buthir = "S_FOR_OgreMate_489c7f56-b461-41a6-b519-7ef5f1a1bbdc"
local Grukkoh = "S_FOR_BugBearMate_b6c6764f-ba9d-4109-8b4e-c0d1da72be7d"
local Bogsnap = "MMM_ITSCOMPLICATED_fee2b522-e440-4fae-9b9a-a597cf03c434"
local Slegbezzle = "MMM_ITSCOMPLICATED_4295596a-1cae-45ff-a481-e29ca6d616ec"
local Chickenrunner = "MMM_CHICKENRUN_e3be0621-86c4-4da5-882d-288098db0274"
local Chickenguard = "MMM_CHICKENRUN_5915b958-417f-459f-8b33-157b1b8d7c3a"
local Chicken1 = "MMM_CHICKENRUN_1bdc583b-760b-40ea-9ec7-5337ba025ab2"
local Chicken2 = "MMM_CHICKENRUN_c1d24765-6202-4899-a016-e99826708647"
local Chicken3 = "MMM_CHICKENRUN_fbd9eefa-0fe2-4f9c-833e-0ed18f717c04"
local Chicken4 = "MMM_CHICKENRUN_399df9f7-510d-451e-a95d-39c94e01067a"
local Chicken5 = "MMM_CHICKENRUN_b62f031c-0fe7-4e12-9b0e-71867f2ce2c3"
local GoblinPee = "8ab4d871-bc1c-4045-93d2-91234ff163d8"
local BackdoorGnoll1 = "d743f4f3-2dae-47cb-bfb2-ec4332881937"
local BackdoorGnoll2 = "bd069598-65c0-47ab-819c-8a8bbef5fc27"
local BackdoorGnoll3 = "31da9358-a6a4-4a98-a199-85e09dea5b0e"
local Flind = "S_PLA_ConflictedFlind_Gnoll_Ranger_01_8c73365b-a23e-4aba-b556-fa7dedc8d33b"
local DrowAssassin1 = "MMM_DROWASSASSIN_fc6882a1-2ed2-4d0d-8a59-86e8b5467d7f"
local DrowAssassin2 = "MMM_DROWASSASSIN_e2dec5a0-45c6-4352-9f23-c78707ad0b17"
local DrowAssassin3 = "MMM_DROWASSASSIN_4de60d52-2fcd-4221-b92f-83d5341e36ea"
local JuvDragon = "c0ce95ee-8112-4977-a2bf-97f53d051cf7"
local OlGregg = "14541d9b-7fcc-4cd4-adde-2a36ea204163"
local DSpider0 = "MMM_TINYDEFILEDSPIDY_bd90907e-e315-4432-b54d-1e87e232042d"
local DSpider11 = "MMM_TINYDEFILEDSPIDY_9a9d6d3f-75a8-41ce-a548-2f467626b729"
local DSpider12 = "MMM_TINYDEFILEDSPIDY_e1002219-2a46-42e9-9b09-93ef6c63fcc4"
local DSpider13 = "MMM_TINYDEFILEDSPIDY_a1bd6f70-60f3-426f-bf72-04d2273148ab"
local DSpider14 = "MMM_TINYDEFILEDSPIDY_16863871-249e-4f7b-ae5d-986df3494fa2"
local DSpider15 = "MMM_TINYDEFILEDSPIDY_384fc0e4-5a0f-4e7d-a62f-2143a79a9a30"
local DSpider16 = "MMM_TINYDEFILEDSPIDY_ed9dffff-49f2-4a9e-b605-08d3c81e143b"
local DSpider17 = "MMM_TINYDEFILEDSPIDY_b75c83fb-e8fb-4cbc-9a68-de871ee6e5ca"
local DSpider18 = "MMM_TINYDEFILEDSPIDY_7e158ab9-755a-4bad-90c5-1056531ccb3e"
local DSpider19 = "MMM_TINYDEFILEDSPIDY_bddc48f4-e940-43db-957f-97fab968be99"
local DSpider110 = "MMM_TINYDEFILEDSPIDY_4f909f4e-5c5b-4719-9d0a-53965a24d3de"
local DSpider111 = "MMM_TINYDEFILEDSPIDY_26237c20-2a8e-49a8-9951-b387e50e0301"
local DSpider112 = "MMM_TINYDEFILEDSPIDY_1cd36f3e-51ca-42d2-aac9-6a0fe9c311c8"
local DSpider21 = "MMM_TINYDEFILEDSPIDY_3d73e245-a580-476a-b42b-4fd2e1a1aace"
local DSpider22 = "MMM_TINYDEFILEDSPIDY_fcb0a5d1-9062-42ff-ac2a-5fe5499e319d"
local DSpider23 = "MMM_TINYDEFILEDSPIDY_5d752712-121f-4132-9a5d-8ba2cc495cdb"
local DSpider24 = "MMM_TINYDEFILEDSPIDY_1b5144e6-ec2f-43a9-9763-816976ac5227"
local DSpider25 = "MMM_TINYDEFILEDSPIDY_6985939e-e70e-4e21-a0f2-f6a15f5b952a"
local DSpider26 = "MMM_TINYDEFILEDSPIDY_78a60a46-7aca-4d26-a457-04c71d05617a"
local DSpider27 = "MMM_TINYDEFILEDSPIDY_5cfaad47-8498-4488-839b-1528581c313b"
local DSpider28 = "MMM_TINYDEFILEDSPIDY_6eb8deb4-89de-4c08-a40a-c901281f1a48"
local DSpider29 = "MMM_TINYDEFILEDSPIDY_f64a2651-4da6-43f0-8f83-40145ff18b78"
local DSpider210 = "MMM_TINYDEFILEDSPIDY_dcfc07e3-04f9-43c7-8e47-6b08cae3dc37"
local DSpider211 = "MMM_TINYDEFILEDSPIDY_2a49bd3d-30f0-4120-8c58-29f549cb96ab"
local DSpider212 = "MMM_TINYDEFILEDSPIDY_b437de35-9d28-4ba9-8dbb-923a138cd94f"
local ZhentDog = "71cc2238-b47d-410b-93a3-6c7655c6169b"
local DuergarTrigger1 = "MMM_TRIGGERPOINT_DUERGAR_c10f43ec-a507-4ce2-ad95-ce4f053447bc"
local DuergarTrigger2 = "MMM_TRIGGERPOINT_DUERGAR_fce833ba-a2af-451f-94fe-0459db3afa38"
local DArmyRanger = "f1a2a17b-01bf-4db0-a243-96a8fd51143f"
local DArmyCleric1 = "5cb04855-2d47-4c17-96d5-eb6f9d5a3195"
local DArmyNecro = "ab119210-5a8a-4121-afc5-6ba1d2f41d7c"
local DArmyFighter = "d3806ca4-a30b-4a57-886e-367c72a4283b"
local DArmyCleric2 = "92751f24-cd64-4627-9cbd-6ff0660b8acd"
local DockDuergar = "5b7acfc9-269d-49ba-a2de-727cde8f7f3c"
local AlphaM = "MMM_AMINOTAUR_3cefad8c-5cad-4821-a7c7-77ec2201db48"
local WeakBeholder = "558beb96-818b-4377-997e-2958aaad0645"
local LolthTrigger = "MMM_TRIGGERPOINT_LOLTH_d07a376c-68c1-4201-946c-bbf4eeca1339"
local LolthRanger = "8ac2a3ed-6c1f-4bc6-b438-f394e0301567"
local LolthCleric = "c7cdd75a-5a88-4ace-a723-0ef34acd0c25"
local LolthDrider = "02c83cab-7c83-4a66-a26d-a2d7b0c6930f"
local MamaBulette = "S_UND_Bulette_307934b5-6fb5-4fdc-a7ff-433a7ba175b3"
local BuletteTrigger = "6d1577e4-9c79-46f6-8b9a-d61539710b22"
local Bulette1 = "MMM_BULETTEBABY_03ee80fc-bba1-4bf6-b665-11d61f3d03b6"
local Bulette2 = "MMM_BULETTEBABY_b668a3d5-821b-497f-9f0f-2e8c4407060d"
local Bulette3 = "MMM_BULETTEBABY_a714b6b4-ad5c-4b2c-bd23-c71ca8db6441"
local Bulette4 = "MMM_BULETTEBABY_4d99d3ff-f468-47e2-9c59-1c2b22b11f47"
local Bulette5 = "MMM_BULETTEBABY_099e4ee1-4d67-4adb-926c-8fd4ab4e3114"
local Bulette6 = "MMM_BULETTEBABY_741543fc-bbb1-412d-b503-89508b2f7d37"
local Bulette7 = "MMM_BULETTEBABY_1644c2be-d7c5-413b-9b5e-65a5e6090111"
local Bulette8 = "MMM_BULETTEBABY_81aeeb8c-59d9-4d4d-adaf-b0b7d431f3f9"
local Bulette9 = "MMM_BULETTEBABY_b63e752d-e682-4e1a-8583-da24eed44ba2"
local HarperMimic1 = "S_UND_HarperSpy_RealMimic_000_6cb8e7a4-5247-4f93-9781-1fa9712355e5"
local HarperMimic2 = "S_UND_HarperSpy_RealMimic_001_23158926-5f3e-4997-a04e-bbebdd914e13"
local HarperMimic3 = "S_UND_HarperSpy_RealMimic_002_f0e2d852-b374-4e51-ac9d-d429ffdaac33"
local MegaMimic = "MMM_MIMICBOSS_533cfc38-9097-4b0d-b457-e78719463757"
local LavaElemental = "MMM_LAVAELEMENTAL_bc37c6a1-ed92-4f31-92a4-7ce718ffc5b6"
local Grym = "2a5997fc-5f2a-4a13-b309-bed16da3b255"
local Grym2 = "MMM_GRYM2_a251f7c6-5a4e-49d9-984b-501c8a3aba65"
local ForgeGhost1 = "MMM_FORGEGHOST_a075abe3-fc24-4887-a3ab-afbbc651f1ee"
local ForgeGhost2 = "MMM_FORGEGHOST_0eaeb8bc-fd5a-46bf-9c20-51d302c89f88"
local ForgeMephit1 = "S_UND_AdamantinteGolem_Mephit_001_c33491f2-17f1-48bd-ad4c-7df70049025e"
local ForgeMephit2 = "S_UND_AdamantinteGolem_Mephit_002_e96e33ae-870c-4cc2-9742-201e61dbe162"
local ForgeMephit3 = "S_UND_AdamantinteGolem_Mephit_003_2c07b751-f1d1-41f9-a3a6-1f9597171b32"
local ForgeMephit4 = "S_UND_AdamantinteGolem_Mephit_004_8df15cf3-5880-4618-8c5d-b1522dff1bac"
local Act1Mimic = "MMM_ACT1MIMIC_de1e25f5-fa08-430a-aaf8-e0cc80406ba6"

--Boss Markers
local GrymBossMarker = "MMM_BOSSMARKER_02c3342c-d419-4ccc-824d-7ed706d20dee"
local RedDragonBossMarker = "MMM_BOSSMARKER_60a347be-473c-4b4f-b7a1-7622961e8659"

--Mimic Chest List
local Act1Chest1 = "MMM_ACT1CHEST_6bce32e3-8b70-4a61-adde-49a8a15a51e4"
local Act1Chest2 = "MMM_ACT1CHEST_76105be3-32e8-47af-a349-472a5bb4bedc"
local Act1Chest3 = "MMM_ACT1CHEST_24d5a7df-86c4-42e4-8ab0-4608597ed46a"
local Act1Chest4 = "MMM_ACT1CHEST_7697cae3-4d92-4690-9668-7e9a9f780801"
local Act1Chest5 = "MMM_ACT1CHEST_4a88d86b-1c54-40c7-82bd-db49be0465bc"
local Act1Chest6 = "MMM_ACT1CHEST_a28b7500-27a9-4cb3-af6f-1e4b1b22ad6f"
local Act1Chest7 = "MMM_ACT1CHEST_e8608a5f-05b5-45a6-82e8-a0f796ed03c9"
local Act1Chest8 = "MMM_ACT1CHEST_3a7cd481-8709-47b8-a6f1-aab9a3df12bf"
local Act1Chest9 = "MMM_ACT1CHEST_eaa884a3-efd1-4cf2-ac58-7bc59da0b88a"
local Act1Chest10 = "MMM_ACT1CHEST_a47cebed-1d30-4b99-857b-b29565553359"
local Act1Chest11 = "MMM_ACT1CHEST_42a9cbf6-11ac-4e9d-83a0-1719378d7016"
local Act1Chest12 = "MMM_ACT1CHEST_480b028a-7d81-452b-95d3-583b446224e5"
local Act1Chest13 = "MMM_ACT1CHEST_997f3c18-8fc6-4692-a96f-7b8873a7adc8"
local Act1Chest14 = "MMM_ACT1CHEST_aec3d70d-e607-48db-bea0-1e55cf496481"
local Act1Chest15 = "MMM_ACT1CHEST_5d4679f9-c7fe-44e5-a8f2-dec79decd51d"
local Act1Chest16 = "MMM_ACT1CHEST_ed253ca1-0d8c-4b8f-ae90-8e0bc80b3e2b"

--Factions
local FGoblinRaiders = "ACT1_DEN_GoblinRaiders_6f5d49b5-1dc8-6226-e625-f0267cdbbbff"
local FZevlor = "ACT1_DEN_TieflingLeader_a3297c6f-87d1-37c4-a81d-d769d52c88a9"
local FPlayer = "Hero_Player1_6545a015-1b3d-66a4-6a0e-6ec62065cdb7"
local FEvil = "Evil_NPC_64321d50-d516-b1b2-cfac-2eb773de1ff6"
local FBulette = "ACT1_UND_Bulette_66e48914-933e-4960-85a3-a6c3e171da9d"
local FSexCouple = "ACT1_FOR_BugBearCouple_9604d2bf-346f-4573-80a7-e02f3aaf9a10"
local FHGith = "ACT1_PLA_GithChokepointHostile_ae4c996b-5040-4c68-b682-0314e0334d35"

--Flags
local InitiateAct1 = "MMM_Act1_Initiate_d5eb10ac-e464-4a4a-86b2-92f682775da5"
local Act1MimicFlag = "MMM_Act1_Mimics_cebdd7f4-380d-4cf3-9789-a182d7df0c24"
local GoblinCrashFlag = "MMM_Act1_GoblinAmbush_28c414d1-9ad8-4ca4-b978-cf0253c1e92e"
local DrowAmbush1Flag = "MMM_Act1_DrowAmbush1_b496db28-d908-467b-b15f-ec22ac843685"
local DrowAmbush2Flag = "MMM_Act1_DrowAmbush2_a11b76aa-3fe6-45c3-9881-41e8a2017f38"
local DrowAmbush3Flag = "MMM_Act1_DrowAmbush3_ecdd54ff-3966-44d0-b5e2-64f532c5b3bb"
local DuergarMarchFlag = "MMM_Act1_DuergarArmy_785915dc-33ab-4991-9a9d-7e1c85b948f0"
local Act1AdamFlag = "MMM_Act1_Adam_f050757b-cfae-4301-a745-dcb73d4b6de7"
local Act1LiamFlag = "MMM_Act1_Liam_88ad30aa-c051-403b-914b-47b3ddd5da53"
local Act1MikeFlag = "MMM_Act1_Mike_ab0233fc-f112-4778-8dd7-da9cad510a63"
local OofFlag = "MMM_Act1_Oof_70df2597-5bd3-409a-ba68-b1206849e010"

--Tags
local GoblinCrashTag = "MMM_Act1_GoblinCrash_8869085a-bea0-42b6-972d-0701c0365bd0"
local DrowAmbush1Tag = "MMM_Act1_DrowAmbush1_98ec443f-1c41-42b9-851d-4437e955f74f"
local DrowAmbush2Tag = "MMM_Act1_DrowAmbush2_8b9725a4-4845-471b-bad2-6ae657b4ac5e"
local DrowAmbush3Tag = "MMM_Act1_DrowAmbush3_fcfcbe25-ff6b-4848-abec-2050bc896262"

--Everything to run on first load
local function InitiateMonsters()
    Osi.SetOnStage(Oof, 0)
    Osi.SetOnStage(Bogsnap, 0)
    Osi.SetOnStage(Slegbezzle, 0)
    Osi.SetOnStage(Chickenrunner, 0)
    Osi.SetOnStage(Chicken1, 0)
    Osi.SetOnStage(Chicken2, 0)
    Osi.SetOnStage(Chicken3, 0)
    Osi.SetOnStage(Chicken4, 0)
    Osi.SetOnStage(Chicken5, 0)
    Osi.SetOnStage(OlGregg, 0)
    Osi.SetOnStage(DSpider11, 0)
    Osi.SetOnStage(DSpider12, 0)
    Osi.SetOnStage(DSpider13, 0)
    Osi.SetOnStage(DSpider14, 0)
    Osi.SetOnStage(DSpider15, 0)
    Osi.SetOnStage(DSpider16, 0)
    Osi.SetOnStage(DSpider17, 0)
    Osi.SetOnStage(DSpider18, 0)
    Osi.SetOnStage(DSpider19, 0)
    Osi.SetOnStage(DSpider110, 0)
    Osi.SetOnStage(DSpider111, 0)
    Osi.SetOnStage(DSpider112, 0)
    Osi.SetOnStage(DSpider21, 0)
    Osi.SetOnStage(DSpider22, 0)
    Osi.SetOnStage(DSpider23, 0)
    Osi.SetOnStage(DSpider24, 0)
    Osi.SetOnStage(DSpider25, 0)
    Osi.SetOnStage(DSpider26, 0)
    Osi.SetOnStage(DSpider27, 0)
    Osi.SetOnStage(DSpider28, 0)
    Osi.SetOnStage(DSpider29, 0)
    Osi.SetOnStage(DSpider210, 0)
    Osi.SetOnStage(DSpider211, 0)
    Osi.SetOnStage(DSpider212, 0)
    Osi.SetOnStage(WeakBeholder, 0)
    Osi.SetOnStage(LolthRanger, 0)
    Osi.SetOnStage(LolthCleric, 0)
    Osi.SetOnStage(LolthDrider, 0)
    Osi.SetOnStage(Bulette1, 0)
    Osi.SetOnStage(Bulette2, 0)
    Osi.SetOnStage(Bulette3, 0)
    Osi.SetOnStage(Bulette4, 0)
    Osi.SetOnStage(Bulette5, 0)
    Osi.SetOnStage(Bulette6, 0)
    Osi.SetOnStage(Bulette7, 0)
    Osi.SetOnStage(Bulette8, 0)
    Osi.SetOnStage(Bulette9, 0)
    Osi.SetOnStage(MegaMimic, 0)
    Osi.SetOnStage(LavaElemental, 0)
    Osi.SetOnStage(Grym2, 0)
    Osi.SetOnStage(ForgeGhost1, 0)
    Osi.SetOnStage(ForgeGhost2, 0)
    Osi.SetOnStage(JuvDragon, 0)
end

--Things to run each time the map loads
local function ModifyMonsters()
    Osi.PROC_SelfHealing_Disable(LostID)
    Osi.PROC_SelfHealing_Disable(AmbushMF)
    Osi.PROC_SelfHealing_Disable(AmbushID1)
    Osi.PROC_SelfHealing_Disable(AmbushID2)
    Osi.PROC_SelfHealing_Disable(BackdoorGnoll1)
    Osi.PROC_SelfHealing_Disable(BackdoorGnoll2)
    Osi.PROC_SelfHealing_Disable(BackdoorGnoll3)
    Ext.Timer.WaitFor(100, function()
        Osi.SetHitpointsPercentage(LostID, 60.0)
        Osi.SetHitpointsPercentage(AmbushMF, 50.0)
        Osi.SetHitpointsPercentage(AmbushID1, 60.0)
        Osi.SetHitpointsPercentage(AmbushID2, 60.0)
    end)
end

--if anything needs to be removed
local function RemoveItems()
    Osi.SetOnStage("91995501-aae2-4de9-97d3-f7c3f228c004", 0)
    Osi.SetOnStage("aff0d85e-5f14-4bbd-b7f0-eccde077e2c3", 0)
    Osi.SetOnStage("PUZ_Underdark_Mushroom_Timmask_B_003_54e4f416-1212-43a6-9544-6a6bdde1a17b", 0)
    Osi.SetOnStage("PUZ_Underdark_Mushroom_Timmask_A_002_f2707952-6099-40ff-9f48-314b05c4e07c", 0)
end

--Create Mimics
local function CreateAct1Mimics()
    local Act1ChestList = { Act1Chest1, Act1Chest2, Act1Chest3, Act1Chest4, Act1Chest5, Act1Chest6, Act1Chest7, Act1Chest8, Act1Chest9, Act1Chest10,
                            Act1Chest11, Act1Chest12, Act1Chest13, Act1Chest14, Act1Chest15, Act1Chest16 }
    for _,PossibleMimic in ipairs(Act1ChestList) do
    local IsItAMimic = Ext.Utils.Random(1,5)
        if IsItAMimic == 1 then
            print("Mimic")
            Osi.ApplyStatus(PossibleMimic, "MMM_MIMIC1", -1, 1, PossibleMimic)
        elseif IsItAMimic == 2 then
            print("Not a mimic, chest not hidden")
        elseif IsItAMimic == 3 then
            print("Not a mimic, chest not hidden")
        elseif IsItAMimic == 4 then
            print("Not a mimic, chest hidden")
            Osi.SetOnStage(PossibleMimic, 0)
        elseif IsItAMimic == 5 then
            print("Not a mimic, chest hidden")
            Osi.SetOnStage(PossibleMimic, 0)
        end
    end
end

function TurnIntoMimic1(item, character)
    if Osi.IsDead(item) == 1 then
        return
    end
    local x,y,z = Osi.GetPosition(item)
    local MimicSpawnID = Osi.CreateAt(Act1Mimic, x, y, z, 0, 1, '')
    if MimicSpawnID then
        if (Osi.HasActiveStatus(character,"AMBUSH_IMMUNITY") == 1 or Osi.HasPassive(character, "Alert") == 1 or Osi.HasPassive(character, "Surprise_Immunity") == 1) and Osi.IsPlayer(character) == 1 then
            Osi.QRY_StartDialogCustom_Fixed("GLO_PAD_Mimic_Revealed_55471c86-3b69-ccae-d0e3-e8749cf41d9e", character, Null, Null, Null, Null, Null, 1, 1, -1, 1 )
        elseif Osi.HasActiveStatus(character,"AMBUSH_IMMUNITY") ~= 1 and Osi.HasPassive(character, "Alert") ~= 1 and Osi.HasPassive(character, "Surprise_Immunity") ~= 1 and Osi.IsPlayer(character) == 1 then
            Osi.QRY_StartDialogCustom_Fixed("GLO_PAD_Mimic_Surprised_cb5f94c8-ee5b-c17a-959c-64bc6f88b417", character, Null, Null, Null, Null, Null, 1, 1, -1, 1 )
        end
        Osi.MoveAllItemsTo(item, MimicSpawnID, 0, 0, 1)
    end
    Osi.SetOnStage(item, 0)
end

--set urinating goblin animation
local function UrinatingGoblin()
    if (Osi.IsDead(GoblinPee) == 0) then
        Osi.PlayLoopingAnimation(GoblinPee, "CUST_Stretching_01_9af703b0-c02f-4c17-bfee-7e11f1f80d6b", "CUST_Urinating_01_d7b689ac-2183-4c62-a481-eb5db76ac243", "CUST_Stretching_01_9af703b0-c02f-4c17-bfee-7e11f1f80d6b", "", "", "", "")
    end
end

--Intellect devourer 1 moving randomly
local function ID1WalkAround()
    if ((Osi.IsDead(AmbushID1) == 0) and Osi.IsInCombat(AmbushID1) == 0) then
        local ID1RandomNumber = Ext.Utils.Random(1, 6)
        if ID1RandomNumber == 1 then
            Osi.CharacterMoveToPosition(AmbushID1, 175.19821166992, 11.845703125, 321.48937988281, "Walk", "", 0)
        elseif ID1RandomNumber == 2 then
            Osi.CharacterMoveToPosition(AmbushID1, 178.29122924805, 11.8056640625, 326.66683959961, "Walk", "", 0)
        elseif ID1RandomNumber == 3 then
            Osi.CharacterMoveToPosition(AmbushID1, 183.79467773438, 12.64453125, 324.28033447266, "Walk", "", 0)
        elseif ID1RandomNumber == 4 then
            Osi.CharacterMoveToPosition(AmbushID1, 171.04406738281, 12.0458984375, 324.17138671875, "Walk", "", 0)
        elseif ID1RandomNumber == 5 then
            Osi.CharacterMoveToPosition(AmbushID1, 173.46469116211, 12.380859375, 332.41180419922, "Walk", "", 0)
        elseif ID1RandomNumber == 6 then
            Osi.CharacterMoveToPosition(AmbushID1, 179.89080810547, 11.873046875, 320.41668701172, "Walk", "", 0)
        end
        local ID1WaitTImer = Ext.Utils.Random(1, 6)
        if ID1WaitTImer == 1 then
            Ext.Timer.WaitFor(6000, function()
                ID1WalkAround()
            end)
        elseif ID1WaitTImer == 2 then
            Ext.Timer.WaitFor(4000, function()
                ID1WalkAround()
            end)
        elseif ID1WaitTImer == 3 then
            Ext.Timer.WaitFor(6000, function()
                ID1WalkAround()
            end)
        elseif ID1WaitTImer == 4 then
            Ext.Timer.WaitFor(8000, function()
                ID1WalkAround()
            end)
        elseif ID1WaitTImer == 5 then
            Ext.Timer.WaitFor(10000, function()
                ID1WalkAround()
            end)
        elseif ID1WaitTImer == 6 then
            Ext.Timer.WaitFor(12000, function()
                ID1WalkAround()
            end)
        end
    end
end

--Intellect devourer 2 moving randomly
local function ID2WalkAround()
    if ((Osi.IsDead(AmbushID2) == 0) and Osi.IsInCombat(AmbushID2) == 0) then
        local ID1RandomNumber = Ext.Utils.Random(1, 6)
        if ID1RandomNumber == 1 then
            Osi.CharacterMoveToPosition(AmbushID2, 175.19821166992, 11.845703125, 321.48937988281, "Walk", "", 0)
        elseif ID1RandomNumber == 2 then
            Osi.CharacterMoveToPosition(AmbushID2, 178.29122924805, 11.8056640625, 326.66683959961, "Walk", "", 0)
        elseif ID1RandomNumber == 3 then
            Osi.CharacterMoveToPosition(AmbushID2, 183.79467773438, 12.64453125, 324.28033447266, "Walk", "", 0)
        elseif ID1RandomNumber == 4 then
            Osi.CharacterMoveToPosition(AmbushID2, 171.04406738281, 12.0458984375, 324.17138671875, "Walk", "", 0)
        elseif ID1RandomNumber == 5 then
            Osi.CharacterMoveToPosition(AmbushID2, 173.46469116211, 12.380859375, 332.41180419922, "Walk", "", 0)
        elseif ID1RandomNumber == 6 then
            Osi.CharacterMoveToPosition(AmbushID2, 179.89080810547, 11.873046875, 320.41668701172, "Walk", "", 0)
        end
        local ID1WaitTImer = Ext.Utils.Random(1, 6)
        if ID1WaitTImer == 1 then
            Ext.Timer.WaitFor(6000, function()
                ID2WalkAround()
            end)
        elseif ID1WaitTImer == 2 then
            Ext.Timer.WaitFor(4000, function()
                ID2WalkAround()
            end)
        elseif ID1WaitTImer == 3 then
            Ext.Timer.WaitFor(6000, function()
                ID2WalkAround()
            end)
        elseif ID1WaitTImer == 4 then
            Ext.Timer.WaitFor(8000, function()
                ID2WalkAround()
            end)
        elseif ID1WaitTImer == 5 then
            Ext.Timer.WaitFor(10000, function()
                ID2WalkAround()
            end)
        elseif ID1WaitTImer == 6 then
            Ext.Timer.WaitFor(12000, function()
                ID2WalkAround()
            end)
        end
    end
end

--Patrolling Minotaur
local function PatrollingMinotaur()
    if Osi.IsDead(AlphaM) == 0 and
    Osi.IsInCombat(AlphaM) == 0 and
    Osi.IsTagged(AlphaM, "e45d5440-4a29-42e1-845d-890ae8e82a63") == 0 then
        Osi.CharacterMoveToPosition(AlphaM, 169.73611450195, 53.6142578125, -183.00788879395, "Walk", "", 0)
        Ext.Timer.WaitFor(8000, function()
            if Osi.IsDead(AlphaM) == 0 and
            Osi.IsInCombat(AlphaM) == 0 and
            Osi.IsTagged(AlphaM, "e45d5440-4a29-42e1-845d-890ae8e82a63") == 0 then
                Osi.CharacterMoveToPosition(AlphaM, 156.88412475586, 52.0478515625, -190.68255615234, "Walk", "", 0)
                Ext.Timer.WaitFor(8000, function()
                    if Osi.IsDead(AlphaM) == 0 and
                    Osi.IsInCombat(AlphaM) == 0 and
                    Osi.IsTagged(AlphaM, "e45d5440-4a29-42e1-845d-890ae8e82a63") == 0 then
                        Osi.CharacterMoveToPosition(AlphaM, 142.38371276855, 48.875, -166.44003295898, "Walk", "", 0)
                        Ext.Timer.WaitFor(8000, function()
                            if Osi.IsDead(AlphaM) == 0 and
                            Osi.IsInCombat(AlphaM) == 0 and
                            Osi.IsTagged(AlphaM, "e45d5440-4a29-42e1-845d-890ae8e82a63") == 0 then
                                Osi.CharacterMoveToPosition(AlphaM, 137.67384338379, 53.431640625, -153.70143127441, "Walk", "", 0)
                                Ext.Timer.WaitFor(8000, function()
                                    if Osi.IsDead(AlphaM) == 0 and
                                    Osi.IsInCombat(AlphaM) == 0 and
                                    Osi.IsTagged(AlphaM, "e45d5440-4a29-42e1-845d-890ae8e82a63") == 0 then
                                        Osi.CharacterMoveToPosition(AlphaM, 139.3719329834, 53.9130859375, -138.57759094238, "Walk", "", 0)
                                        Ext.Timer.WaitFor(8000, function()
                                            if Osi.IsDead(AlphaM) == 0 and
                                            Osi.IsInCombat(AlphaM) == 0 and
                                            Osi.IsTagged(AlphaM, "e45d5440-4a29-42e1-845d-890ae8e82a63") == 0 then
                                                Osi.CharacterMoveToPosition(AlphaM, 151.2942199707, 54.095703125, -146.48077392578, "Walk", "", 0)
                                                Ext.Timer.WaitFor(8000, function()
                                                    if Osi.IsDead(AlphaM) == 0 and
                                                    Osi.IsInCombat(AlphaM) == 0 and
                                                    Osi.IsTagged(AlphaM, "e45d5440-4a29-42e1-845d-890ae8e82a63") == 0 then
                                                        Osi.CharacterMoveToPosition(AlphaM, 162.19300842285, 54.6708984375, -142.8729095459, "Walk", "", 0)
                                                        Ext.Timer.WaitFor(8000, function()
                                                            if Osi.IsDead(AlphaM) == 0 and
                                                            Osi.IsInCombat(AlphaM) == 0 and
                                                            Osi.IsTagged(AlphaM, "e45d5440-4a29-42e1-845d-890ae8e82a63") == 0 then
                                                                Osi.CharacterMoveToPosition(AlphaM, 149.72705078125, 59.6328125, -139.61981201172, "Walk", "", 0)
                                                                Ext.Timer.WaitFor(8000, function()
                                                                    if Osi.IsDead(AlphaM) == 0 and
                                                                    Osi.IsInCombat(AlphaM) == 0 and
                                                                    Osi.IsTagged(AlphaM, "e45d5440-4a29-42e1-845d-890ae8e82a63") == 0 then
                                                                        Osi.CharacterMoveToPosition(AlphaM, 162.19300842285, 54.6708984375, -142.8729095459, "Walk", "", 0)
                                                                        Ext.Timer.WaitFor(8000, function()
                                                                            if Osi.IsDead(AlphaM) == 0 and
                                                                            Osi.IsInCombat(AlphaM) == 0 and
                                                                            Osi.IsTagged(AlphaM, "e45d5440-4a29-42e1-845d-890ae8e82a63") == 0 then
                                                                                Osi.CharacterMoveToPosition(AlphaM, 158.76704406738, 53.5673828125, -157.32588195801, "Walk", "", 0)
                                                                                Ext.Timer.WaitFor(8000, function()
                                                                                    if Osi.IsDead(AlphaM) == 0 and
                                                                                    Osi.IsInCombat(AlphaM) == 0 and
                                                                                    Osi.IsTagged(AlphaM, "e45d5440-4a29-42e1-845d-890ae8e82a63") == 0 then
                                                                                        Osi.CharacterMoveToPosition(AlphaM, 163.97476196289, 49.5947265625, -179.0030670166, "Walk", "", 0)
                                                                                        Ext.Timer.WaitFor(8000, function()
                                                                                            PatrollingMinotaur()
                                                                                        end)
                                                                                    end
                                                                                end)
                                                                            end
                                                                        end)
                                                                    end
                                                                end)
                                                            end
                                                        end)
                                                    end
                                                end)
                                            end
                                        end)
                                    end
                                end)
                            end
                        end)
                    end
                end)
            end
        end)
    end
end

--Patrolling Zhent Dog
local function PatrollingZhentDog()
    if ((Osi.IsDead(ZhentDog) == 0) and Osi.IsInCombat(ZhentDog) == 0) then
        Osi.CharacterMoveToPosition(ZhentDog, 152.68583679199, 61.4921875, -95.309364318848, "Walk", "", 0)
        Ext.Timer.WaitFor(12000, function()
            Osi.CharacterMoveToPosition(ZhentDog, 152.83081054688, 60.166015625, -76.960983276367, "Walk", "", 0)
            Ext.Timer.WaitFor(10000, PatrollingZhentDog)
        end)
    end
end

--Patrolling Duergar
local function PatrollingDuergar()
    if ((Osi.IsDead(DockDuergar) == 0) and Osi.IsInCombat(DockDuergar) == 0) then
        Osi.CharacterMoveToPosition(DockDuergar, -8.5683917999268, -0.0341796875, -242.24417114258, "Walk", "", 0)
        Ext.Timer.WaitFor(7000, function()
            Osi.CharacterMoveToPosition(DockDuergar, -7.3731317520142, 0.0478515625, -240.70755004883, "Walk", "", 0)
            Ext.Timer.WaitFor(2000, function()
                Osi.CharacterMoveToPosition(DockDuergar, -14.048858642578, 0.609375, -233.88357543945, "Walk", "", 0)
                Ext.Timer.WaitFor(5000, function()
                    Osi.CharacterMoveToPosition(DockDuergar, -18.138095855713, 0.5986328125, -237.73483276367, "Walk", "", 0)
                    Ext.Timer.WaitFor(10000, function()
                        Osi.CharacterMoveToPosition(DockDuergar, -14.048858642578, 0.609375, -233.88357543945, "Walk", "", 0)
                        Ext.Timer.WaitFor(5000, function()
                            Osi.CharacterMoveToPosition(DockDuergar, -7.3731317520142, 0.0478515625, -240.70755004883, "Walk", "", 0)
                            Ext.Timer.WaitFor(5000, function()
                                PatrollingDuergar()
                            end)
                        end)
                    end)
                end)
            end)
        end)
    end
end

--Defiled Spider moving randomly
local function SpiderWalkAround()
    if ((Osi.IsDead(DSpider0) == 0) and Osi.IsInCombat(DSpider0) == 0) then
        local SpiderRandomNumber = Ext.Utils.Random(1, 7)
        if SpiderRandomNumber == 1 then
            Osi.CharacterMoveToPosition(DSpider0, 438.22686767578, 25.8388671875, 57.966297149658, "Walk", "", 0)
        elseif SpiderRandomNumber == 2 then
            Osi.CharacterMoveToPosition(DSpider0, 442.64138793945, 26.888671875, 56.68480682373, "Walk", "", 0)
        elseif SpiderRandomNumber == 3 then
            Osi.CharacterMoveToPosition(DSpider0, 444.71240234375, 26.8505859375, 51.396965026855, "Walk", "", 0)
        elseif SpiderRandomNumber == 4 then
            Osi.CharacterMoveToPosition(DSpider0, 436.45941162109, 26.681640625, 48.620922088623, "Walk", "", 0)
        elseif SpiderRandomNumber == 5 then
            Osi.CharacterMoveToPosition(DSpider0, 433.31500244141, 25.83984375, 51.7145652771, "Walk", "", 0)
        elseif SpiderRandomNumber == 6 then
            Osi.CharacterMoveToPosition(DSpider0, 428.85806274414, 27.0302734375, 52.572315216064, "Walk", "", 0)
        elseif SpiderRandomNumber == 7 then
            Osi.CharacterMoveToPosition(DSpider0, 430.55804443359, 26.470703125, 57.241092681885, "Walk", "", 0)
        end
        local SpiderWaitTImer = Ext.Utils.Random(1, 6)
        if SpiderWaitTImer == 1 then
            Ext.Timer.WaitFor(1000, function()
                SpiderWalkAround()
            end)
        elseif SpiderWaitTImer == 2 then
            Ext.Timer.WaitFor(2000, function()
                SpiderWalkAround()
            end)
        elseif SpiderWaitTImer == 3 then
            Ext.Timer.WaitFor(3000, function()
                SpiderWalkAround()
            end)
        elseif SpiderWaitTImer == 4 then
            Ext.Timer.WaitFor(4000, function()
                SpiderWalkAround()
            end)
        elseif SpiderWaitTImer == 5 then
            Ext.Timer.WaitFor(5000, function()
                SpiderWalkAround()
            end)
        elseif SpiderWaitTImer == 6 then
            Ext.Timer.WaitFor(6000, function()
                SpiderWalkAround()
            end)
        end
    end
end

--Summon the spider horde wave 1
local function SpiderHorde()
    if (Osi.IsDead(DSpider11) == 0) then
        Osi.AppearAtPosition(DSpider11, 436.22869873047, 26.849609375, 45.836368560791, 1, "SPIDER_Rig_DFLT_UTIL_Spawn_01_93c4751e-baab-8074-9c84-22e0662fd79c", "", 0)
        Osi.SetOnStage(DSpider11, 1)
        Osi.CharacterMoveToPosition(DSpider11, 436.36901855469, 25.83984375, 51.633331298828, "Run", "", 0)
    end
    if (Osi.IsDead(DSpider12) == 0) then
        Osi.AppearAtPosition(DSpider12, 436.22869873047, 26.849609375, 45.836368560791, 1, "SPIDER_Rig_DFLT_UTIL_Spawn_01_93c4751e-baab-8074-9c84-22e0662fd79c", "", 0)
        Osi.SetOnStage(DSpider12, 1)
        Osi.CharacterMoveToPosition(DSpider12, 436.36901855469, 25.83984375, 51.633331298828, "Run", "", 0)
    end
    if (Osi.IsDead(DSpider13) == 0) then
        Osi.AppearAtPosition(DSpider13, 436.22869873047, 26.849609375, 45.836368560791, 1, "SPIDER_Rig_DFLT_UTIL_Spawn_01_93c4751e-baab-8074-9c84-22e0662fd79c", "", 0)
        Osi.SetOnStage(DSpider13, 1)
       Osi.CharacterMoveToPosition(DSpider13, 436.36901855469, 25.83984375, 51.633331298828, "Run", "", 0)
    end
    if (Osi.IsDead(DSpider14) == 0) then
        Osi.AppearAtPosition(DSpider14, 436.22869873047, 26.849609375, 45.836368560791, 1, "SPIDER_Rig_DFLT_UTIL_Spawn_01_93c4751e-baab-8074-9c84-22e0662fd79c", "", 0)
        Osi.SetOnStage(DSpider14, 1)
        Osi.CharacterMoveToPosition(DSpider14, 436.36901855469, 25.83984375, 51.633331298828, "Run", "", 0)
    end
    if (Osi.IsDead(DSpider15) == 0) then
        Osi.AppearAtPosition(DSpider15, 425.29034423828, 26.849609375, 54.974563598633, 1, "SPIDER_Rig_DFLT_UTIL_Spawn_01_93c4751e-baab-8074-9c84-22e0662fd79c", "", 0)
        Osi.SetOnStage(DSpider15, 1)
        Osi.CharacterMoveToPosition(DSpider15, 430.04388427734, 26.875, 54.684524536133, "Run", "", 0)
    end
    if (Osi.IsDead(DSpider16) == 0) then
        Osi.AppearAtPosition(DSpider16, 425.29034423828, 26.849609375, 54.974563598633, 1, "SPIDER_Rig_DFLT_UTIL_Spawn_01_93c4751e-baab-8074-9c84-22e0662fd79c", "", 0)
        Osi.SetOnStage(DSpider16, 1)
        Osi.CharacterMoveToPosition(DSpider16, 430.04388427734, 26.875, 54.684524536133, "Run", "", 0)
    end
    if (Osi.IsDead(DSpider17) == 0) then
        Osi.AppearAtPosition(DSpider17, 425.29034423828, 26.849609375, 54.974563598633, 1, "SPIDER_Rig_DFLT_UTIL_Spawn_01_93c4751e-baab-8074-9c84-22e0662fd79c", "", 0)
        Osi.SetOnStage(DSpider17, 1)
        Osi.CharacterMoveToPosition(DSpider17, 430.04388427734, 26.875, 54.684524536133, "Run", "", 0)
    end
    if (Osi.IsDead(DSpider18) == 0) then
        Osi.AppearAtPosition(DSpider18, 425.29034423828, 26.849609375, 54.974563598633, 1, "SPIDER_Rig_DFLT_UTIL_Spawn_01_93c4751e-baab-8074-9c84-22e0662fd79c", "", 0)
        Osi.SetOnStage(DSpider18, 1)
        Osi.CharacterMoveToPosition(DSpider18, 430.04388427734, 26.875, 54.684524536133, "Run", "", 0)
    end
    if (Osi.IsDead(DSpider19) == 0) then
        Osi.AppearAtPosition(DSpider19, 446.75, 26.849609375, 55.75, 1, "SPIDER_Rig_DFLT_UTIL_Spawn_01_93c4751e-baab-8074-9c84-22e0662fd79c", "", 0)
        Osi.SetOnStage(DSpider19, 1)
        Osi.CharacterMoveToPosition(DSpider19, 442.81484985352, 26.888671875, 55.478549957275, "Run", "", 0)
    end
    if (Osi.IsDead(DSpider110) == 0) then
        Osi.AppearAtPosition(DSpider110, 446.75, 26.849609375, 55.75, 1, "SPIDER_Rig_DFLT_UTIL_Spawn_01_93c4751e-baab-8074-9c84-22e0662fd79c", "", 0)
        Osi.SetOnStage(DSpider110, 1)
        Osi.CharacterMoveToPosition(DSpider110, 442.81484985352, 26.888671875, 55.478549957275, "Run", "", 0)
    end
    if (Osi.IsDead(DSpider111) == 0) then
        Osi.AppearAtPosition(DSpider111, 446.75, 26.849609375, 55.75, 1, "SPIDER_Rig_DFLT_UTIL_Spawn_01_93c4751e-baab-8074-9c84-22e0662fd79c", "", 0)
        Osi.SetOnStage(DSpider111, 1)
        Osi.CharacterMoveToPosition(DSpider111, 442.81484985352, 26.888671875, 55.478549957275, "Run", "", 0)
    end
    if (Osi.IsDead(DSpider112) == 0) then
        Osi.AppearAtPosition(DSpider112, 446.75, 26.849609375, 55.75, 1, "SPIDER_Rig_DFLT_UTIL_Spawn_01_93c4751e-baab-8074-9c84-22e0662fd79c", "", 0)
        Osi.SetOnStage(DSpider112, 1)
        Osi.CharacterMoveToPosition(DSpider112, 442.81484985352, 26.888671875, 55.478549957275, "Run", "", 0)
    end
end

--Spider horde wave 2
local function SpiderHorde2()
    if (Osi.IsDead(DSpider21) == 0) then
        Osi.AppearAtPosition(DSpider21, 436.22869873047, 26.849609375, 45.836368560791, 1, "SPIDER_Rig_DFLT_UTIL_Spawn_01_93c4751e-baab-8074-9c84-22e0662fd79c", "", 0)
        Osi.SetOnStage(DSpider21, 1)
        Osi.CharacterMoveToPosition(DSpider21, 436.36901855469, 25.83984375, 51.633331298828, "Run", "", 0)
    end
    if (Osi.IsDead(DSpider22) == 0) then
        Osi.AppearAtPosition(DSpider22, 436.22869873047, 26.849609375, 45.836368560791, 1, "SPIDER_Rig_DFLT_UTIL_Spawn_01_93c4751e-baab-8074-9c84-22e0662fd79c", "", 0)
        Osi.SetOnStage(DSpider22, 1)
        Osi.CharacterMoveToPosition(DSpider22, 436.36901855469, 25.83984375, 51.633331298828, "Run", "", 0)
    end
    if (Osi.IsDead(DSpider23) == 0) then
        Osi.AppearAtPosition(DSpider23, 436.22869873047, 26.849609375, 45.836368560791, 1, "SPIDER_Rig_DFLT_UTIL_Spawn_01_93c4751e-baab-8074-9c84-22e0662fd79c", "", 0)
        Osi.SetOnStage(DSpider23, 1)
        Osi.CharacterMoveToPosition(DSpider23, 436.36901855469, 25.83984375, 51.633331298828, "Run", "", 0)
    end
    if (Osi.IsDead(DSpider24) == 0) then
        Osi.AppearAtPosition(DSpider24, 436.22869873047, 26.849609375, 45.836368560791, 1, "SPIDER_Rig_DFLT_UTIL_Spawn_01_93c4751e-baab-8074-9c84-22e0662fd79c", "", 0)
        Osi.SetOnStage(DSpider24, 1)
        Osi.CharacterMoveToPosition(DSpider24, 436.36901855469, 25.83984375, 51.633331298828, "Run", "", 0)
    end
    if (Osi.IsDead(DSpider25) == 0) then
        Osi.AppearAtPosition(DSpider25, 425.29034423828, 26.849609375, 54.974563598633, 1, "SPIDER_Rig_DFLT_UTIL_Spawn_01_93c4751e-baab-8074-9c84-22e0662fd79c", "", 0)
        Osi.SetOnStage(DSpider25, 1)
        Osi.CharacterMoveToPosition(DSpider25, 430.04388427734, 26.875, 54.684524536133, "Run", "", 0)
    end
    if (Osi.IsDead(DSpider26) == 0) then
        Osi.AppearAtPosition(DSpider26, 425.29034423828, 26.849609375, 54.974563598633, 1, "SPIDER_Rig_DFLT_UTIL_Spawn_01_93c4751e-baab-8074-9c84-22e0662fd79c", "", 0)
        Osi.SetOnStage(DSpider26, 1)
        Osi.CharacterMoveToPosition(DSpider26, 430.04388427734, 26.875, 54.684524536133, "Run", "", 0)
    end
    if (Osi.IsDead(DSpider27) == 0) then
        Osi.AppearAtPosition(DSpider27, 425.29034423828, 26.849609375, 54.974563598633, 1, "SPIDER_Rig_DFLT_UTIL_Spawn_01_93c4751e-baab-8074-9c84-22e0662fd79c", "", 0)
        Osi.SetOnStage(DSpider27, 1)
        Osi.CharacterMoveToPosition(DSpider27, 430.04388427734, 26.875, 54.684524536133, "Run", "", 0)
    end
    if (Osi.IsDead(DSpider28) == 0) then
        Osi.AppearAtPosition(DSpider28, 425.29034423828, 26.849609375, 54.974563598633, 1, "SPIDER_Rig_DFLT_UTIL_Spawn_01_93c4751e-baab-8074-9c84-22e0662fd79c", "", 0)
        Osi.SetOnStage(DSpider28, 1)
        Osi.CharacterMoveToPosition(DSpider28, 430.04388427734, 26.875, 54.684524536133, "Run", "", 0)
    end
    if (Osi.IsDead(DSpider29) == 0) then
        Osi.AppearAtPosition(DSpider29, 446.75, 26.849609375, 55.75, 1, "SPIDER_Rig_DFLT_UTIL_Spawn_01_93c4751e-baab-8074-9c84-22e0662fd79c", "", 0)
        Osi.SetOnStage(DSpider29, 1)
        Osi.CharacterMoveToPosition(DSpider29, 442.81484985352, 26.888671875, 55.478549957275, "Run", "", 0)
    end
    if (Osi.IsDead(DSpider210) == 0) then
        Osi.AppearAtPosition(DSpider210, 446.75, 26.849609375, 55.75, 1, "SPIDER_Rig_DFLT_UTIL_Spawn_01_93c4751e-baab-8074-9c84-22e0662fd79c", "", 0)
        Osi.SetOnStage(DSpider210, 1)
        Osi.CharacterMoveToPosition(DSpider210, 442.81484985352, 26.888671875, 55.478549957275, "Run", "", 0)
    end
    if (Osi.IsDead(DSpider211) == 0) then
        Osi.AppearAtPosition(DSpider211, 446.75, 26.849609375, 55.75, 1, "SPIDER_Rig_DFLT_UTIL_Spawn_01_93c4751e-baab-8074-9c84-22e0662fd79c", "", 0)
        Osi.SetOnStage(DSpider211, 1)
        Osi.CharacterMoveToPosition(DSpider211, 442.81484985352, 26.888671875, 55.478549957275, "Run", "", 0)
    end
    if (Osi.IsDead(DSpider212) == 0) then
        Osi.AppearAtPosition(DSpider212, 446.75, 26.849609375, 55.75, 1, "SPIDER_Rig_DFLT_UTIL_Spawn_01_93c4751e-baab-8074-9c84-22e0662fd79c", "", 0)
        Osi.SetOnStage(DSpider212, 1)
        Osi.CharacterMoveToPosition(DSpider212, 442.81484985352, 26.888671875, 55.478549957275, "Run", "", 0)
    end
end

--Za'krug call reinforcements
local function ZakrugReinforcements()
    -- stubbed out effects, this is called repeatedly :/
end

--Spawn Oof
local function SpawnOof()
    if (Osi.IsDead(Oof) == 0) then
        Osi.SetOnStage(Oof, 1)
        -- Osi.AppearOutOfSightTo(Oof, Wyll, BridgeTroll, 0, "", "OOFAPPEARED", 0)
        -- Osi.TeleportToPosition(Oof, 173.67250061035, 21.856609344482, 414.58654785156, OofTeleport, 0, 0, 0, 1, 1)
        SetFaction(Oof, FGoblinRaiders)
        Ext.Timer.WaitFor(1000, function()
            Osi.CharacterMoveToPosition(Oof, 200.31283569336, 24.947265625, 421.1086730957, "Run", "", 0)
            Ext.Timer.WaitFor(2000, function()
                Osi.SetHostileAndEnterCombat(FGoblinRaiders, FZevlor, Oof, Zevlor)
            end)
        end)
    end
end

--Oof clumsy roller
local function ClumsyOof()
    local OofClumsySelector = Ext.Utils.Random(1,6)
    if OofClumsySelector == 1 then
            Osi.ApplyStatus(Oof, "MMM_OOFDISARMED", 12, 1, Oof)
    elseif OofClumsySelector == 2 then
        Osi.ApplyStatus(Oof, "MMM_OOFSPLINTER", 12, 1, Oof)
    elseif OofClumsySelector == 3 then
        Osi.ApplyStatus(Oof, "MMM_OOFDRUNK", 12, 1, Oof)
    elseif OofClumsySelector == 4 then
        Osi.ApplyStatus(Oof, "MMM_OOFBUMBLE", 12, 1, Oof)
        Osi.UseSpell(Oof, "Projectile_AlchemistFire", Oof)
    elseif OofClumsySelector == 5 then
        Osi.ApplyStatus(Oof, "MMM_OOFHAMSTRING", 12, 1, Oof)
    elseif OofClumsySelector == 6 then
        Osi.ApplyStatus(Oof, "MMM_OOFSLIPPED", 12, 1, Oof)
    end
end

--Oof randomly slipping and getting up
local function TrippyOof()
    if (Osi.IsDead(Oof) == 0) then
        local OofSlipRoll = Ext.Utils.Random(1, 6)
        if OofSlipRoll == 1 then
            Osi.ApplyStatus(Oof, "PRONE_GREASE", 1, 1, Oof)
            Ext.Timer.WaitFor(2000, function()
            Osi.RemoveStatus(Oof, "PRONE_GREASE", "")
            end)
        end
        Ext.Timer.WaitFor(8000, function()
        TrippyOof()
        end)
    elseif (Osi.IsDead(Oof) == 1) then
        print("RIP Oof - Slipped and fell too many times")
        return
    end
end

--Ex walks over to fight, ex and bf hate each other
local function ItsComplicated()
    if ((Osi.IsDead(Buthir) == 0) and (Osi.IsOnStage(Bogsnap) == 0)) then
            Osi.SetOnStage(Bogsnap, 1)
            Osi.AppearOutOfSightToPosition(Bogsnap, 32.818363189697, 33.46484375, 468.50390625, "West", 0, "", "", 0)
            Ext.Timer.WaitFor(1000, function()
                Osi.CharacterMoveToPosition(Bogsnap, 32.818363189697, 33.46484375, 468.50390625, "Run", "", 0)
                Osi.SetHostileAndEnterCombat(FEvil, FSexCouple, Bogsnap, Grukkoh)
            end)
    end
end

--Run chicken event
local function ChickenEvent()
    Osi.SetOnStage(Chickenrunner, 1)
    Osi.SetOnStage(Chicken1, 1)
    Osi.SetOnStage(Chicken2, 1)
    Osi.SetOnStage(Chicken3, 1)
    Osi.SetOnStage(Chicken4, 1)
    Osi.SetOnStage(Chicken5, 1)
    Ext.Timer.WaitFor(1000, function()
        Osi.CharacterMoveToPosition(Chickenrunner, -159.52056884766, 24.0712890625, 331.99102783203, "Sprint", "", 0)
        Osi.CharacterMoveToPosition(Chicken1, -159.52056884766, 24.0712890625, 331.99102783203, "Sprint", "", 0)
        Osi.CharacterMoveToPosition(Chicken2, -159.52056884766, 24.0712890625, 331.99102783203, "Sprint", "", 0)
        Osi.CharacterMoveToPosition(Chicken3, -159.52056884766, 24.0712890625, 331.99102783203, "Sprint", "", 0)
        Osi.CharacterMoveToPosition(Chicken4, -159.52056884766, 24.0712890625, 331.99102783203, "Sprint", "", 0)
        Osi.CharacterMoveToPosition(Chicken5, -159.52056884766, 24.0712890625, 331.99102783203, "Sprint", "", 0)
            Ext.Timer.WaitFor(6000, function()
            Osi.CharacterMoveToPosition(Chickenguard, -159.52056884766, 24.0712890625, 331.99102783203, "Sprint", "", 0)
                Ext.Timer.WaitFor(20000, function()
                Osi.SetOnStage(Chickenrunner, 0)
                Osi.SetOnStage(Chicken1, 0)
                Osi.SetOnStage(Chicken2, 0)
                Osi.SetOnStage(Chicken3, 0)
                Osi.SetOnStage(Chicken4, 0)
                Osi.SetOnStage(Chicken5, 0)
                Osi.SetOnStage(Chickenguard, 0)
                Osi.ApplyDamage(Chickenrunner, 200, "Piercing", "")
                Osi.ApplyDamage(Chicken1, 200, "Piercing", "")
                Osi.ApplyDamage(Chicken2, 200, "Piercing", "")
                Osi.ApplyDamage(Chicken3, 200, "Piercing", "")
                Osi.ApplyDamage(Chicken4, 200, "Piercing", "")
                Osi.ApplyDamage(Chicken5, 200, "Piercing", "")
                Osi.ApplyDamage(Chickenguard, 200, "Piercing", "")
                end)
            end)
    end)
end

--Kill chicken event
local function ChickenKiller()
    Osi.SetOnStage(Chickenguard, 0)
    Osi.ApplyDamage(Chickenrunner, 200, "Piercing", "")
    Osi.ApplyDamage(Chicken1, 200, "Piercing", "")
    Osi.ApplyDamage(Chicken2, 200, "Piercing", "")
    Osi.ApplyDamage(Chicken3, 200, "Piercing", "")
    Osi.ApplyDamage(Chicken4, 200, "Piercing", "")
    Osi.ApplyDamage(Chicken5, 200, "Piercing", "")
    Osi.ApplyDamage(Chickenguard, 200, "Piercing", "")
end

--DUERGAR Army 1
local function DUERGARARMYMARCH1()
    Osi.CharacterMoveToPosition(DArmyRanger, 110.90492248535, 35.689453125, -139.38722229004, "Walk", "", 0)
    Osi.CharacterMoveToPosition(DArmyCleric1, 112.53665924072, 35.4873046875, -142.98348999023, "Walk", "", 0)
    Osi.CharacterMoveToPosition(DArmyNecro, 114.25225067139, 35.4716796875, -146.46734619141, "Walk", "", 0)
    Osi.CharacterMoveToPosition(DArmyFighter, 115.45721435547, 35.5302734375, -142.65972900391, "Walk", "", 0)
    Osi.CharacterMoveToPosition(DArmyCleric2, 110.30414581299, 35.236328125, -143.58641052246, "Walk", "", 0)
    Osi.SetOnStage(DuergarTrigger1, 0)
    Osi.SetOnStage(DuergarTrigger2, 0)
end

--DUERGAR Army 2
local function DUERGARARMYMARCH2()
    Osi.CharacterMoveToPosition(DArmyRanger, 34.75, 23.7255859375, -159.75, "Walk", "", 0)
    Osi.CharacterMoveToPosition(DArmyCleric1, 31.695579528809, 23.3232421875, -160.90824890137, "Walk", "", 0)
    Osi.CharacterMoveToPosition(DArmyNecro, 28.343914031982, 22.9306640625, -162.59091186523, "Walk", "", 0)
    Osi.CharacterMoveToPosition(DArmyFighter, 31.629081726074, 24.56640625, -156.77754211426, "Walk", "", 0)
    Osi.CharacterMoveToPosition(DArmyCleric2, 29.215038299561, 24.3291015625, -157.20526123047, "Walk", "", 0)
    Osi.SetOnStage(DuergarTrigger1, 0)
    Osi.SetOnStage(DuergarTrigger2, 0)
end

--Cave In Spawner
local function CaveIn()
    Osi.SetOnStage(WeakBeholder, 1)
    BeholderHP = Osi.GetMaxHitpoints(WeakBeholder)
    Osi.SetHitpoints(WeakBeholder, BeholderHP/2)
end

--Lolth Event
local function LolthEvent()
    ShowNotification(GetHostCharacter(), "You dare to call upon Lolth?")
    Ext.Timer.WaitFor(3000, function()
        Osi.UseSpellAtPosition(LolthTrigger, "Projectile_Fireball", -16.75, 25.0751953125, -69.25)
        Osi.SetOnStage(LolthTrigger, 0)
        Ext.Timer.WaitFor(15000, function()
            Osi.SetOnStage(LolthRanger, 1)
            Osi.SetOnStage(LolthCleric, 1)
            Osi.SetOnStage(LolthDrider, 1)
            Osi.CharacterMoveToPosition(LolthRanger, -12.285536766052, 24.599872589111, -61.853672027588, "Walk", "", 0)
            Osi.CharacterMoveToPosition(LolthCleric, -25.776893615723, 24.399875640869, -63.783191680908, "Walk", "", 0)
            Osi.CharacterMoveToPosition(LolthDrider, -20.135322570801, 24.219875335693, -61.406074523926, "Walk", "", 0)
        end)
    end)
end

--Throw shoe full of Bailey's to bait player
local function ThrowShoe()
    BaileyShoe = Osi.CreateAt("c4fe6d69-b19a-40e6-b01f-f2e7e3fdec9d", -436.75, 28.685546875, -523.25, 0, 1, "")
    Ext.Timer.WaitFor(100, function()
        Osi.ItemDragToPosition(BaileyShoe, -443.29486083984, 27.8359375, -523.27209472656)
        Osi.PlayEffectAtPosition("5fb9e2fa-2b54-26ac-8d10-d9dfa9ef9da0", -443.29486083984, 27.8359375, -523.27209472656, 2)
        Osi.PlaySound("5fb9e2fa-2b54-26ac-8d10-d9dfa9ef9da0", "Spell_Impact_Utility_Jump_L1to3")
    end)
end

--Hatch all the baby bulettes
local function BULETTEHATCH()
    Osi.SetOnStage(BuletteTrigger, 0)
    if (Osi.IsDead(Bulette1) == 0) then --Baby Bulette 1
        Ext.Timer.WaitFor(1900, function()
            Osi.SetOnStage(Bulette1, 1)
            Osi.ApplyDamage("c1525d16-e04a-4020-aacf-1793ce7bad0a", 30, "Bludgeoning", "")
            Osi.SetHostileAndEnterCombat(FEvil, FBulette, Bulette1, MamaBulette)
        end)
    end
    if (Osi.IsDead(Bulette2) == 0) then --Baby Bulette 2
        Ext.Timer.WaitFor(1200, function()
            Osi.SetOnStage(Bulette2, 1)
            Osi.ApplyDamage("98ba567a-55a1-41b0-862f-91cba7ef5f12", 30, "Bludgeoning", "")
            Osi.SetHostileAndEnterCombat(FEvil, FBulette, Bulette2, MamaBulette)
        end)
    end
    if (Osi.IsDead(Bulette3) == 0) then --Baby Bulette 3
        Ext.Timer.WaitFor(2800, function()
            Osi.SetOnStage(Bulette3, 1)
            Osi.ApplyDamage("b9733724-bf9c-4a64-9df1-750fb0bde98e", 30, "Bludgeoning", "")
            Osi.SetHostileAndEnterCombat(FEvil, FBulette, Bulette3, MamaBulette)
        end)
    end
    if (Osi.IsDead(Bulette4) == 0) then --Baby Bulette 4
        Ext.Timer.WaitFor(1800, function()
            Osi.SetOnStage(Bulette4, 1)
            Osi.ApplyDamage("7e217bec-2586-4b75-85b9-aefc89cf92d1", 30, "Bludgeoning", "")
            Osi.SetHostileAndEnterCombat(FEvil, FBulette, Bulette4, MamaBulette)
        end)
    end
    if (Osi.IsDead(Bulette5) == 0) then --Baby Bulette 5
        Ext.Timer.WaitFor(1800, function()
            Osi.SetOnStage(Bulette5, 1)
            Osi.ApplyDamage("b772eeae-bb23-4566-8066-d7f5620b8939", 30, "Bludgeoning", "")
            Osi.SetHostileAndEnterCombat(FEvil, FBulette, Bulette5, MamaBulette)
        end)
    end
    if (Osi.IsDead(Bulette6) == 0) then --Baby Bulette 6
        Ext.Timer.WaitFor(1500, function()
            Osi.SetOnStage(Bulette6, 1)
            Osi.ApplyDamage("7fc7e579-c8df-450f-906b-5eaffb75219d", 30, "Bludgeoning", "")
            Osi.SetHostileAndEnterCombat(FEvil, FBulette, Bulette6, MamaBulette)
        end)
    end
    if (Osi.IsDead(Bulette7) == 0) then --Baby Bulette 7
        Ext.Timer.WaitFor(2400, function()
            Osi.SetOnStage(Bulette7, 1)
            Osi.ApplyDamage("7c7269ca-a9fd-4651-9881-4a521b864a2f", 30, "Bludgeoning", "")
            Osi.SetHostileAndEnterCombat(FEvil, FBulette, Bulette7, MamaBulette)
        end)
    end
    if (Osi.IsDead(Bulette8) == 0) then --Baby Bulette 8
        Ext.Timer.WaitFor(600, function()
            Osi.SetOnStage(Bulette8, 1)
            Osi.ApplyDamage("7e46dfca-3438-4394-9b28-bc0ca7c0d4af", 30, "Bludgeoning", "")
            Osi.SetHostileAndEnterCombat(FEvil, FBulette, Bulette8, MamaBulette)
        end)
    end
    if (Osi.IsDead(Bulette9) == 0) then --Baby Bulette 9
        Ext.Timer.WaitFor(2700, function()
            Osi.SetOnStage(Bulette9, 1)
            Osi.ApplyDamage("000afafe-7263-43c1-be0c-87e9648305fa", 30, "Bludgeoning", "")
            Osi.SetHostileAndEnterCombat(FEvil, FBulette, Bulette9, MamaBulette)
        end)
    end
end

--Merge the mimics
local function MimicBossFight()
    Ext.Timer.WaitFor(3000, function()
        Osi.SetOnStage(HarperMimic1, 0)
        Osi.SetOnStage(HarperMimic2, 0)
        Osi.SetOnStage(HarperMimic3, 0)
        Ext.Timer.WaitFor(100, function()
            Osi.PlayEffectAtPosition("350a65d5-3bc6-9656-87f9-cec27d891882", -687.18841552734, -6.3623046875, 376.60565185547, 7)
            Osi.SetOnStage(MegaMimic, 1)
        end)
    end)
end

--Zevlor summoning more units
local function GroveGuardians()
    return
end

--Grym Failsafe
local function GrymFailsafe()
    if Osi.IsDead(Grym2) == 1 then
        Osi.SetOnStage(ForgeGhost1, 0)
        Osi.SetOnStage(ForgeGhost2, 0)
        Osi.Die(ForgeGhost1, 0, GetHostCharacter(), 0, 1, 500)
        Osi.Die(ForgeGhost2, 0, GetHostCharacter(), 0, 1, 500)
    end
end

--Mike Talking
-- local function MikeTalking()
--     if not Osi.IsCharacter(Mike1) then
--         return
--     end

--     if Osi.IsInCombat(Mike1) == 0 then
--         Osi.ApplyStatus(Mike1, "MMM_MIKECOMBAT", 6, 1, "")
--         Ext.Timer.WaitFor(10000, function()
--             -- Only repeat if still valid and not in combat
--             if Osi.IsInCombat(Mike1) == 0 then
--                 MikeTalking()
--             end
--         end)
--     end
-- end


--Counters
Ext.Events.SessionLoaded:Subscribe(function()
    BoatkillCounter = 0
    WentPastGregg = 0
    SpiderKillCounter = 0
    DuergarMarch = 0
    MimicBoss = 0
    ZakrugReinforcementTrigger = 0
end)

--Prepared Boost
Ext.Events.SessionLoaded:Subscribe(function()
    PrepareDuration = 0
end)

local function PreparedBoost()
    for i,v in ipairs(Ext.Entity.GetAllEntitiesWithComponent("ServerCharacter")) do
        local charIDprepared = v.Uuid.EntityUuid
        if Osi.IsTagged(charIDprepared, "25bf5042-5bf6-4360-8df8-ab107ccb0d37") == 1 then
            Osi.ApplyStatus(charIDprepared, "MMM_PREPARED", PrepareDuration, 1, charIDprepared)
        end
    end
end

---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
-------------------------------------------LISTENERS-----------------------------------------------------
---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------

--What to run on loading level
Ext.Osiris.RegisterListener("LevelGameplayStarted", 2, "after", function(level_name, is_editor_mode)
    if (level_name ~= "WLD_Main_A") then
        return
    end
    if Osi.GetFlag(Act1MimicFlag, Null) == 0 then
        Osi.SetFlag(Act1MimicFlag, Null, 0, 1)
        CreateAct1Mimics()
    end
    if Osi.GetFlag(InitiateAct1, Null) == 0 then
        Osi.SetFlag(InitiateAct1, Null, 0, 1)
        InitiateMonsters()
        RemoveItems()
    end
    ModifyMonsters()
    ID1WalkAround()
    ID2WalkAround()
    SpiderWalkAround()
    UrinatingGoblin()
    PatrollingMinotaur()
    PatrollingZhentDog()
    PatrollingDuergar()
    GrymFailsafe()
    -- MikeTalking()
end)

--Enter Combat Listener
Ext.Osiris.RegisterListener("EnteredCombat", 2, "after", function (object, combat)
    --Goblin Ambush Flag
    if object == AmbushGob1 then
        Osi.SetFlag(GoblinCrashFlag, Null, 0, 1)
    end
    --Drow Ambush Flags
    if object == DrowAssassin1 then
        Osi.SetFlag(DrowAmbush1Flag, Null, 0, 1)
    end
    if object == DrowAssassin2 then
        Osi.SetFlag(DrowAmbush2Flag, Null, 0, 1)
    end
    if object == DrowAssassin3 then
        Osi.SetFlag(DrowAmbush3Flag, Null, 0, 1)
    end
    --Duergar Ambush Flags
    if object == DArmyNecro then
        Osi.SetFlag(DuergarMarchFlag, Null, 0, 1)
    end
    --If using front of cave turn off backdoor
    if object == Flind then
        Osi.SetOnStage(BackdoorGnoll1, 0)
        Osi.SetOnStage(BackdoorGnoll2, 0)
        Osi.SetOnStage(BackdoorGnoll3, 0)
    end
    --Change dragon faction if combat
    if (object == "S_GLO_GithCaptain_27fa0802-fa38-4eea-9c03-496f2e022259") then
        Osi.SetFaction(JuvDragon, FHGith)
        Osi.SetHostileAndEnterCombat(FHGith, FPlayer, JuvDragon, GetHostCharacter())
    end
    --Za'krug sounding horn
    if (object == "S_DEN_GoblinRaider_Captain_22d80f21-7f31-4240-b981-9137d53ad77d") then
        Ext.Osiris.RegisterListener("CombatRoundStarted", 2, "after", function(combatGuid, round)
            if (round == 2) then
                ZakrugReinforcements()
                Osi.SetFlag(OofFlag, Null, 0, 1)
            end
        end)
    end
    --Oof Spawns round 3
    if object == "S_DEN_GoblinRaider_Captain_22d80f21-7f31-4240-b981-9137d53ad77d" then
        Ext.Osiris.RegisterListener("CombatRoundStarted", 2, "after", function(combatGuid, round)
            if (round == 3) and Osi.GetFlag(OofFlag, Null) == 1 then
                SpawnOof()
                TrippyOof()
            end
        end)
    end
    --Set immunity for bugbear champ fight if no player
    if object == "MMM_BUGBEARCHALLENGER_46545754-5089-4e85-b34d-81395e5ebb44" then
        BugBearCombatID = combat
        if Osi.CombatGetInvolvedPlayersCount(BugBearCombatID) == 0 then
            Osi.AddBoosts(BugbearChallenger, "Invulnerable", "", BugbearChallenger) --Bugbear
            Osi.AddBoosts(BugbearChallenger, "ActionResourceBlock(Movement)", "", BugbearChallenger) --Bugbear movement so he doesn't chase Remira
            Osi.AddBoosts("4faf77a0-b883-4f7b-acbf-4500973f446d", "Invulnerable", "", "4faf77a0-b883-4f7b-acbf-4500973f446d") --Remira
            Osi.AddBoosts("534bceaf-678c-40a0-8ca9-e1134f95ba0d", "Invulnerable", "", "534bceaf-678c-40a0-8ca9-e1134f95ba0d") --Barth
            Osi.AddBoosts("82d1b843-9e8c-48a5-9d87-caddea5c193c", "Invulnerable", "", "82d1b843-9e8c-48a5-9d87-caddea5c193c") --Aradin
        end
    end
    --Remove bugbear immunities when player arrives
    if ((Osi.IsPlayer(object) == 1) and (combat == BugBearCombatID)) then
        Osi.RemoveBoosts(BugbearChallenger, "Invulnerable", 0, "", BugbearChallenger) --Bugbear
        Osi.RemoveBoosts(BugbearChallenger, "ActionResourceBlock(Movement)", 0, "", BugbearChallenger) --Bugbear movement so he doesn't chase Remira
        Osi.RemoveBoosts("4faf77a0-b883-4f7b-acbf-4500973f446d", "Invulnerable", 0, "", "4faf77a0-b883-4f7b-acbf-4500973f446d") --Remira
        Osi.RemoveBoosts("534bceaf-678c-40a0-8ca9-e1134f95ba0d", "Invulnerable", 0, "", "534bceaf-678c-40a0-8ca9-e1134f95ba0d") --Barth
        Osi.RemoveBoosts("82d1b843-9e8c-48a5-9d87-caddea5c193c", "Invulnerable", 0, "", "82d1b843-9e8c-48a5-9d87-caddea5c193c") --Aradin
    end
    --Start Summon Ex Countdown
    if (object == Buthir) then
        Ext.Osiris.RegisterListener("CombatRoundStarted", 2, "after", function(combatGuid, round)
            if (round == 2) then
                ItsComplicated()
            end
        end)
    end
end)

--Turn started listener
Ext.Osiris.RegisterListener("TurnStarted", 1, "after", function(object)
    --Oof's Turn
    if object == Oof then
        ClumsyOof()
    end
    if object == Grym2 and Osi.GetHitpoints(Grym2) <= 100 and Osi.IsOnStage(ForgeMephit1) == 0 then
        Osi.SetOnStage(ForgeMephit1, 1)
        Osi.SetOnStage(ForgeMephit2, 1)
        Osi.SetOnStage(ForgeMephit3, 1)
        Osi.SetOnStage(ForgeMephit4, 1)
    end
end)

--Open item listener
Ext.Osiris.RegisterListener("Opened", 1, "before", function(item)
    --Destroy voyeur barrel when opening
    if (item == "MMM_QUESTIONABLEBARREL_2dff1009-962a-4f24-a94d-76253102237a") then
        Osi.ApplyDamage("2dff1009-962a-4f24-a94d-76253102237a", 20, "Bludgeoning", "")
    end
end)

--Use item listener
Ext.Osiris.RegisterListener("UseStarted", 2, "after", function(character, item)
    if item == GrymBossMarker then
        Osi.OpenMessageBox(character, Osi.ResolveTranslatedString("ha8f76a2eg1158g4012g9c72ged0005babae3"))
    end
    if item == RedDragonBossMarker then
        Osi.OpenMessageBox(character, Osi.ResolveTranslatedString("hc88d706ag5390g41f9gbfe6gdc17d182da71"))
    end
    if Osi.HasActiveStatus(item, "MMM_MIMIC1") == 1 then
        TurnIntoMimic1(item, character)
    end
end)

--Destroy object listener
Ext.Osiris.RegisterListener("DestroyedBy", 4, "before", function(item, character, destroyerOwner, storyActionID)
    --Put voyeur on stage
    if (item == "MMM_QUESTIONABLEBARREL_2dff1009-962a-4f24-a94d-76253102237a") then
        local x,y,z = Osi.GetPosition("2dff1009-962a-4f24-a94d-76253102237a")
        Osi.AppearAtPosition(Slegbezzle, x,y,z, 1, "", "", 0)
        Osi.SetOnStage(Slegbezzle, 1)
        Osi.SetHostileAndEnterCombat(FSexCouple, FEvil, Grukkoh, Slegbezzle)
    end
    --Rock for Beholder
    if item == "MMM_CAVEIN_c9e44fb1-98b5-4677-930f-dceee8a52200" then
        Osi.RequestPassiveRoll(character, WeakBeholder, "", "Perception", "Act1_Challenging_5e7ff0e9-6c80-459c-a636-3a3e8417a61a", 0, "CAVEINROLL")
    end
    --Mithral Vein for Elemental
    if (item == "S_UND_MithralVein_df5366a7-aa59-4104-9a1f-f744e8883f06") then
        Osi.SetOnStage(LavaElemental, 1)
        Osi.CharacterMoveToPosition(LavaElemental, -633.51263427734, 10.690246582031, 258.11077880859, "Run", "", 0)
    end
    if Osi.HasActiveStatus(item, "MMM_MIMIC1") == 1 then
        TurnIntoMimic1(item, character)
    end
    if item == RedDragonBossMarker then
        Osi.SetOnStage(JuvDragon, 1)
    end
end)

--Death listener
Ext.Osiris.RegisterListener("Died", 1, "after", function(character)
    --Team Trajectile
    if character == Adam1 then
        Osi.SetFlag(Act1AdamFlag, Null, 0, 1)
        Osi.SetCanFight(Adam1, 0)
        Osi.Resurrect(Adam1, "", 0)
        Osi.AddBoosts(Adam1, "Invulnerable", "", Adam1)
        Ext.Timer.WaitFor(2000, function()
            Osi.CharacterMoveToPosition(Adam1, 166.20626831055, 4.8772296905518, 265.26229858398, "Sprint", "", 0)
            Osi.ApplyStatus(Adam1, "MMM_ADAMRUNAWAY1", 6, 1, "")
            Ext.Timer.WaitFor(2500, function()
                Osi.CharacterMoveToPosition(Adam1, 166.20626831055, 4.8772296905518, 265.26229858398, "Sprint", "", 0)
                Ext.Timer.WaitFor(4000, function()
                    Osi.PlayEffect(Adam1, "1b923cb2-133a-25bd-6cbf-f808ca1cb8d2", "", 1)
                    Ext.Timer.WaitFor(500, function()
                        Osi.SetOnStage(Adam1, 0)
                    end)
                end)
            end)
        end)
    end
    if character == Liam1 then
        Osi.SetFlag(Act1LiamFlag, Null, 0, 1)
        Osi.SetCanFight(Liam1, 0)
        Osi.Resurrect(Liam1, "", 0)
        Osi.AddBoosts(Liam1, "Invulnerable", "", Liam1)
        Ext.Timer.WaitFor(2000, function()
            Osi.CharacterMoveToPosition(Liam1, 166.20626831055, 4.8772296905518, 265.26229858398, "Sprint", "", 0)
            Osi.ApplyStatus(Liam1, "MMM_LIAMRUNAWAY1", 6, 1, "")
            Ext.Timer.WaitFor(2500, function()
                Osi.CharacterMoveToPosition(Liam1, 166.20626831055, 4.8772296905518, 265.26229858398, "Sprint", "", 0)
                Ext.Timer.WaitFor(4000, function()
                    Osi.PlayEffect(Liam1, "1b923cb2-133a-25bd-6cbf-f808ca1cb8d2", "", 1)
                    Ext.Timer.WaitFor(500, function()
                        Osi.SetOnStage(Liam1, 0)
                    end)
                end)
            end)
        end)
    end
    if character == Mike1 then
        Osi.SetFlag(Act1MikeFlag, Null, 0, 1)
        Osi.SetCanFight(Mike1, 0)
        Osi.Resurrect(Mike1, "", 0)
        Osi.AddBoosts(Mike1, "Invulnerable", "", Mike1)
        Ext.Timer.WaitFor(2000, function()
            Osi.CharacterMoveToPosition(Mike1, 166.20626831055, 4.8772296905518, 265.26229858398, "Sprint", "", 0)
            Osi.ApplyStatus(Mike1, "MMM_MIKERUNAWAY1", 6, 1, "")
            Ext.Timer.WaitFor(2500, function()
                Osi.CharacterMoveToPosition(Mike1, 166.20626831055, 4.8772296905518, 265.26229858398, "Sprint", "", 0)
                Ext.Timer.WaitFor(4000, function()
                    Osi.PlayEffect(Mike1, "1b923cb2-133a-25bd-6cbf-f808ca1cb8d2", "", 1)
                    Ext.Timer.WaitFor(500, function()
                        Osi.SetOnStage(Mike1, 0)
                    end)
                end)
            end)
        end)
    end
    --Spider bait
    if (character == DSpider0) then
        SpiderHorde()
    end
    --Spider horde kill counter
    if (character == DSpider11) then
        SpiderKillCounter = SpiderKillCounter + 1;
    end
    if (character == DSpider12) then
        SpiderKillCounter = SpiderKillCounter + 1;
    end
    if (character == DSpider13) then
        SpiderKillCounter = SpiderKillCounter + 1;
    end
    if (character == DSpider14) then
        SpiderKillCounter = SpiderKillCounter + 1;
    end
    if (character == DSpider15) then
        SpiderKillCounter = SpiderKillCounter + 1;
    end
    if (character == DSpider16) then
        SpiderKillCounter = SpiderKillCounter + 1;
    end
    if (character == DSpider17) then
        SpiderKillCounter = SpiderKillCounter + 1;
    end
    if (character == DSpider18) then
        SpiderKillCounter = SpiderKillCounter + 1;
    end
    if (character == DSpider19) then
        SpiderKillCounter = SpiderKillCounter + 1;
    end
    if (character == DSpider110) then
        SpiderKillCounter = SpiderKillCounter + 1;
    end
    if (character == DSpider111) then
        SpiderKillCounter = SpiderKillCounter + 1;
    end
    if (character == DSpider112) then
        SpiderKillCounter = SpiderKillCounter + 1;
    end
    if (SpiderKillCounter == 7) then
        SpiderHorde2()
    end
    --DUERGAR kills for summoning Ol Gregg
    if (character == "S_UND_DuergarRaftCaptain_473ae3b0-d8e9-428d-9129-bbffe449b8ec") then
        BoatkillCounter = BoatkillCounter + 1;
    end
    if (character == "S_UND_DuergarSquadAlchemist_2243e892-f360-44cf-b2ef-90364059dd22") then
        BoatkillCounter = BoatkillCounter + 1;
    end
    if (character == "S_UND_DuergarSquadDefiant_3cec487d-d5cf-42c9-a009-0124cb432341") then
        BoatkillCounter = BoatkillCounter + 1;
    end
    if (character == "S_UND_DuergarSquadDilligent_a7338653-4d88-440e-aee6-4d5b3e611a2d") then
        BoatkillCounter = BoatkillCounter + 1;
    end
    if (character == "S_UND_DuergarSquadRude_b15669aa-831b-43d7-ac7b-efea2eb09018") then
        BoatkillCounter = BoatkillCounter + 1;
    end
    if (character == "S_UND_DuergarSquadRatty_64e38ef0-9779-499c-9f0a-ea013ee81442") then
        BoatkillCounter = BoatkillCounter + 1;
    end
    if (BoatkillCounter == 6) then
        BoatkillCounter = 0
        Ext.Timer.WaitFor(30000, function()
            if WentPastGregg == 0 then
            ShowNotification(GetHostCharacter(), "You ever drink Bailey's from a shoe..?" )
            ThrowShoe()
                Ext.Timer.WaitFor(30000, function()
                    if WentPastGregg == 0 then
                        ShowNotification(GetHostCharacter(), "I'm Ol' Gregg!" )
                        Osi.PlayEffectAtPosition(OlGregg, -443.29486083984, 27.8359375, -523.27209472656, 2)
                        Osi.PlaySound(OlGregg, "Spell_Impact_Utility_Jump_L1to3")
                        Osi.SetOnStage(OlGregg, 1)
                    end
                end)
            end
        end)
    end
    --Mimic Boss Counter
    if ((character == HarperMimic1) and (Osi.IsDead(MegaMimic) == 0)) then
        MimicBoss = MimicBoss + 1;
        Osi.TeleportToPosition(HarperMimic1, -685.5205078125, -6.07421875, 375.92196655273, "MIMIC1DIE", 0, 0, 0, 1, 1)
        Osi.PlayEffectAtPosition("3e398ec8-03ca-ba6d-ceaa-c1cf2cac7c3e", -687.05163574219, -6.490234375, 374.89181518555, MimicBoss)
    end
    if ((character == HarperMimic2) and (Osi.IsDead(MegaMimic) == 0)) then
        MimicBoss = MimicBoss + 1;
        Osi.TeleportToPosition(HarperMimic2, -688.21392822266, -6.6494140625, 376.70120239258, "MIMIC2DIE", 0, 0, 0, 1, 1)
        Osi.PlayEffectAtPosition("3e398ec8-03ca-ba6d-ceaa-c1cf2cac7c3e", -687.05163574219, -6.490234375, 374.89181518555, MimicBoss)
    end
    if ((character == HarperMimic3) and (Osi.IsDead(MegaMimic) == 0)) then
        MimicBoss = MimicBoss + 1;
        Osi.TeleportToPosition(HarperMimic3, -687.03607177734, -6.9794921875, 372.26666259766, "MIMIC3DIE", 0, 0, 0, 1, 1)
        Osi.PlayEffectAtPosition("3e398ec8-03ca-ba6d-ceaa-c1cf2cac7c3e", -687.05163574219, -6.490234375, 374.89181518555, MimicBoss)
    end
    if (MimicBoss == 3) then
        if (Osi.IsDead(MegaMimic) == 0) then
        MimicBossFight()
        end
    end
    if (character == MegaMimic) then
        Ext.Timer.WaitFor(1000, function()
            Osi.SetOnStage(HarperMimic1, 1)
            Osi.SetOnStage(HarperMimic2, 1)
            Osi.SetOnStage(HarperMimic3, 1)
            Osi.SetOnStage(MegaMimic, 0)
        end)
    end
    --Grym 2 Death
    if character == Grym2 then
        Ext.Timer.WaitFor(100, function()
            -- Osi.LeaveCombat(ForgeGhost1)
            -- Osi.LeaveCombat(ForgeGhost2)
            -- Osi.SetOnStage(ForgeGhost1, 0)
            -- Osi.SetOnStage(ForgeGhost2, 0)
            Osi.Die(ForgeGhost1, 0, GetHostCharacter(), 0, 1, 500)
            Osi.Die(ForgeGhost2, 0, GetHostCharacter(), 0, 1, 500)
            Osi.Die(Grym, 0, "", 0, 1, 500)
            Osi.SetFlag("UND_AdamantineForge_State_GolemPermaDefeated_6e173bc8-a5ba-4052-a480-5222438a35d1", Null, 0, 1)
            Osi.ClearFlag("GLO_Lever_State_Blocked_473cad6c-a161-43ca-b1ed-8f9d4cb5ea57", "S_UND_AdamantineForge_Lever_21e51504-13c0-49c2-93aa-dbc113503297", 0, 0)
        end)
    end
end)

--Saw something listener
Ext.Osiris.RegisterListener("Saw", 3, "after", function(character, targetcharacter, targetwassneaking)
    --Goblin Crash Ambush Attack
    if ((character == AmbushGob1) or
    (character == AmbushGob2) or
    (character == AmbushGob3)) then
        if ((Osi.HasActiveStatus(character, "INVISIBLE") == 1) and (Osi.IsPlayer(targetcharacter) == 1)) then
            Osi.UseSpell(character, "Projectile_EnsnaringStrike", targetcharacter)
            Osi.ApplyStatus(targetcharacter, "SURPRISED", 1, 1, character)
            Osi.RemoveStatus(AmbushGob1, "INVISIBLE", "")
            Osi.RemoveStatus(AmbushGob2, "INVISIBLE", "")
            Osi.RemoveStatus(AmbushGob3, "INVISIBLE", "")
        end
    end
    --Set off chicken run event when seeing guard
    if (Osi.IsPlayer(character) == 1 and (targetcharacter == Chickenguard)) then
        ChickenEvent()
    end
    --Remove chicken run event if gone past it
    if (Osi.IsPlayer(character) == 1 and (targetcharacter == "S_GOB_Festivities_Trader_3c9f9d17-835c-46bf-929d-240e3b4adb55")) then
        ChickenKiller()
    end
    --Gnolls at backdoor walk in and set off trap
    if Osi.IsPlayer(character) == 1 and
    targetcharacter == "MMM_CAVEBACKDOOR_31da9358-a6a4-4a98-a199-85e09dea5b0e" and
    Osi.IsDestroyed("S_PLA_BanditCave_PlatformBarricade_01_f82470f0-72b2-487e-9b0b-10a4a3388d99") == 0 then
        Osi.CharacterMoveToPosition(BackdoorGnoll3, 49.923347473145, 28.5263671875, 563.97900390625, "Walk", "", 0)
        Ext.Timer.WaitFor(4000, function()
            Osi.Attack(BackdoorGnoll3, "S_PLA_BanditCave_PlatformBarricade_01_f82470f0-72b2-487e-9b0b-10a4a3388d99", 1)
            Osi.ApplyDamage("f82470f0-72b2-487e-9b0b-10a4a3388d99", 25, "Bludgeoning", BackdoorGnoll3)
            Ext.Timer.WaitFor(2000, function()
                Osi.CharacterMoveToPosition(BackdoorGnoll1, 50.958168029785, 30.1865234375, 591.98620605469, "Walk", "", 0)
                Osi.CharacterMoveToPosition(BackdoorGnoll2, 49.56689453125, 29.6904296875, 588.1772460937, "Walk", "", 0)
                Osi.CharacterMoveToPosition(BackdoorGnoll3, 52.401023864746, 29.3310546875, 587.01403808594, "Walk", "", 0)
            end)
        end)
    end
    --Drow Assassin 1 Attacks
    if (character == DrowAssassin1) then
        if ((Osi.HasActiveStatus(character, "INVISIBLE") == 1) and (Osi.IsPlayer(targetcharacter) == 1)) then
            Osi.UseSpell(character, "Projectile_SneakAttack", targetcharacter)
            Osi.ApplyStatus(targetcharacter, "SURPRISED", 1, 1, character)
            Osi.RemoveStatus(DrowAssassin1, "INVISIBLE", "")
        end
    end
    --Drow Assassin 2 Attacks
    if (character == DrowAssassin2) then
        if ((Osi.HasActiveStatus(character, "INVISIBLE") == 1) and (Osi.IsPlayer(targetcharacter) == 1)) then
            Osi.UseSpell(character, "Projectile_SneakAttack", targetcharacter)
            Osi.ApplyStatus(targetcharacter, "SURPRISED", 1, 1, character)
            Osi.RemoveStatus(DrowAssassin2, "INVISIBLE", "")
        end
    end
    --Drow Assassin 3 Attacks
    if (character == DrowAssassin3) then
        if ((Osi.HasActiveStatus(character, "INVISIBLE") == 1) and (Osi.IsPlayer(targetcharacter) == 1)) then
            Osi.UseSpell(character, "Projectile_SneakAttack", targetcharacter)
            Osi.ApplyStatus(targetcharacter, "SURPRISED", 1, 1, character)
            Osi.RemoveStatus(DrowAssassin3, "INVISIBLE", "")
        end
    end
end)

--Status Applied listener
Ext.Osiris.RegisterListener("StatusApplied", 4, "before", function(object, status, cause, storyActionID)
    --Goblin Ambush
    if status == "MMM_CRASHAMBUSH" then
        if Osi.GetFlag(GoblinCrashFlag, Null) == 0 then
            if Osi.IsTagged(object, GoblinCrashTag) == 0 then
                Osi.SetTag(object, GoblinCrashTag)
                Osi.RequestPassiveRoll(object, cause, "", "Perception", "Act1_Hard_831e1fbe-428d-4f4d-bd17-4206d6efea35", 0, "AMBUSHROLL")
            elseif Osi.IsTagged(object, GoblinCrashTag) == 1 then
                return
            end
        end
    end
    --Drow Ambush 1
    if status == "MMM_DROWAMBUSH1" then
        if Osi.GetFlag(DrowAmbush1Flag, Null) == 0 then
            if Osi.IsTagged(object, DrowAmbush1Tag) == 0 then
                Osi.SetTag(object, DrowAmbush1Tag)
                Osi.RequestPassiveRoll(object, cause, "", "Perception", "Act1_VeryHard_8986db4d-09af-46ee-9781-ac88ec10fa0e", 0, "DROWROLL1")
            elseif Osi.IsTagged(object, DrowAmbush1Tag) == 1 then
                return
            end
        end
    end
    -- if status == "MMM_DROWAMBUSH1" then
    --     if DrowAmbush1 == 0 then
    --         DrowAmbush1 = DrowAmbush1 + 1;
    --         Osi.RequestPassiveRoll(object, cause, "", "Perception", "Act1_Hard_831e1fbe-428d-4f4d-bd17-4206d6efea35", 0, "DROWROLL1")
    --     elseif DrowAmbush1 == 1 then
    --         return
    --     end
    -- end
    --Drow Ambush 2
    if status == "MMM_DROWAMBUSH2" then
        if Osi.GetFlag(DrowAmbush2Flag, Null) == 0 then
            if Osi.IsTagged(object, DrowAmbush2Tag) == 0 then
                Osi.SetTag(object, DrowAmbush2Tag)
                Osi.RequestPassiveRoll(object, cause, "", "Perception", "Act1_VeryHard_8986db4d-09af-46ee-9781-ac88ec10fa0e", 0, "DROWROLL2")
            elseif Osi.IsTagged(object, DrowAmbush2Tag) == 1 then
                return
            end
        end
    end
    -- if status == "MMM_DROWAMBUSH2" then
    --     if DrowAmbush2 == 0 then
    --         DrowAmbush2 = DrowAmbush2 + 1;
    --         Osi.RequestPassiveRoll(object, cause, "", "Perception", "Act1_Challenging_5e7ff0e9-6c80-459c-a636-3a3e8417a61a", 0, "DROWROLL2")
    --     elseif DrowAmbush2 == 1 then
    --         return
    --     end
    -- end
    --Drow Ambush 3
    if status == "MMM_DROWAMBUSH3" then
        if Osi.GetFlag(DrowAmbush3Flag, Null) == 0 then
            if Osi.IsTagged(object, DrowAmbush3Tag) == 0 then
                Osi.SetTag(object, DrowAmbush3Tag)
                Osi.RequestPassiveRoll(object, cause, "", "Perception", "Act1_VeryHard_8986db4d-09af-46ee-9781-ac88ec10fa0e", 0, "DROWROLL3")
            elseif Osi.IsTagged(object, DrowAmbush3Tag) == 1 then
                return
            end
        end
    end
    -- if status == "MMM_DROWAMBUSH3" then
    --     if DrowAmbush3 == 0 then
    --         DrowAmbush3 = DrowAmbush3 + 1;
    --         Osi.RequestPassiveRoll(object, cause, "", "Perception", "Act1_Challenging_5e7ff0e9-6c80-459c-a636-3a3e8417a61a", 0, "DROWROLL3")
    --     elseif DrowAmbush3 == 1 then
    --         return
    --     end
    -- end
    --DUERGAR Army 1
    if status == "MMM_DUERGARMARCH1" then
        if Osi.GetFlag(DuergarMarchFlag, Null) == 0 then
            for _, entity in ipairs(Ext.Entity.GetAllEntitiesWithComponent("BaseHp")) do
                local DuergarTag = entity.Uuid.EntityUuid
                if Osi.IsTagged(DuergarTag, "25bf5042-5bf6-4360-8df8-ab107ccb0d37") == 1 then
                    if Osi.GetDistanceTo(DuergarTrigger1, DuergarTag) <= 20 then
                        Osi.RequestPassiveRoll(DuergarTag, cause, "", "Perception", "Act1_VeryHard_8986db4d-09af-46ee-9781-ac88ec10fa0e", 0, "DUERGARROLL1")
                    end
                end
            end
            DUERGARARMYMARCH1()
            Osi.SetFlag(DuergarMarchFlag, Null, 0, 1)
        end
    end
    -- if status == "MMM_DUERGARMARCH1" then
    --     if DuergarMarch == 0 then
    --         DuergarMarch = DuergarMarch + 1;
    --         DUERGARARMYMARCH1()
    --     elseif DuergarMarch == 1 then
    --         return
    --     end
    -- end
    --DUERGAR Army 2
    if status == "MMM_DUERGARMARCH2" then
        if Osi.GetFlag(DuergarMarchFlag, Null) == 0 then
            for _, entity in ipairs(Ext.Entity.GetAllEntitiesWithComponent("BaseHp")) do
                local DuergarTag = entity.Uuid.EntityUuid
                if Osi.IsTagged(DuergarTag, "25bf5042-5bf6-4360-8df8-ab107ccb0d37") == 1 then
                    if Osi.GetDistanceTo(DuergarTrigger2, DuergarTag) <= 20 then
                        Osi.RequestPassiveRoll(DuergarTag, cause, "", "Perception", "Act1_VeryHard_8986db4d-09af-46ee-9781-ac88ec10fa0e", 0, "DUERGARROLL2")
                    end
                end
            end
            DUERGARARMYMARCH2()
            Osi.SetFlag(DuergarMarchFlag, Null, 0, 1)
        end
    end
    -- if status == "MMM_DUERGARMARCH2" then
    --     if DuergarMarch == 0 then
    --         DuergarMarch = DuergarMarch + 1;
    --         Osi.RequestPassiveRoll(object, cause, "", "Perception", "Act1_Challenging_5e7ff0e9-6c80-459c-a636-3a3e8417a61a", 0, "DUERGARROLL2")
    --         DUERGARARMYMARCH2()
    --     elseif DuergarMarch == 1 then
    --         return
    --     end
    -- end
    --Lolth Event
    if ((object == "LTS_DUN_Candles_Cluster_B_Gold_000_82a59deb-c0f8-41bb-9158-57af3e7d808f") and (status == "BURNING")) then
        LolthEvent()
    end
    --Bulette Eggs
    if status == "MMM_BULETTETRIGGER" then
        BULETTEHATCH()
    end
end)

--Roll listener
Ext.Osiris.RegisterListener("RollResult", 6, "after", function(eventName, roller, rollsubject, resultType, isActiveRoll, criticality)
    --Set Crash Ambush result
    if eventName == "AMBUSHROLL" then
        if resultType == 1 then
            Osi.RemoveStatus(AmbushGob1, "INVISIBLE", "")
            Osi.RemoveStatus(AmbushGob2, "INVISIBLE", "")
            Osi.RemoveStatus(AmbushGob3, "INVISIBLE", "")
            Osi.RemoveStatus(AmbushGob3, "MMM_CRASHDETECT", "")
            Osi.SetFlag(GoblinCrashFlag, Null, 0, 1)
        elseif resultType == 0 then
            return
        end
    end
    --Set Drow 1 Ambush Result
    if eventName == "DROWROLL1" then
        Osi.RemoveStatus(DrowAssassin1, "MMM_DROWDETECT1", "")
        if resultType == 1 then
            Osi.RemoveStatus(DrowAssassin1, "INVISIBLE", "")
            Osi.SetFlag(DrowAmbush1Flag, Null, 0, 1)
        elseif resultType == 0 then
            return
        end
    end
    --Set Drow 2 Ambush Result
    if eventName == "DROWROLL2" then
        Osi.RemoveStatus(DrowAssassin2, "MMM_DROWDETECT2", "")
        if resultType == 1 then
            Osi.RemoveStatus(DrowAssassin2, "INVISIBLE", "")
            Osi.SetFlag(DrowAmbush2Flag, Null, 0, 1)
        elseif resultType == 0 then
            return
        end
    end
    --Set Drow 3 Ambush Result
    if eventName == "DROWROLL3" then
        Osi.RemoveStatus(DrowAssassin3, "MMM_DROWDETECT3", "")
        if resultType == 1 then
            Osi.RemoveStatus(DrowAssassin3, "INVISIBLE", "")
            Osi.SetFlag(DrowAmbush3Flag, Null, 0, 1)
        elseif resultType == 0 then
            return
        end
    end
    --Set DUERGAR 1 Result
    if eventName == "DUERGARROLL1" then
        Osi.RemoveStatus(DuergarTrigger1, "MMM_DUERGARDETECT1", "")
        Osi.RemoveStatus(DuergarTrigger2, "MMM_DUERGARDETECT2", "")
        if resultType == 1 then
            ShowNotification(GetHostCharacter(), "You hear heavy footsteps approaching.")
            PrepareDuration = 24;
            PreparedBoost()
        elseif resultType == 0 then
            return
        end
    end
    --Set DUERGAR 2 Result
    if eventName == "DUERGARROLL2" then
        Osi.RemoveStatus(DuergarTrigger1, "MMM_DUERGARDETECT1", "")
        Osi.RemoveStatus(DuergarTrigger2, "MMM_DUERGARDETECT2", "")
        if resultType == 1 then
            ShowNotification(GetHostCharacter(), "You hear heavy footsteps approaching.")
            PrepareDuration = 30;
            PreparedBoost()
        elseif resultType == 0 then
            return
        end
    end
    --Cave In Result
    if eventName == "CAVEINROLL" then
        if resultType == 1 then
            ShowNotification(GetHostCharacter(), "You hear something approaching, get ready!")
            PrepareDuration = 24;
            PreparedBoost()
            Ext.Timer.WaitFor(6000, function()
                CaveIn()
            end)
        elseif resultType == 0 then
            Ext.Timer.WaitFor(1000, function()
                CaveIn()
            end)
        end
    end
end)

--Flag listener
Ext.Osiris.RegisterListener("FlagSet", 3, "after", function(flag, speaker, dialogInstance)
    --Went past Gregg
    if flag == "UND_EbonLake_Event_MoveToCamp_0da8fee9-b7cb-4551-9baa-ec930c118716" then
        WentPastGregg = WentPastGregg + 1;
    end
end)

--Event listener
Ext.Osiris.RegisterListener("EntityEvent", 2, "before", function(object, event)
    if event == "DEN_RaidingParty_ZevlorUsedHorn" then
        GroveGuardians()
    end
end)

--On Stage listener
Ext.Osiris.RegisterListener("WentOnStage", 2, "after", function(object, isOnStageNow)
    if object == Grym then
        if Osi.IsDestroyed(GrymBossMarker) == 0 then
            return
        elseif Osi.IsDestroyed(GrymBossMarker) == 1 then
            Osi.SetOnStage(Grym, 0)
            Osi.SetOnStage(Grym2, 1)
            Osi.SetOnStage(ForgeGhost1, 1)
            Osi.SetOnStage(ForgeGhost2, 1)
        end
    end
end)

--Using Spell On Target
Ext.Osiris.RegisterListener("UsingSpellOnTarget", 6, "after", function(caster, target, spell, spellType, spellElement, storyActionID)
    if spell == "MMM_Target_CONSUMEBULETTE" then
        Ext.Timer.WaitFor(1500, function()
            local entity = Ext.Entity.Get(target)
            for _, p in pairs(entity.InventoryOwner.PrimaryInventory.InventoryContainer.Items) do
                Osi.Drop(p.Item.Uuid.EntityUuid)
            end
            Osi.SetOnStage(target, 0)
            if Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE1") == 0 and
            Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE2") == 0 and
            Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE3") == 0 and
            Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE4") == 0 and
            Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE5") == 0 and
            Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE6") == 0 and
            Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE7") == 0 then
                Osi.ApplyStatus(caster, "MMM_SURVIVALSIZE1", -1, 1, caster)
            elseif Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE1") == 1 and
            Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE2") == 0 and
            Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE3") == 0 and
            Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE4") == 0 and
            Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE5") == 0 and
            Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE6") == 0 and
            Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE7") == 0 then
                Osi.ApplyStatus(caster, "MMM_SURVIVALSIZE2", -1, 1, caster)
            elseif Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE1") == 0 and
            Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE2") == 1 and
            Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE3") == 0 and
            Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE4") == 0 and
            Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE5") == 0 and
            Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE6") == 0 and
            Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE7") == 0 then
                Osi.ApplyStatus(caster, "MMM_SURVIVALSIZE3", -1, 1, caster)
            elseif Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE1") == 0 and
            Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE2") == 0 and
            Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE3") == 1 and
            Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE4") == 0 and
            Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE5") == 0 and
            Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE6") == 0 and
            Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE7") == 0 then
                Osi.ApplyStatus(caster, "MMM_SURVIVALSIZE4", -1, 1, caster)
            elseif Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE1") == 0 and
            Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE2") == 0 and
            Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE3") == 0 and
            Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE4") == 1 and
            Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE5") == 0 and
            Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE6") == 0 and
            Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE7") == 0 then
                Osi.ApplyStatus(caster, "MMM_SURVIVALSIZE5", -1, 1, caster)
            elseif Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE1") == 0 and
            Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE2") == 0 and
            Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE3") == 0 and
            Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE4") == 0 and
            Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE5") == 1 and
            Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE6") == 0 and
            Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE7") == 0 then
                Osi.ApplyStatus(caster, "MMM_SURVIVALSIZE6", -1, 1, caster)
            elseif Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE1") == 0 and
            Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE2") == 0 and
            Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE3") == 0 and
            Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE4") == 0 and
            Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE5") == 0 and
            Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE6") == 1 and
            Osi.HasActiveStatus(caster, "MMM_SURVIVALSIZE7") == 0 then
                Osi.ApplyStatus(caster, "MMM_SURVIVALSIZE7", -1, 1, caster)
            end
        end)
    end
end)
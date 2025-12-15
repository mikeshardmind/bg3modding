
-- SRC:
-- https://github.com/Difficulty-Immersion-Quality/DIQ-Misc-Patches/blob/main/DIQ%20Misc%20Patches/Mods/ManyMoreMonsters/ScriptExtender/Lua/MonsterJam/Shadowlands.lua


--Why did I make so many things oh god
local Null = "NULL_00000000-0000-0000-0000-000000000000"
local ShadowGithSouth1 = "MMM_SCGITH_SOUTHDOOR_46a41ea3-1788-411d-949f-a32c299d7d06"
local ShadowGithSouth2 = "MMM_SCGITH_SOUTHDOOR_b993991f-a98c-4691-8f64-e354c3badba3"
local ShadowGithSouth3 = "MMM_SCGITH_SOUTHDOOR_884bd262-0b6a-4339-bc56-88294e19aa64"
local ShadowGithSouth4 = "MMM_SCGITH_SOUTHDOOR_c329e6b5-e96d-4a85-a0d7-edc7f13cbcc9"
local ShadowFamily1 = "MMM_SHADOWFAMILY_d0ccd7a6-5958-4074-8031-833c3495e229"
local ShadowFamily2 = "MMM_SHADOWFAMILY_7356984b-1a29-497f-bc9a-f9f1828b4222"
local ShadowFamily3 = "MMM_SHADOWFAMILY_c3daa7c5-e40a-46f7-bf8d-b3b0a4475f2b"
local ShadowFamily4 = "MMM_SHADOWFAMILY_2626f012-653a-45c6-a57c-67679555f6fb"
local ShadowToiletGuy = "MMM_SHADOWTOILET_3c9e62e8-b85f-4c5d-a0c8-9efa8f49516a"
local HarperDruidTrigger1 = "MMM_TRIGGERPOINT_HARPERDRUIDS_0f026cc6-05d1-44b7-a8e8-2ff86f56cf60"
local HarperDruid1 = "MMM_HARPERDRUIDBATTLEFIELD_6eaf3dc3-a0ec-4248-a593-d7b22075295b"
local HarperDruid2 = "MMM_HARPERDRUIDBATTLEFIELD_c6741d50-fb1e-4d10-a8e1-8f3f25c84029"
local HarperDruid3 = "MMM_HARPERDRUIDBATTLEFIELD_2d337d97-b62e-4e7b-a235-1a74ee096f85"
local HarperDruid4 = "MMM_HARPERDRUIDBATTLEFIELD_93074113-200e-4791-bb49-7c6a59e10b49"
local HarperDruid5 = "MMM_HARPERDRUIDBATTLEFIELD_9a414810-94ca-4a27-a073-37e6af6ec95b"
local HarperDruid6 = "MMM_HARPERDRUIDBATTLEFIELD_12b1ea52-c574-4f81-a0ff-96a1cec8d719"
local HarperDruid7 = "MMM_HARPERDRUIDBATTLEFIELD_dfd36798-52dc-45b7-8101-ac3598fed65d"
local HarperDruid8 = "MMM_SHADOWHARPERDRUID1_bcee554a-6c98-4215-bf95-6bf9221947e0"
local HarperDruid9 = "MMM_SHADOWHARPERDRUID1_8efce3f5-9d57-4cb4-8ab2-b5d28c56dc94"
local HarperDruid10 = "MMM_SHADOWHARPERDRUID1_2898b4d7-ae3c-487c-82e4-4eb3a63e259b"
local HarperDruid11 = "MMM_SHADOWHARPERDRUID1_206858d7-9b15-4acf-8915-3918e7478aca"
local MeazelAmbushTrigger = "MMM_TRIGGERPOINT_MEAZELAMBUSH_54a95892-849b-452e-a0f6-9defcff3dce4"
local MeazelAmbush1 = "MMM_MEAZELAMBUSH_58022613-d175-4751-8fff-c897f778fd6d"
local MeazelAmbush2 = "MMM_MEAZELAMBUSH_7245a674-cdd3-43e7-ba75-6fdfdd38d23f"
local MeazelAmbush3 = "MMM_MEAZELAMBUSH_b3ec2c95-7a2c-42b2-a696-c7a58acd6e92"
local MeazelAmbush4 = "MMM_MEAZELAMBUSH_7032883f-5803-4689-a641-88edea9d98fe"
local BalthazerTrigger1 = "MMM_TRIGGERPOINT_BALTHAZAR_ef903bef-1c07-46ca-8643-e48aeebc4427"
local BalthazarEvent1 = "S_SHA_Necromancer_a7a2cdb7-fc6b-4bb5-b4d8-feff84e466d3"
local BalthazarZombie1 = "MMM_BALTHAZARZOMBIE_df0c3aa8-1d07-49f8-b035-d04d0f5684d1"
local BalthazarZombie2 = "MMM_BALTHAZARZOMBIE_c63affdb-c020-494d-a1e9-5fcb7819a82b"
local BalthazarZombie3 = "MMM_BALTHAZARZOMBIE_9136f7ba-1d20-48c8-94ab-5db5ead804d1"
local BalthazarZombie4 = "MMM_BALTHAZARZOMBIE_a2d93742-9537-438e-b396-34d1f312f059"
local BalthazarZombie5 = "MMM_BALTHAZARZOMBIE_b8b9c59f-4743-404a-b59f-4287d02003b2"
local CrazedSquirrel1 = "MMM_CRAZEDSQUIRREL_6275db9d-499a-4c33-a4c1-6d8d3874a94b"
local CrazedSquirrel2 = "MMM_CRAZEDSQUIRREL_0df5e645-3bbd-443a-9bcb-0f3d4c7e57ba"
local CrazedSquirrel3 = "MMM_CRAZEDSQUIRREL_7f78517b-fce3-4217-b8c3-e8cbfbbb41d2"
local CrazedSquirrel4 = "MMM_CRAZEDSQUIRREL_41a3c31a-26b7-4dc3-b570-8cff96b47080"
local CrazedSquirrel5 = "MMM_CRAZEDSQUIRREL_4a55cc16-d9f3-4ebb-824c-5426045b8482"
local CrazedSquirrel6 = "MMM_CRAZEDSQUIRREL_06475630-c519-4dfe-9da4-6ced402a04ce"
local CrazedSquirrel7 = "MMM_CRAZEDSQUIRREL_66e02b7e-0bc0-4bf2-b8cf-bb4297df55cc"
local CrazedSquirrel8 = "MMM_CRAZEDSQUIRREL_178f0e08-d8ae-41d0-99a5-d8e8144b4945"
local CrazedSquirrel9 = "MMM_CRAZEDSQUIRREL_3eca352e-5b02-473c-8e27-6be750516f2c"
local CrazedSquirrel10 = "MMM_CRAZEDSQUIRREL_b083eefc-4eda-460b-87e6-ddc8de0a27bd"
local CrazedSquirrel11 = "MMM_CRAZEDSQUIRREL_9b926545-54bd-49db-923f-3349c335e297"
local CrazedSquirrel12 = "MMM_CRAZEDSQUIRREL_470d4ed0-85a2-4e6e-bd09-f37a47662a9d"
local CrazedSquirrel13 = "MMM_CRAZEDSQUIRREL_5d9f6dd6-1a7c-4e76-8e1d-042617ef1b40"
local CrazedSquirrel14 = "MMM_CRAZEDSQUIRREL_e8560c15-f1a0-43bd-b619-a301b9b24544"
local CrazedSquirrel15 = "MMM_CRAZEDSQUIRREL_2f69c995-54bd-4b34-ac72-f12f823a5b94"
local ChildWraithKid = "MMM_CHILDWRAITH_42ab304e-a3d3-41e0-878a-f54241e75478"
local ChildWraithUndead = "MMM_CHILDWRAITH_dff8911e-f42c-4825-854c-8f6793ab78a7"
local Shadarkai1 = "MMM_SHADARKAIGROUP_7595107d-f96c-4525-944f-98dde61c9c72"
local Shadarkai1 = "MMM_SHADARKAIGROUP_664d414d-57ad-459b-822a-10c0e43b80e4"
local Shadarkai1 = "MMM_SHADARKAIGROUP_3204422c-e6e7-4937-a418-3f113e88b994"
local EllieMay = "MMM_RINGEVENT_77bde205-4dcf-4978-a452-cb686bc1db1c"
local BalthazerTrigger2 = "MMM_TRIGGERPOINT_BALTHAZAR_3a0b4676-c655-4088-94ca-4a63d7775f9c"
local BalthazarEvent2 = "S_SHA_Necromancer_5406f805-858d-4399-9a12-8c7ff4124802"
local BalthazarSkeletonBoss = "MMM_BALTHAZARSKELETON_45437558-8c7b-45b3-8a4f-4201643ebe9a"
local SpiderKing = "MMM_SPIDERKING_0683b560-c29e-4a0b-b15f-f02703d3e219"
local SpiderKingChestburster = "MMM_SPIDERKING_14abb173-f375-4dfd-96e2-afc6e7cba83f"
local SpiderKingSummon = "MMM_TINYSPIDY_04c2d10f-b08e-4966-9a71-352629e4f16f"
local Act2Mimic = "MMM_ACT2MIMIC_95a8f34e-f91c-4763-b947-b16751ff6378"
local Adam2 = "MMM_THIEFTRIO2_a240a700-d98a-47aa-acd6-02d555a188b4"
local Liam2 = "MMM_THIEFTRIO2_6fb1c8ce-5874-44dd-9061-3315edeb3121"
local Mike2 = "MMM_THIEFTRIO2_25dc141c-5e1c-4dd6-a327-ffc77bbc6418"
local ThiefPixie = "MMM_THIEFTRIO2_57f0740b-352e-464e-ab47-2e112aa5a8a4"

--Mimic Chests
local Act2Chest1 = "MMM_ACT2CHEST_1d9926fd-e69c-4cde-8ec9-ccaf5f0825da"
local Act2Chest2 = "MMM_ACT2CHEST_fafb1cd4-4d93-4264-8251-1e597cde58e9"
local Act2Chest3 = "MMM_ACT2CHEST_04c52d4d-7bc1-4dc2-be6e-e3024370d46b"
local Act2Chest4 = "MMM_ACT2CHEST_4f98b9c3-a472-4e17-98b8-544f0613f3b5"
local Act2Chest5 = "MMM_ACT2CHEST_fa56edea-8448-49c4-bd9b-e75334d2b475"
local Act2Chest6 = "MMM_ACT2CHEST_d8541621-cd1c-49fc-8041-245a397559a6"
local Act2Chest7 = "MMM_ACT2CHEST_3d79243b-6538-4731-a5e1-6847b3869782"
local Act2Chest8 = "MMM_ACT2CHEST_6d68711b-05a6-43e2-a09a-4597c1150934"
local Act2Chest9 = "MMM_ACT2CHEST_ed245a2c-78fc-463a-8927-bd3863a59a52"
local Act2Chest10 = "MMM_ACT2CHEST_b15a24f4-a019-4659-bfa3-1507b305f9cc"
local Act2Chest11 = "MMM_ACT2CHEST_4ef6a7ea-4539-4ca8-93d4-600c721d5d82"
local Act2Chest12 = "MMM_ACT2CHEST_7579212d-f056-4820-85cc-47be9a11ae9a"
local Act2Chest13 = "MMM_ACT2CHEST_93ac0962-ee20-4f56-b527-f0ad7747af7b"
local Act2Chest14 = "MMM_ACT2CHEST_6304f8d8-884f-445e-9c52-1a026e94ab8c"
local Act2Chest15 = "MMM_ACT2CHEST_8da172fb-93b8-44c2-9128-d6e974c3a060"
local Act2Chest16 = "MMM_ACT2CHEST_bba7e81d-3512-4eaf-9cab-311658508455"
local Act2Chest17 = "MMM_ACT2CHEST_83e17915-f572-483f-aaa4-d50ab5453bff"
local Act2Chest18 = "MMM_ACT2CHEST_b5dafc12-97da-40c2-9b05-60e241ecadec"
local Act2Chest19 = "MMM_ACT2CHEST_e1f69e6f-2dbe-46b2-a73b-e42a1237c042"
local Act2Chest20 = "MMM_ACT2CHEST_9b290aeb-8bc5-42d3-a005-0c26114f1751"
local Act2Chest21 = "MMM_ACT2CHEST_17603e87-514c-4599-a416-6901a669378f"
local Act2Chest22 = "MMM_ACT2CHEST_ca7fd4c6-d1d4-41ce-bc8f-70e921847c1a"
local Act2Chest23 = "MMM_ACT2CHEST_4d53d39c-68a5-4434-9f30-43ffb28f32f0"
local Act2Chest24 = "MMM_ACT2CHEST_687838b8-464e-4d33-921c-36ce0d58c6f0"
local Act2Chest25 = "MMM_ACT2CHEST_2d0804ea-f40f-4b53-8b62-7eebd00327ee"
local Act2Chest26 = "MMM_ACT2CHEST_8f16c67c-9fb2-48e8-bc8a-1fd175315c41"
local Act2Chest27 = "MMM_ACT2CHEST_7b603e5e-a651-4c09-ad9e-0c125df0af1a"
local Act2Chest28 = "MMM_ACT2CHEST_9f7c246d-841b-4d59-bc0c-540552a6e21f"
local Act2Chest29 = "MMM_ACT2CHEST_196142f3-de41-481e-a221-6ceb301f273a"
local Act2Chest30 = "MMM_ACT2CHEST_66414d7d-4f34-476d-b1be-5a3dbb7ed2ff"
local Act2Chest31 = "MMM_ACT2CHEST_ede6087f-89ed-486d-bb27-e923c3b0bcd7"
local Act2Chest32 = "MMM_ACT2CHEST_e23dbf01-375f-46e0-9a3d-a193c454a4d7"
local Act2Chest33 = "MMM_ACT2CHEST_7a786fbd-d02d-4bd2-a14f-f7606a9d4c9b"

--Factions
local FAbsoluteUndead = "60749034-59cb-4551-b5ea-07d1edd617a9"
local FOrpheusGish = "ACT2B_INT_Orpheus_ad62a159-c6fb-43ae-a682-63c139905874"
local FNeutral = "cfb709b3-220f-9682-bcfb-6f0d8837462e"
local FPlayer = "Hero_Player1_6545a015-1b3d-66a4-6a0e-6ec62065cdb7"
local FEvil = "Evil_NPC_64321d50-d516-b1b2-cfac-2eb773de1ff6"
local FShadowCreature = "ACT2_HAV_ShadowCreatures_b0b8d20c-89f8-4433-bd62-5cbcbae2e9bc"
local FSpiderKing = ""

--Item List
local ShadowToiletSeat = "BLD_GEN_Outhouse_Toilet_Seat_A_002_6891fef4-458e-4358-af3c-3c1cc73af4c3"
local ShadowToiletDoor = "BLD_GEN_Outhouse_Toilet_Door_A_002_d1c55c03-e9e2-48ac-901a-249d17b90c19"
local HarperDruidSkeleton1 = "DEC_Dungeon_Skeleton_Dark_Justiciar_Laying_C_009_842cd769-a547-49c5-a1f2-f5351ea14b0e"
local HarperDruidSkeleton2 = "DEC_Dungeon_Skeleton_Dark_Justiciar_Laying_C_008_0ebd41a0-1044-4a91-8107-4322dd452af6"
local HarperDruidSkeleton3 = "DEC_Dungeon_Skeleton_Dark_Justiciar_GravelPile_B_002_1d8c4366-585d-47f1-b315-bbb37629155b"
local HarperDruidSkeleton4 = "S_SCL_EmeraldSkeleton1_19e06153-b42b-4019-9af9-a5cdf5609e02"
local HarperDruidSkeleton5 = "DEC_Dungeon_Skeleton_Crawling_B_007_0921c4f6-d0c8-40a6-8678-22af6ea5c791"
local HarperDruidSkeleton6 = "DEC_Dungeon_Skeleton_Dark_Justiciar_Laying_A_004_792e172f-3b11-46d2-8698-8f730a49fb6b"
local HarperDruidSkeleton7 = "DEC_Dungeon_Skeleton_Dark_Justiciar_LayingTable_B_001_c0827f2a-75c9-45c8-b5b7-e148118a9e30"
local GraveyardTorch1 = "LTS_GEN_Torch_A_077_b2dfd78a-01b3-49f2-ae14-19f0d40bdabe"
local GraveyardTorch2 = "LTS_GEN_Torch_A_079_b4509aea-bf43-4675-8a4a-b8a363482770"
local GraveyardTorch3 = "LTS_GEN_Torch_A_078_e7d51025-f009-44d3-a236-8b590ab0a4ed"
local GraveyardTorch4 = "LTS_GEN_Torch_A_076_9f1f366a-6af8-4f1d-b412-1cb1156db925"
local GraveyardTorch5 = "LTS_GEN_Torch_A_073_c375af24-497d-4a1d-bfd9-f4d145ede1ca"
local GraveyardTorch6 = "LTS_GEN_Torch_A_080_141dc77e-8951-4b18-b4e1-1f5328ca9af9"
local GraveyardTorch7 = "LTS_GEN_Torch_A_075_60ae669b-2272-4d74-b65d-b44273ec7968"
local SquirrelChest = "S_SCL_Chest_000_269f30ee-fad4-4632-aec3-68fc7b6d1176"
local RobberWifeRing = "S_SCL_SkepticalRobber_WifesRing_bd1d4654-d29e-420d-8bfa-ded0d89bb6ed"
local RobberWifeGrave = "S_SCL_SkepticalRobber_Grave_ebc38f3c-6638-4394-8ea5-f77d65578919"

--Flags
local InitiateAct2 = "MMM_Act2_Initiate_1c54ccd3-c291-4303-a8f8-c8a16be80de2"
local Act2SpiderKingFlag = "MMM_Act2_SpiderKing_1513a2ba-e842-470c-9313-bc8b9c803585"
local Act2SpiderKingWave1Flag = "MMM_Act2_SpiderKing_0cdd3ca4-e974-4c1e-a195-a0ad555112cb"
local Act2SpiderKingWave2Flag = "MMM_Act2_SpiderKing_3be9f0cc-2a4d-4566-adf3-492f264d65aa"
local Act2MimicFlag = "MMM_Act2_Mimics_0d8437a9-e234-47cf-9498-bebe14ed8d78"
local Act2ChildWraithFlag = "MMM_Act2_Child_b58184c2-5ac4-457a-ab5b-dd415fdea886"
local Act1bAdamFlag = "MMM_Act1b_Adam_f5986888-456d-4b43-acdd-5a964397d1b5"
local Act1bLiamFlag = "MMM_Act1b_Liam_2a947065-d6c4-4497-906b-eefd01403341"
local Act1bMikeFlag = "MMM_Act1b_Mike_e0c88f29-8176-4b2c-ab41-412607a99ed0"
local Act2AdamFlag = "MMM_Act2_Adam_f054a046-1bec-45b2-967c-a30cda09db62"
local Act2LiamFlag = "MMM_Act2_Liam_e8712d83-3a05-4948-9934-f2842e5cf360"
local Act2MikeFlag = "MMM_Act2_Mike_67d7b164-a43d-4c44-b64e-a5d449c02e8a"

--On Load
local function InitiateMonstersShadowlands()
    Osi.SetOnStage(HarperDruid1, 0)
    Osi.SetOnStage(HarperDruid2, 0)
    Osi.SetOnStage(HarperDruid3, 0)
    Osi.SetOnStage(HarperDruid4, 0)
    Osi.SetOnStage(HarperDruid5, 0)
    Osi.SetOnStage(HarperDruid6, 0)
    Osi.SetOnStage(HarperDruid7, 0)
    Osi.SetOnStage(MeazelAmbush1, 0)
    Osi.SetOnStage(MeazelAmbush2, 0)
    Osi.SetOnStage(MeazelAmbush3, 0)
    Osi.SetOnStage(MeazelAmbush4, 0)
    Osi.SetOnStage(BalthazarEvent1, 0)
    Osi.SetOnStage(BalthazarZombie1, 0)
    Osi.SetOnStage(BalthazarZombie2, 0)
    Osi.SetOnStage(BalthazarZombie3, 0)
    Osi.SetOnStage(BalthazarZombie4, 0)
    Osi.SetOnStage(BalthazarZombie5, 0)
    Osi.SetOnStage(CrazedSquirrel1, 0)
    Osi.SetOnStage(CrazedSquirrel2, 0)
    Osi.SetOnStage(CrazedSquirrel3, 0)
    Osi.SetOnStage(CrazedSquirrel4, 0)
    Osi.SetOnStage(CrazedSquirrel5, 0)
    Osi.SetOnStage(CrazedSquirrel6, 0)
    Osi.SetOnStage(CrazedSquirrel7, 0)
    Osi.SetOnStage(CrazedSquirrel8, 0)
    Osi.SetOnStage(CrazedSquirrel9, 0)
    Osi.SetOnStage(CrazedSquirrel10, 0)
    Osi.SetOnStage(CrazedSquirrel11, 0)
    Osi.SetOnStage(CrazedSquirrel12, 0)
    Osi.SetOnStage(CrazedSquirrel13, 0)
    Osi.SetOnStage(CrazedSquirrel14, 0)
    Osi.SetOnStage(CrazedSquirrel15, 0)
    Osi.SetOnStage(ChildWraithUndead, 0)
    Osi.SetOnStage(EllieMay, 0)
    Osi.SetOnStage(BalthazarEvent2, 0)
    Osi.SetOnStage(BalthazarSkeletonBoss, 0)
end

local function ModifyMonstersShadowlands()
    if Osi.GetFlag(Act1bAdamFlag, Null) == 1 and
    Osi.GetFlag(Act1bMikeFlag, Null) == 1 and
    Osi.GetFlag(Act1bLiamFlag, Null) == 1 and
    Osi.GetFlag(Act2AdamFlag, Null) == 0 and
    Osi.GetFlag(Act2MikeFlag, Null) == 0 and
    Osi.GetFlag(Act2LiamFlag, Null) == 0 then
        Osi.SetOnStage(Adam2, 1)
        Osi.SetOnStage(Mike2, 1)
        Osi.SetOnStage(Liam2, 1)
        -- Osi.SetOnStage(ThiefPixie, 1)
        Osi.ApplyStatus(Adam2, "GLO_PIXIESHIELD", -1, 1, Adam2)
        Osi.ApplyStatus(Mike2, "GLO_PIXIESHIELD", -1, 1, Mike2)
        Osi.ApplyStatus(Liam2, "GLO_PIXIESHIELD", -1, 1, Liam2)
        -- Osi.ApplyStatus(ThiefPixie, "GLO_PIXIESHIELD", -1, 1, ThiefPixie)
        -- Osi.ApplyStatus(ThiefPixie, "INVULNERABLE", -1, 1, ThiefPixie)
        -- Osi.ApplyStatus(ThiefPixie, "MMM_THIEFTRIOPIXIEDETECT", -1, 1, ThiefPixie)
    else
        Osi.SetOnStage(Adam2, 0)
        Osi.SetOnStage(Mike2, 0)
        Osi.SetOnStage(Liam2, 0)
        -- Osi.SetOnStage(ThiefPixie, 0)
    end
end

--Create Mimics
local function CreateAct2Mimics()
    local Act2ChestList = { Act2Chest1, Act2Chest2, Act2Chest3, Act2Chest4, Act2Chest5, Act2Chest6, Act2Chest7, Act2Chest8, Act2Chest9, Act2Chest10,
                            Act2Chest11, Act2Chest12, Act2Chest13, Act2Chest14, Act2Chest15, Act2Chest16, Act2Chest17, Act2Chest18, Act2Chest19, Act2Chest20,
                            Act2Chest21, Act2Chest22, Act2Chest23, Act2Chest24, Act2Chest25, Act2Chest26, Act2Chest27, Act2Chest28, Act2Chest29, Act2Chest30,
                            Act2Chest31, Act2Chest32, Act2Chest33 }
    for _,PossibleMimic in ipairs(Act2ChestList) do
    local IsItAMimic = Ext.Utils.Random(1,5)
        if IsItAMimic == 1 then
            print("Mimic")
            Osi.ApplyStatus(PossibleMimic, "MMM_MIMIC2", -1, 1, PossibleMimic)
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

function TurnIntoMimic2(item, character)
    if Osi.IsDead(item) == 1 then
        return
    end
    local x,y,z = Osi.GetPosition(item)
    local MimicSpawnID = Osi.CreateAt(Act2Mimic, x, y, z, 0, 1, '')
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

--Toilet Guy Sit Down  --IS THERE A FART EFFECT?
local function ToiletGuyTrigger()
    if Osi.IsDead(ShadowToiletGuy) == 0 then
        Osi.Use(ShadowToiletGuy, ShadowToiletSeat, -1, 1, "shadowtoiletsitdown")
    end
end

--Raise Druids
local function RaiseDruids()
    Ext.Timer.WaitFor(5000, function()
        Osi.SetOnStage(HarperDruid1, 1)
        Osi.PlayEffect(HarperDruid1, "3c48f934-629d-0e94-4b6f-66f359cafb03", "", 2)
        Osi.SetOnStage(HarperDruidSkeleton1, 0)
        Osi.ApplyStatus(HarperDruid1, "MMM_SHADOWDRUIDSPEAK1", 1)
        Ext.Timer.WaitFor(2000, function()
            Osi.SetOnStage(HarperDruid6, 1)
            Osi.PlayEffect(HarperDruid6, "3c48f934-629d-0e94-4b6f-66f359cafb03", "", 2)
            Osi.SetOnStage(HarperDruidSkeleton6, 0)
            Osi.ApplyStatus(HarperDruid6, "MMM_SHADOWDRUIDSPEAK2", 1)
            Ext.Timer.WaitFor(1000, function()
                Osi.SetOnStage(HarperDruid4, 1)
                Osi.PlayEffect(HarperDruid4, "3c48f934-629d-0e94-4b6f-66f359cafb03", "", 2)
                Osi.SetOnStage(HarperDruidSkeleton4, 0)
                Osi.ApplyStatus(HarperDruid4, "MMM_SHADOWDRUIDSPEAK3", 1)
                Ext.Timer.WaitFor(4000, function()
                    Osi.SetOnStage(HarperDruid3, 1)
                    Osi.PlayEffect(HarperDruid3, "3c48f934-629d-0e94-4b6f-66f359cafb03", "", 2)
                    Osi.SetOnStage(HarperDruidSkeleton3, 0)
                    Ext.Timer.WaitFor(500, function()
                        Osi.SetOnStage(HarperDruid5, 1)
                        Osi.PlayEffect(HarperDruid5, "3c48f934-629d-0e94-4b6f-66f359cafb03", "", 2)
                        Osi.SetOnStage(HarperDruidSkeleton5, 0)
                        Ext.Timer.WaitFor(700, function()
                            Osi.SetOnStage(HarperDruid2, 1)
                            Osi.PlayEffect(HarperDruid2, "3c48f934-629d-0e94-4b6f-66f359cafb03", "", 2)
                            Osi.SetOnStage(HarperDruidSkeleton2, 0)
                            Ext.Timer.WaitFor(300, function()
                                Osi.SetOnStage(HarperDruid7, 1)
                                Osi.PlayEffect(HarperDruid7, "3c48f934-629d-0e94-4b6f-66f359cafb03", "", 2)
                                Osi.SetOnStage(HarperDruidSkeleton7, 0)
                            end)
                        end)
                    end)
                end)
            end)
        end)
    end)
end

--Meazels Ambush
local function MeazelsAmbush()
    Osi.SetOnStage(MeazelAmbush1, 1)
    Osi.PlayEffect(MeazelAmbush1, "3c48f934-629d-0e94-4b6f-66f359cafb03", "", 2)
    Ext.Timer.WaitFor(1500, function()
        Osi.SetOnStage(MeazelAmbush2, 1)
        Osi.PlayEffect(MeazelAmbush2, "3c48f934-629d-0e94-4b6f-66f359cafb03", "", 2)
        Ext.Timer.WaitFor(2000, function()
            Osi.SetOnStage(MeazelAmbush3, 1)
            Osi.PlayEffect(MeazelAmbush3, "3c48f934-629d-0e94-4b6f-66f359cafb03", "", 2)
            Ext.Timer.WaitFor(400, function()
                Osi.SetOnStage(MeazelAmbush4, 1)
                Osi.PlayEffect(MeazelAmbush4, "3c48f934-629d-0e94-4b6f-66f359cafb03", "", 2)
            end)
        end)
    end)
end

--First Balthazar Event
local function BalthazarEventTown()
    Ext.Timer.WaitFor(500, function()
        Osi.SetOnStage(BalthazarEvent1, 1)
        Osi.PlayEffect(BalthazarEvent1, "3c48f934-629d-0e94-4b6f-66f359cafb03", "", 4)
        Ext.Timer.WaitFor(3000, function()
            Osi.ApplyStatus(BalthazarEvent1, "MMM_BALTHAZARSPEAK1", 6, 1, BalthazarEvent1)
            Ext.Timer.WaitFor(4000, function()
                Osi.PlayEffectAtPosition("55015577-edce-13a7-bfc7-a71f41994b01", -19.632179260254, 27.7001953125, 217.4959564209, 1)
                Ext.Timer.WaitFor(900, function()
                    Osi.SetOnStage(BalthazarEvent1, 0)
                    Osi.RemoveStatus(GraveyardTorch1, "BURNING")
                    Osi.RemoveStatus(GraveyardTorch2, "BURNING")
                    Osi.RemoveStatus(GraveyardTorch3, "BURNING")
                    Osi.RemoveStatus(GraveyardTorch4, "BURNING")
                    Osi.RemoveStatus(GraveyardTorch5, "BURNING")
                    Osi.RemoveStatus(GraveyardTorch6, "BURNING")
                    Osi.RemoveStatus(GraveyardTorch7, "BURNING")
                    Ext.Timer.WaitFor(1500, function()
                        Osi.SetOnStage(BalthazarZombie1, 1)
                        Osi.PlayEffect(BalthazarZombie1, "0fd4132b-444c-a82d-d844-c4ee70706def", "", 4)
                        Ext.Timer.WaitFor(250, function()
                            Osi.SetOnStage(BalthazarZombie2, 1)
                            Osi.PlayEffect(BalthazarZombie2, "0fd4132b-444c-a82d-d844-c4ee70706def", "", 4)
                            Ext.Timer.WaitFor(300, function()
                                Osi.SetOnStage(BalthazarZombie3, 1)
                                Osi.PlayEffect(BalthazarZombie3, "0fd4132b-444c-a82d-d844-c4ee70706def", "", 4)
                                Ext.Timer.WaitFor(150, function()
                                    Osi.SetOnStage(BalthazarZombie4, 1)
                                    Osi.PlayEffect(BalthazarZombie4, "0fd4132b-444c-a82d-d844-c4ee70706def", "", 4)
                                    Ext.Timer.WaitFor(300, function()
                                        Osi.SetOnStage(BalthazarZombie5, 1)
                                        Osi.PlayEffect(BalthazarZombie5, "0fd4132b-444c-a82d-d844-c4ee70706def", "", 4)
                                    end)
                                end)
                            end)
                        end)
                    end)
                end)
            end)
        end)
    end)
end

local function ZombieSpeakSelector1()
    Ext.Timer.WaitFor(15000, function()
        if Osi.IsDead(BalthazarZombie1) == 0 then
            ZombieSpeakRoll1 = Ext.Utils.Random(1, 10)
            if ZombieSpeakRoll1 == 1 then
                ZombieSpeakSelector1()
            elseif ZombieSpeakRoll1 == 2 then
                Osi.ApplyStatus(BalthazarZombie1, "MMM_ZOMBIESPEAKTEXT1", 1)
                ZombieSpeakSelector1()
            elseif ZombieSpeakRoll1 == 3 then
                Osi.ApplyStatus(BalthazarZombie1, "MMM_ZOMBIESPEAKTEXT2", 1)
                ZombieSpeakSelector1()
            elseif ZombieSpeakRoll1 == 4 then
                Osi.ApplyStatus(BalthazarZombie1, "MMM_ZOMBIESPEAKTEXT3", 1)
                ZombieSpeakSelector1()
            elseif ZombieSpeakRoll1 == 5 then
                ZombieSpeakSelector1()
            elseif ZombieSpeakRoll1 == 6 then
                ZombieSpeakSelector1()
            elseif ZombieSpeakRoll1 == 7 then
                ZombieSpeakSelector1()
            elseif ZombieSpeakRoll1 == 8 then
                ZombieSpeakSelector1()
            elseif ZombieSpeakRoll1 == 9 then
                ZombieSpeakSelector1()
            elseif ZombieSpeakRoll1 == 10 then
                ZombieSpeakSelector1()
            end
        end
    end)
end

local function ZombieSpeakSelector2()
    Ext.Timer.WaitFor(14500, function()
        if Osi.IsDead(BalthazarZombie2) == 0 then
            ZombieSpeakRoll2 = Ext.Utils.Random(1, 10)
            if ZombieSpeakRoll2 == 1 then
                ZombieSpeakSelector2()
            elseif ZombieSpeakRoll2 == 2 then
                Osi.ApplyStatus(BalthazarZombie2, "MMM_ZOMBIESPEAKTEXT1", 1)
                ZombieSpeakSelector2()
            elseif ZombieSpeakRoll2 == 3 then
                Osi.ApplyStatus(BalthazarZombie2, "MMM_ZOMBIESPEAKTEXT2", 1)
                ZombieSpeakSelector2()
            elseif ZombieSpeakRoll2 == 4 then
                Osi.ApplyStatus(BalthazarZombie2, "MMM_ZOMBIESPEAKTEXT3", 1)
                ZombieSpeakSelector2()
            elseif ZombieSpeakRoll2 == 5 then
                ZombieSpeakSelector2()
            elseif ZombieSpeakRoll2 == 6 then
                ZombieSpeakSelector2()
            elseif ZombieSpeakRoll2 == 7 then
                ZombieSpeakSelector2()
            elseif ZombieSpeakRoll2 == 8 then
                ZombieSpeakSelector2()
            elseif ZombieSpeakRoll2 == 9 then
                ZombieSpeakSelector2()
            elseif ZombieSpeakRoll2 == 10 then
                ZombieSpeakSelector2()
            end
        end
    end)
end

local function ZombieSpeakSelector3()
    Ext.Timer.WaitFor(12200, function()
        if Osi.IsDead(BalthazarZombie3) == 0 then
            ZombieSpeakRoll3 = Ext.Utils.Random(1, 10)
            if ZombieSpeakRoll3 == 1 then
                ZombieSpeakSelector3()
            elseif ZombieSpeakRoll3 == 2 then
                Osi.ApplyStatus(BalthazarZombie3, "MMM_ZOMBIESPEAKTEXT1", 1)
                ZombieSpeakSelector3()
            elseif ZombieSpeakRoll3 == 3 then
                Osi.ApplyStatus(BalthazarZombie3, "MMM_ZOMBIESPEAKTEXT2", 1)
                ZombieSpeakSelector3()
            elseif ZombieSpeakRoll3 == 4 then
                Osi.ApplyStatus(BalthazarZombie3, "MMM_ZOMBIESPEAKTEXT3", 1)
                ZombieSpeakSelector3()
            elseif ZombieSpeakRoll3 == 5 then
                ZombieSpeakSelector3()
            elseif ZombieSpeakRoll3 == 6 then
                ZombieSpeakSelector3()
            elseif ZombieSpeakRoll3 == 7 then
                ZombieSpeakSelector3()
            elseif ZombieSpeakRoll3 == 8 then
                ZombieSpeakSelector3()
            elseif ZombieSpeakRoll3 == 9 then
                ZombieSpeakSelector3()
            elseif ZombieSpeakRoll3 == 10 then
                ZombieSpeakSelector3()
            end
        end
    end)
end

local function ZombieSpeakSelector4()
    Ext.Timer.WaitFor(10300, function()
        if Osi.IsDead(BalthazarZombie4) == 0 then
            ZombieSpeakRoll4 = Ext.Utils.Random(1, 10)
            if ZombieSpeakRoll4 == 1 then
                ZombieSpeakSelector4()
            elseif ZombieSpeakRoll4 == 2 then
                Osi.ApplyStatus(BalthazarZombie4, "MMM_ZOMBIESPEAKTEXT1", 1)
                ZombieSpeakSelector4()
            elseif ZombieSpeakRoll4 == 3 then
                Osi.ApplyStatus(BalthazarZombie4, "MMM_ZOMBIESPEAKTEXT2", 1)
                ZombieSpeakSelector4()
            elseif ZombieSpeakRoll4 == 4 then
                Osi.ApplyStatus(BalthazarZombie4, "MMM_ZOMBIESPEAKTEXT3", 1)
                ZombieSpeakSelector4()
            elseif ZombieSpeakRoll4 == 5 then
                ZombieSpeakSelector4()
            elseif ZombieSpeakRoll4 == 6 then
                ZombieSpeakSelector4()
            elseif ZombieSpeakRoll4 == 7 then
                ZombieSpeakSelector4()
            elseif ZombieSpeakRoll4 == 8 then
                ZombieSpeakSelector4()
            elseif ZombieSpeakRoll4 == 9 then
                ZombieSpeakSelector4()
            elseif ZombieSpeakRoll4 == 10 then
                ZombieSpeakSelector4()
            end
        end
    end)
end

local function ZombieSpeakSelector5()
    Ext.Timer.WaitFor(8800, function()
        if Osi.IsDead(BalthazarZombie5) == 0 then
            ZombieSpeakRoll5 = Ext.Utils.Random(1, 10)
            if ZombieSpeakRoll5 == 1 then
                ZombieSpeakSelector5()
            elseif ZombieSpeakRoll5 == 2 then
                Osi.ApplyStatus(BalthazarZombie5, "MMM_ZOMBIESPEAKTEXT1", 1)
                ZombieSpeakSelector5()
            elseif ZombieSpeakRoll5 == 3 then
                Osi.ApplyStatus(BalthazarZombie5, "MMM_ZOMBIESPEAKTEXT2", 1)
                ZombieSpeakSelector5()
            elseif ZombieSpeakRoll5 == 4 then
                Osi.ApplyStatus(BalthazarZombie5, "MMM_ZOMBIESPEAKTEXT3", 1)
                ZombieSpeakSelector5()
            elseif ZombieSpeakRoll5 == 5 then
                ZombieSpeakSelector5()
            elseif ZombieSpeakRoll5 == 6 then
                ZombieSpeakSelector5()
            elseif ZombieSpeakRoll5 == 7 then
                ZombieSpeakSelector5()
            elseif ZombieSpeakRoll5 == 8 then
                ZombieSpeakSelector5()
            elseif ZombieSpeakRoll5 == 9 then
                ZombieSpeakSelector5()
            elseif ZombieSpeakRoll5 == 10 then
                ZombieSpeakSelector5()
            end
        end
    end)
end

--Crazed Squirrels
local function CrazedSquirrelEvent()
    Ext.Timer.WaitFor(200, function()
        Osi.SetOnStage(CrazedSquirrel1, 1)
        Osi.SetOnStage(CrazedSquirrel10, 1)
        Ext.Timer.WaitFor(300, function()
            Osi.SetOnStage(CrazedSquirrel6, 1)
            Osi.SetOnStage(CrazedSquirrel11, 1)
            Ext.Timer.WaitFor(500, function()
                Osi.SetOnStage(CrazedSquirrel8, 1)
                Osi.SetOnStage(CrazedSquirrel15, 1)
                Ext.Timer.WaitFor(100, function()
                    Osi.SetOnStage(CrazedSquirrel4, 1)
                    Osi.SetOnStage(CrazedSquirrel13, 1)
                    Ext.Timer.WaitFor(400, function()
                        Osi.SetOnStage(CrazedSquirrel5, 1)
                        Osi.SetOnStage(CrazedSquirrel12, 1)
                        Osi.SetOnStage(CrazedSquirrel2, 1)
                        Ext.Timer.WaitFor(700, function()
                            Osi.SetOnStage(CrazedSquirrel3, 1)
                            Osi.SetOnStage(CrazedSquirrel9, 1)
                            Osi.SetOnStage(CrazedSquirrel7, 1)
                            Osi.SetOnStage(CrazedSquirrel14, 1)
                        end)
                    end)
                end)
            end)
        end)
    end)
end

--Child Wraith Event
local function ChildWraithEvent()
    Ext.Timer.WaitFor(1500, function()
        Osi.ApplyStatus(ChildWraithKid, "MMM_CHILDWRAITHSPEAK1", 6, 1, ChildWraithKid)
        Ext.Timer.WaitFor(2500, function()
            Osi.PlayEffectAtPosition("55015577-edce-13a7-bfc7-a71f41994b01", 140.89486694336, 55.865234375, 65.303916931152, 1)
            Ext.Timer.WaitFor(900, function()
                Osi.SetOnStage(ChildWraithKid, 0)
                Osi.SetOnStage(ChildWraithUndead, 1)
                Osi.PlaySound(ChildWraithUndead, "0f502371-ffb9-43e1-847b-b9dd6f511b34")
            end)
        end)
    end)
end

--Ring Event
local function ReturnRingEvent()
    Osi.RequestDelete(RobberWifeRing)
    Osi.PlayLoopEffect(EllieMay, "f9cb7d16-55b6-2ee4-8de6-0ca66c63b3c4", "", 1)
    Osi.PlayLoopEffect(EllieMay, "ada1f190-ea49-4d38-a89a-3d86ccbafae9", "", 1)
    Osi.SetOnStage(EllieMay, 1)
    Ext.Timer.WaitFor(2000, function()
        Osi.ApplyStatus(EllieMay, "MMM_ELLIEMAYSPEAK1", 6, 1, EllieMay)
        Ext.Timer.WaitFor(3000, function()
            Osi.SetHasDialog(EllieMay, 1)
            for i,v in ipairs(Ext.Entity.GetAllEntitiesWithComponent("ServerCharacter")) do
                Ext.Timer.WaitFor(100, function()
                    local EllieMayTextBox = v.Uuid.EntityUuid
                    if IsPlayer(EllieMayTextBox) == 1 then
                        Osi.OpenMessageBox(EllieMayTextBox, Osi.ResolveTranslatedString("ha6267b39ga602g434cg9db1g557da2a3e17b"))
                    end
                end)
            end
        end)
    end)
end

local function BalthazarEventMausoleum()
    Ext.Timer.WaitFor(500, function()
        Osi.SetOnStage(BalthazarEvent2, 1)
        Osi.PlayEffect(BalthazarEvent2, "3c48f934-629d-0e94-4b6f-66f359cafb03", "", 4)
        local SkeletonSpawnAura = Osi.PlayLoopEffectAtPosition("05e6b214-4477-644e-5c88-ac9a488bdc1e", -155.55741882324, 31.7490234375, 70.596000671387, 1)
        Ext.Timer.WaitFor(3000, function()
            Osi.ApplyStatus(BalthazarEvent2, "MMM_BALTHAZARSPEAK2", 6, 1, BalthazarEvent1)
            Ext.Timer.WaitFor(4000, function()
                Osi.PlayEffectAtPosition("55015577-edce-13a7-bfc7-a71f41994b01", -155.74822998047, 31.6103515625, 64.118644714355, 1)
                Ext.Timer.WaitFor(900, function()
                    Osi.SetOnStage(BalthazarEvent2, 0)
                    Ext.Timer.WaitFor(100, function()
                        Osi.SetOnStage(BalthazarSkeletonBoss, 1)
                        Osi.PlayEffect(BalthazarSkeletonBoss, "0fd4132b-444c-a82d-d844-c4ee70706def", "", 4)
                        Osi.CharacterMoveToPosition(BalthazarSkeletonBoss, -155.67816162109, 31.529359817505, 62.25838470459, "Walk", "", 0)
                        Ext.Timer.WaitFor(3000, function()
                            Osi.StopLoopEffect(SkeletonSpawnAura)
                            Osi.SetCanFight(BalthazarSkeletonBoss, 1)
                        end)
                    end)
                end)
            end)
        end)
    end)
end

--Pixie Talking
-- local function PixieTalking()
--     if Osi.IsOnStage(ThiefPixie) == 1 then
--         Osi.ApplyStatus(ThiefPixie, "MMM_THIEFPIXIESPEAK", 6, 1, "")
--         Ext.Timer.WaitFor(10000, function()
--             PixieTalking()
--         end)
--     elseif Osi.IsOnStage(ThiefPixie) == 0 then
--         return
--     end
-- end

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
    if (level_name ~= "SCL_Main_A") then
        return
    end
    if Osi.GetFlag(Act2MimicFlag, Null) == 0 then
        Osi.SetFlag(Act2MimicFlag, Null, 0, 1)
        CreateAct2Mimics()
    end
    if Osi.GetFlag(InitiateAct2, Null) == 0 then
        Osi.SetFlag(InitiateAct2, Null, 0, 1)
        InitiateMonstersShadowlands()
    end
    ModifyMonstersShadowlands()
    ToiletGuyTrigger()
    -- PixieTalking()
end)

--Enter Combat Listener
Ext.Osiris.RegisterListener("EnteredCombat", 2, "after", function (object, combatGuid)
    if object == BalthazarZombie1 then
        local BaltZombieFightID = combatGuid
        ZombieSpeakSelector1()
        ZombieSpeakSelector2()
        ZombieSpeakSelector3()
        ZombieSpeakSelector4()
        ZombieSpeakSelector5()
    end
end)

--Turn started listener
Ext.Osiris.RegisterListener("TurnStarted", 1, "before", function(object)
    if object == SpiderKing and Osi.IsInCombat(SpiderKing) == 1 and Osi.GetFlag(Act2SpiderKingWave1Flag, Null) == 0 then
        Osi.SetFlag(Act2SpiderKingWave1Flag, Null, 0, 1)
        Osi.ApplyStatus(SpiderKing, "MMM_MORESPIDERS", 1)
        local SpiderKingSpawnMidCombat1 = Osi.CreateAt(SpiderKingSummon, 304.29098510742, 0.0283203125, -705.29028320312, 0, 1, "")
        local SpiderKingSpawnMidCombat2 = Osi.CreateAt(SpiderKingSummon, 311.21820068359, 0.1220703125, -706.70056152344, 0, 1, "")
        local SpiderKingSpawnMidCombat3 = Osi.CreateAt(SpiderKingSummon, 320.95999145508, 1.70703125, -703.29797363281, 0, 1, "")
        local SpiderKingSpawnMidCombat4 = Osi.CreateAt(SpiderKingSummon, 319.86599731445, 0.3916015625, -713.99682617188, 0, 1, "")
    elseif object == SpiderKing and Osi.IsInCombat(SpiderKing) == 1 and Osi.GetFlag(Act2SpiderKingWave1Flag, Null) == 1 and Osi.GetFlag(Act2SpiderKingWave2Flag, Null) == 0 then
        Osi.SetFlag(Act2SpiderKingWave2Flag, Null, 0, 1)
        Osi.ApplyStatus(SpiderKing, "MMM_EVENMORESPIDERS", 1)
        local SpiderKingSpawnMidCombat1 = Osi.CreateAt(SpiderKingSummon, 304.29098510742, 0.0283203125, -705.29028320312, 0, 1, "")
        local SpiderKingSpawnMidCombat2 = Osi.CreateAt(SpiderKingSummon, 311.21820068359, 0.1220703125, -706.70056152344, 0, 1, "")
        local SpiderKingSpawnMidCombat3 = Osi.CreateAt(SpiderKingSummon, 320.95999145508, 1.70703125, -703.29797363281, 0, 1, "")
        local SpiderKingSpawnMidCombat4 = Osi.CreateAt(SpiderKingSummon, 319.86599731445, 0.3916015625, -713.99682617188, 0, 1, "")
    elseif object == SpiderKing and Osi.IsInCombat(SpiderKing) == 1 and Osi.GetFlag(Act2SpiderKingWave1Flag, Null) == 1 and Osi.GetFlag(Act2SpiderKingWave2Flag, Null) == 1 then
        local SpiderKingSpawnMidCombat1 = Osi.CreateAt(SpiderKingSummon, 304.29098510742, 0.0283203125, -705.29028320312, 0, 1, "")
        local SpiderKingSpawnMidCombat2 = Osi.CreateAt(SpiderKingSummon, 311.21820068359, 0.1220703125, -706.70056152344, 0, 1, "")
        --local SpiderKingSpawnMidCombat3 = Osi.CreateAt(SpiderKingSummon, 320.95999145508, 1.70703125, -703.29797363281, 0, 1, "")
        --local SpiderKingSpawnMidCombat4 = Osi.CreateAt(SpiderKingSummon, 319.86599731445, 0.3916015625, -713.99682617188, 0, 1, "")
    end
    if object == SpiderKing and Osi.IsDead(SpiderKing) == 0 and Osi.GetHitpoints(SpiderKing) <= 100 then
        Osi.Die("MMM_SPIDERKING_0683b560-c29e-4a0b-b15f-f02703d3e219", 5, Null, 0, 1, 500)
        local x,y,z = Osi.GetPosition(SpiderKing)
        local ChestbursterSpawnID = Osi.CreateAt(SpiderKingChestburster, x, y, z, 0, 1, '')
    end
end)

--Osi.AttackedBy
Ext.Osiris.RegisterListener("AttackedBy", 7, "after", function(defender, attackerOwner, attacker2, damageType, damageAmount, damageCause, storyActionID)
    if defender == BalthazarEvent1 then
        Osi.UseSpell(BalthazarEvent1, "CURSE_SKIP_TURN", attackerOwner)
    end
end)

--Death listener
Ext.Osiris.RegisterListener("Died", 1, "after", function(character)
    --Team Trajectile
    if character == Adam2 then
        Osi.SetFlag(Act2AdamFlag, Null, 0, 1)
        Osi.SetCanFight(Adam2, 0)
        Osi.Resurrect(Adam2, "", 0)
        Osi.AddBoosts(Adam2, "Invulnerable", "", Adam2)
        Ext.Timer.WaitFor(2000, function()
            Osi.CharacterMoveToPosition(Adam2, -279.90866088867, -31.235313415527, -888.38409423828, "Sprint", "", 0)
            Osi.ApplyStatus(Adam2, "MMM_ADAMRUNAWAY1", 6, 1, "")
            Ext.Timer.WaitFor(2500, function()
                Osi.CharacterMoveToPosition(Adam2, -279.90866088867, -31.235313415527, -888.38409423828, "Sprint", "", 0)
                Ext.Timer.WaitFor(4000, function()
                    Osi.PlayEffect(Adam2, "1b923cb2-133a-25bd-6cbf-f808ca1cb8d2", "", 1)
                    Ext.Timer.WaitFor(500, function()
                        Osi.SetOnStage(Adam2, 0)
                    end)
                end)
            end)
        end)
    end
    if character == Liam2 then
        Osi.SetFlag(Act2LiamFlag, Null, 0, 1)
        Osi.SetCanFight(Liam2, 0)
        Osi.Resurrect(Liam2, "", 0)
        Osi.AddBoosts(Liam2, "Invulnerable", "", Liam2)
        Ext.Timer.WaitFor(2000, function()
            Osi.CharacterMoveToPosition(Liam2, -279.90866088867, -31.235313415527, -888.38409423828, "Sprint", "", 0)
            Osi.ApplyStatus(Liam2, "MMM_LIAMRUNAWAY1", 6, 1, "")
            Ext.Timer.WaitFor(2500, function()
                Osi.CharacterMoveToPosition(Liam2, -279.90866088867, -31.235313415527, -888.38409423828, "Sprint", "", 0)
                Ext.Timer.WaitFor(4000, function()
                    Osi.PlayEffect(Liam2, "1b923cb2-133a-25bd-6cbf-f808ca1cb8d2", "", 1)
                    Ext.Timer.WaitFor(500, function()
                        Osi.SetOnStage(Liam2, 0)
                    end)
                end)
            end)
        end)
    end
    if character == Mike2 then
        Osi.SetFlag(Act2MikeFlag, Null, 0, 1)
        Osi.SetCanFight(Mike2, 0)
        Osi.Resurrect(Mike2, "", 0)
        Osi.AddBoosts(Mike2, "Invulnerable", "", Mike2)
        Ext.Timer.WaitFor(2000, function()
            Osi.CharacterMoveToPosition(Mike2, -279.90866088867, -31.235313415527, -888.38409423828, "Sprint", "", 0)
            Osi.ApplyStatus(Mike2, "MMM_MIKERUNAWAY1", 6, 1, "")
            Ext.Timer.WaitFor(2500, function()
                Osi.CharacterMoveToPosition(Mike2, -279.90866088867, -31.235313415527, -888.38409423828, "Sprint", "", 0)
                Ext.Timer.WaitFor(4000, function()
                    Osi.PlayEffect(Mike2, "1b923cb2-133a-25bd-6cbf-f808ca1cb8d2", "", 1)
                    Ext.Timer.WaitFor(500, function()
                        Osi.SetOnStage(Mike2, 0)
                    end)
                end)
            end)
        end)
    end
end)

--End Combat Listener
Ext.Osiris.RegisterListener("CombatEnded", 1, "after", function(combatGuid)
    if combatGuid == BaltZombieFightID then
        Osi.ApplyStatus(GraveyardTorch1, "BURNING", -1)
        Osi.ApplyStatus(GraveyardTorch2, "BURNING", -1)
        Osi.ApplyStatus(GraveyardTorch3, "BURNING", -1)
        Osi.ApplyStatus(GraveyardTorch4, "BURNING", -1)
        Osi.ApplyStatus(GraveyardTorch5, "BURNING", -1)
        Osi.ApplyStatus(GraveyardTorch6, "BURNING", -1)
        Osi.ApplyStatus(GraveyardTorch7, "BURNING", -1)
    end
end)

--Open item listener
Ext.Osiris.RegisterListener("Opened", 1, "before", function(item)
end)

--Use item listener
Ext.Osiris.RegisterListener("UseStarted", 2, "after", function(character, item)
    if item == ShadowToiletDoor then
        Ext.Timer.WaitFor(2000, function()
            Osi.SetHostileAndEnterCombat(FShadowCreature, FPlayer, ShadowToiletGuy, character)
        end)
    end
    if item == SquirrelChest and
    Osi.IsOnStage(CrazedSquirrel1) == 0 then
        CrazedSquirrelEvent()
    end
    if Osi.HasActiveStatus(item, "MMM_MIMIC2") == 1 then
        TurnIntoMimic2(item, character)
    end
end)

--Dialog Start Request listener
Ext.Osiris.RegisterListener("DialogStartRequested", 2, "after", function(target, player)
    if target == EllieMay then
        Osi.ApplyStatus(player, "MMM_ELLIEMAYBLESSING", -1)
        Osi.SetOnStage(EllieMay, 0)
    end
end)

--Destroy object listener
Ext.Osiris.RegisterListener("DestroyedBy", 4, "before", function(item, destroyer, destroyerOwner, storyActionID)
    if item == SquirrelChest and
    Osi.IsOnStage(CrazedSquirrel1) == 0 then
        CrazedSquirrelEvent()
    end
    if Osi.HasActiveStatus(item, "MMM_MIMIC2") == 1 then
        TurnIntoMimic2(item, character)
    end
end)

--Added To listener
Ext.Osiris.RegisterListener("AddedTo", 3, "after", function(object, inventoryHolder, addType)
    if object == RobberWifeRing and inventoryHolder == RobberWifeGrave then
        ReturnRingEvent()
    end
end)

--Saw something listener
Ext.Osiris.RegisterListener("Saw", 3, "after", function(character, targetcharacter, targetwassneaking)
    if character == ChildWraithKid and
    Osi.IsTagged(targetcharacter, "25bf5042-5bf6-4360-8df8-ab107ccb0d37") == 1 and
    Osi.GetFlag(Act2ChildWraithFlag, Null) == 0 then
        Osi.SetFlag(Act2ChildWraithFlag, Null, 0, 1)
        ChildWraithEvent()
        local CWEntity = Ext.Entity.Get(ChildWraithKid)
        local CWpos = CWEntity.Transform.Transform.Translate
        for _, entity in ipairs(Ext.Entity.GetAllEntitiesWithComponent("BaseHp")) do
            Playeruuid = entity.Uuid.EntityUuid
            if IsPlayer(Playeruuid) == 1 then
                local CWtarget = entity.Transform.Transform.Translate
                local distance = math.sqrt((CWpos[1] - CWtarget[1])^2 + (CWpos[2] - CWtarget[2])^2 + (CWpos[3] - CWtarget[3])^2)
                if distance <= 30 then
                    Osi.RequestPassiveRoll(Playeruuid, ChildWraithKid, "", "Arcana", "Act1_Challenging_5e7ff0e9-6c80-459c-a636-3a3e8417a61a", 0, "ChildWrathRoll")
                end
            end
        end
    end
    if character == BalthazerTrigger2 and
    Osi.IsTagged(targetcharacter, "25bf5042-5bf6-4360-8df8-ab107ccb0d37") == 1 then
        BalthazarEventMausoleum()
        Osi.SetOnStage(BalthazerTrigger2, 0)
    end
end)

--Status Applied listener
Ext.Osiris.RegisterListener("StatusApplied", 4, "before", function(object, status, cause, storyActionID)
    --Druid Trigger 1
    if status == "MMM_DRUIDSMARCH1" then
        Osi.SetOnStage(HarperDruidTrigger1, 0)
        RaiseDruids()
    end
    if status == "MMM_MEAZELSMARCH1" then
        Osi.SetOnStage(MeazelAmbushTrigger, 0)
        MeazelsAmbush()
    end
    if status == "MMM_BALTHAZARMARCH1" then
        Osi.SetOnStage(BalthazerTrigger1, 0)
        BalthazarEventTown()
    end
    if status == "MMM_THIEFTRIOPIXIEATTACK" and
    Osi.IsTagged(object, "25bf5042-5bf6-4360-8df8-ab107ccb0d37") == 1 then
        Osi.ApplyStatus(ThiefPixie, "MMM_THIEFPIXIESPEAK2", 6, 1, ThiefPixie)
        Ext.Timer.WaitFor(3000, function()
            Osi.PlayEffect(ThiefPixie, "1b923cb2-133a-25bd-6cbf-f808ca1cb8d2", "", 1)
            Ext.Timer.WaitFor(500, function()
                Osi.SetOnStage(ThiefPixie, 0)
            end)
        end)
    end
end)

--Roll listener
Ext.Osiris.RegisterListener("RollResult", 6, "after", function(eventName, roller, rollsubject, resultType, isActiveRoll, criticality)
    if eventName == ChildWrathRoll then
        if resultType == 1 then
            ShowNotification(roller, "You sense evil magic at work in the child.")
            PrepareDuration = 12
            PreparedBoost()
        elseif resultType == 2 then
            return
        end
    end
end)

--Flag listener
Ext.Osiris.RegisterListener("FlagSet", 3, "after", function(flag, speaker, dialogInstance)
end)

--Event listener
Ext.Osiris.RegisterListener("EntityEvent", 2, "before", function(object, event)
end)
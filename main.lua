mod = RegisterMod("Deliverance", 1)
game = Game()
sfx = SFXManager()
vectorZero = Vector(0,0)
delivRNG = RNG()

deliveranceVersion = "2.5.6"

utils = include ('scripts.utils')
include ('scripts.enumerations')

-- Mod data --
deliveranceData = {
  -- Remains even after restart --
  persistent = {

  },

  -- Being cleared after restart --
  temporary = {

  }
}

-- Register mod content here --
deliveranceContent = {
  items = {
    cainsKey                  = include('scripts.items.cainsKey'),
    arterialHeart             = include('scripts.items.familiars.arterialHeart'),
    specialDelivery           = include('scripts.items.specialDelivery'),
    capBrooch                 = include('scripts.items.captainsBrooch'),
    theApple                  = include('scripts.items.theApple'),
    lighter                   = include('scripts.items.lighter'),
    shrinkRay                 = include('scripts.items.shrinkRay'),
    sailorHat                 = include('scripts.items.sailorHat'),
    dheart                    = include('scripts.items.dheart'),
    saltySoup                 = include('scripts.items.saltySoup'),
    gasoline                  = include('scripts.items.gasoline'),
    luckySaucer               = include('scripts.items.luckySaucer'),
    bloodyStream              = include('scripts.items.bloodyStream'),
    theCovenant               = include('scripts.items.theCovenant'),
    adamsRib                  = include('scripts.items.adamsRib'),
    goodOldFriend             = include('scripts.items.goodOldFriend'),
    hotMilk                   = include('scripts.items.hotMilk'),
    battleRoyale              = include('scripts.items.battleRoyale'),
    sage                      = include('scripts.items.familiars.sage'),
    rottenPorkChop            = include('scripts.items.rottenPorkChop'),
    lilTummy                  = include('scripts.items.familiars.lilTummy'),
    scaredyShroom             = include('scripts.items.familiars.scaredyShroom'),
    drMedicine                = include('scripts.items.drMedicine'),
    manuscript                = include('scripts.items.manuscript'),
    roundBattery              = include('scripts.items.familiars.roundBattery'),
    airStrike                 = include('scripts.items.airStrike'),
    lawful                    = include('scripts.items.lawful'),
    bileKnight                = include('scripts.items.familiars.bileKnight'),
    dangerRoom                = include('scripts.items.dangerRoom'),
    theThreater               = include('scripts.items.familiars.theThreater'),
    beanborne                 = include('scripts.items.familiars.beanborne'),
    theDivider                = include('scripts.items.theDivider'),
    sinisterChalk             = include('scripts.items.sinisterChalk'),
    momsEarrings              = include('scripts.items.momsEarrings'),
    timeGal                   = include('scripts.items.timeGal'),
    silverBar                 = include('scripts.items.silverBar'),
    urnOfWant                 = include('scripts.items.urnOfWant'),
    encharmedPenny            = include('scripts.items.encharmedPenny'),
    obituary                  = include('scripts.items.obituary'),
    shamrockLeaf              = include('scripts.items.shamrockLeaf'),
	mysteryBag                = include('scripts.items.mysteryBag'),
	glassCrown                = include('scripts.items.glassCrown'),
    corrosiveBombs            = include('scripts.items.corrosiveBombs'),
	yumRib                    = include('scripts.items.yumrib')
  },
  
  trinkets = {
    uncertainty               = include('scripts.trinkets.uncertainty'),
    appleCore                 = include('scripts.trinkets.appleCore'),
    krampusHorn               = include('scripts.trinkets.krampusHorn'),
    discountBrochure          = include('scripts.trinkets.discountBrochure'),
    darkLock                  = include('scripts.trinkets.darkLock'),
    specialPenny              = include('scripts.trinkets.specialPenny'),
    littleTransducer          = include('scripts.trinkets.littleTransducer'),
    extinguisher              = include('scripts.trinkets.extinguisher')
  },

  cards = {
    farewellStone             = include('scripts.cards.farewellStone'),
    firestorms                = include('scripts.cards.firestorms'),
    glitch                    = include('scripts.cards.glitch'),
    abyss                     = include('scripts.cards.abyss'),
  },

  pills = {
    dissReaction              = include('scripts.pills.dissReaction')
  },

  entityVariants = {
    dukie                     = include('scripts.entities.monsters.variants.dukie'),
    greenLevel2Fly            = include('scripts.entities.monsters.variants.greenLevel2Fly'),
    greenLevel2Spider         = include('scripts.entities.monsters.variants.greenLevel2Spider'),
    momOfMany                 = include('scripts.entities.monsters.variants.momOfMany')
  },

  pickups = {
    rainbowHeart              = include('scripts.pickups.rainbowHeart'),
  },
  
  entities = {
    persistent = {
      chestBoy                = include('scripts.entities.chestBoy'),
    },

    raga                      = include('scripts.entities.monsters.raga'),
    nutcracker                = include('scripts.entities.monsters.nutcracker'),
    jester                    = include('scripts.entities.monsters.jester'),
    joker                     = include('scripts.entities.monsters.joker'),
    beamo                     = include('scripts.entities.monsters.beamo'),
    cracker                   = include('scripts.entities.monsters.cracker'),
    peabody                   = include('scripts.entities.monsters.peabody'),
    rosenberg                 = include('scripts.entities.monsters.rosenberg'),
    shroomeo                  = include('scripts.entities.monsters.shroomeo'),
    tinhorn                   = include('scripts.entities.monsters.tinhorn'),
    musk                      = include('scripts.entities.monsters.musk'),
    gelatino                  = include('scripts.entities.monsters.gelatino'),
    fathost                   = include('scripts.entities.monsters.fathost'),
    cadaver                   = include('scripts.entities.monsters.cadaver'),
    eddie                     = include('scripts.entities.monsters.eddie'),
    explosimaw                = include('scripts.entities.monsters.explosimaw'),
    seraphim                  = include('scripts.entities.monsters.seraphim'),
    fistubomb                 = include('scripts.entities.monsters.fistubomb'),
    fistulauncher             = include('scripts.entities.monsters.fistulauncher'),
    lilbonydies               = include('scripts.entities.monsters.lilbonydies'),
    --rosenbergspit             = include('scripts.entities.monsters.rosenbergspit'),
    creampile                 = include('scripts.entities.monsters.creampile'),
    gappy                     = include('scripts.entities.monsters.gappy'),
    reaper                    = include('scripts.entities.monsters.reaper'),
    stonelet                  = include('scripts.entities.monsters.stonelet'),
    grilly                    = include('scripts.entities.monsters.grilly'),
    bloodmind                 = include('scripts.entities.monsters.bloodmind'),
    bloodmindspit             = include('scripts.entities.monsters.bloodmindspit'),
    --slider                    = include('scripts.entities.monsters.slider')
  },
}

deliveranceDataHandler = include('scripts.deliveranceDataHandler')
deliveranceDataHandler.init()

npcPersistence = include('scripts.npcPersistenceHandler')
npcPersistence.init(deliveranceContent.entities.persistent)

cardHandler = include('scripts.cardHandler')
cardHandler.init(deliveranceContent.cards)

-- Content Initialization --
local eid = include('scripts.eidHandler')
--local coh = include('scripts.customOverHandler')
--local dss = include('scripts.deadseascrolls') for confings
--local logs = include('scripts.changelogs') and logs
--pd = include('scripts.progressdata') unlockables
--local encyclopedia = include('scripts.encyclopedia') descriptions support are crap
eid.init()

for type, r in pairs(deliveranceContent) do
  if r.noAutoload == nil then
    for name, class in pairs(r) do
      --Isaac.DebugString("tBoI Deliverance: Loading " .. k .. " " .. q .. "...")
      eid.tryAddDescription(type, class)
      if class.Init then
        class.Init()
      end
    end
  end
end

print("Deliverance Repentance v"..deliveranceVersion..": Successfully initialized! Have a nice run :)")
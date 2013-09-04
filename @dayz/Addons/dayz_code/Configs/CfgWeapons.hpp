class CfgWeapons {
	class Default {
		canlock = 0;
	};
	class ItemCore;
	class Crossbow;
	class Rifle;
	class MeleeWeapon : Rifle {
		canDrop = true;
	};
	class PistolCore;	// External class reference
	class Pistol;	// External class reference
	class GrenadeLauncher;  // External class reference
	//class M107_DZ;	// External class reference
	//class BAF_AS50_scoped;	// External class reference
	class DMR;	// External class reference
		
	#include "CfgWeapons\Melee\MeleeMachete.hpp"
	#include "CfgWeapons\Melee\ItemMachete.hpp"
	#include "CfgWeapons\Melee\MeleeHatchet.hpp"
	#include "CfgWeapons\Melee\ItemHatchet.hpp"
	#include "CfgWeapons\Melee\MeleeCrowbar.hpp"
	#include "CfgWeapons\Melee\ItemCrowbar.hpp"
	#include "CfgWeapons\Melee\Crossbow.hpp"
	#include "CfgWeapons\Melee\MeleeBaseBallBat.hpp"
//	#include "CfgWeapons\Melee\MeleeBaseBallBatBarbed.hpp"
//	#include "CfgWeapons\Melee\MeleeBaseBallBatNails.hpp"
	
	#include "CfgWeapons\Item\ItemWatch.hpp"
	#include "CfgWeapons\Item\ItemMap.hpp"
	#include "CfgWeapons\Item\ItemMap_Debug.hpp"
	#include "CfgWeapons\Item\ItemCompass.hpp"
	#include "CfgWeapons\Item\Flashlight.hpp"
	#include "CfgWeapons\Item\Flare.hpp"
	#include "CfgWeapons\Item\ItemEtool.hpp"
	#include "CfgWeapons\Item\ItemShovel.hpp"
	
	//Sniper Rifel
	//#include "CfgWeapons\Weapon\Sniper\AS50.hpp"
	#include "CfgWeapons\Weapon\Sniper\M107.hpp"
	
	#include "CfgWeapons\Weapon\Sniper\DMR_DZ.hpp"
//	#include "CfgWeapons\Weapon\Sniper\DMR_DZ2.hpp"
//	#include "CfgWeapons\Weapon\Sniper\DMR_DZ3.hpp"
	
	//crafting
	#include "CfgCrafting\CfgCrafting.hpp"
	

};
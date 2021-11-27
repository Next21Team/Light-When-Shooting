#include <amxmodx>
#include <fakemeta>
#include <hamsandwich>

#define PLUGIN "Light when shooting"
#define VERSION "0.1"
#define AUTHOR "Chrescoe1"

const LightRadius = 20
const LightR = 255
const LightG = 155
const LightB = 55
const LightLife =  8
const LightDecay = 60

new const WeaponNames[][]=
{
	"weapon_usp",
	"weapon_glock18",
	"weapon_p228",
	"weapon_deagle",
	"weapon_fiveseven",
	"weapon_elite",
	
	"weapon_xm1014",
	"weapon_m3",
	
	"weapon_tmp",
	"weapon_mac10",
	"weapon_ump45",
	"weapon_p90" ,
	"weapon_galil",
	"weapon_famas",
	"weapon_mp5navy",
	"weapon_ak47",
	"weapon_m4a1",
	"weapon_aug",
	"weapon_sg550",
	
	"weapon_awp",
	"weapon_scout",
	"weapon_g3sg1",
	"weapon_sg552",

	"weapon_m249"
}
public plugin_init()
{
	register_plugin(PLUGIN, VERSION, AUTHOR)
	
	for (new i=0;i<sizeof(WeaponNames);i++)
		RegisterHam(Ham_Weapon_PrimaryAttack,WeaponNames[i],"Ham_Weapon_PrimaryAttack_Post",1)
}
public Ham_Weapon_PrimaryAttack_Post(ent)
{
	if(get_pdata_int(ent, 51, 5)<=0)return		//if ammo is out
	if(get_pdata_float(ent, 46, 5)<0.0)return	//if attack blocked
	
	new Float:Origin[3]
	pev(pev(ent,pev_owner),pev_origin,Origin)
	message_begin(MSG_BROADCAST, SVC_TEMPENTITY)
	write_byte (TE_DLIGHT);
	engfunc(EngFunc_WriteCoord, Origin[0])
	engfunc(EngFunc_WriteCoord, Origin[1])
	engfunc(EngFunc_WriteCoord, Origin[2])
	write_byte (GetWeaponSilen (ent)?floatround (LightRadius * 0.5) : LightRadius)
	write_byte (LightR)
	write_byte (LightG)
	write_byte (LightB)
	write_byte (LightLife)
	write_byte (LightDecay)
	message_end ()
}
GetWeaponSilen (const WeaponEnt)
{
	switch (get_pdata_int (WeaponEnt, 43, 4))
	{
		case CSW_M4A1 : return (get_pdata_int (WeaponEnt, 74, 4 ) & ( 1<<2 ));
		case CSW_USP : return (get_pdata_int (WeaponEnt, 74, 4 ) & ( 1<<0 ));
		case CSW_TMP : return 1;
	}
	return 0;
}

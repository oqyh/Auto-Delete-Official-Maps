#include <sourcemod>

#pragma newdecls required

#define CSGO_MAP_COUNT 101

char csgoMapName[CSGO_MAP_COUNT][] = {
"ar_baggage",
"ar_dizzy",
"ar_lunacy",
"ar_monastery",
"ar_shoots",
"coop_kasbah",
"cs_agency",
"cs_assault",
"cs_downtown",
"cs_insertion",
"cs_italy",
"cs_militia",
"cs_motel",
"cs_office",
"cs_rush",
"cs_siege",
"cs_thunder",
"de_ali",
"de_aztec",
"de_bank",
"de_blackgold",
"de_breach",
"de_cache",
"de_canals",
"de_cbble",
"de_chinatown",
"de_dust",
"de_dust2",
"de_favela",
"de_gwalior",
"de_inferno",
"de_lake",
"de_mirage",
"de_mist",
"de_nuke",
"de_overgrown",
"de_overpass",
"de_ruins",
"de_safehouse",
"de_seaside",
"de_shortdust",
"de_shortnuke",
"de_shorttrain",
"de_stmarc",
"de_studio",
"de_sugarcane",
"de_train",
"de_vertigo",
"dz_blacksite",
"dz_junglety",
"dz_sirocco",
"gd_cbble",
"gd_rialto",
"training1",
"de_prime",
"dz_vineyard",
"dz_ember",
"de_tuscan",
"de_ancient",
"de_anubis",
"de_blagai",
"lobby_mapveto",
"ar_baggage_story",
"ar_shoots_story",
"cs_agency",
"cs_agency_cameras",
"cs_assault_cameras",
"cs_italy_cameras",
"cs_italy_story",
"cs_militia_cameras",
"cs_office_cameras",
"cs_office_story",
"de_ancient_retake",
"de_anubis",
"de_blagai",
"de_breach",
"de_cache",
"de_cache_cameras",
"de_cbble_cameras",
"de_dust2_cameras",
"de_dust2_retake",
"de_dust2_story",
"de_inferno_cameras",
"de_inferno_retake",
"de_inferno_story",
"de_mirage_cameras",
"de_mirage_retake",
"de_nuke_cameras",
"de_nuke_retake",
"de_nuke_story",
"de_overpass_cameras",
"de_overpass_retake",
"de_prime",
"de_train_cameras",
"de_train_retake",
"de_tuscan",
"de_vertigo_cameras",
"de_vertigo_retake",
"dz_blacksite_cameras",
"dz_ember",
"dz_vineyard"
};

ConVar g_DeleteMap[CSGO_MAP_COUNT];

public Plugin myinfo = 
{
	name = "Auto Delete Official Maps",
	author = "Gold KingZ, spirt",
	description = "Deletes Official CSGO Maps If You Use Custom Maps",
	version = "1.0.0",
	url = "https://github.com/oqyh"
};

public void OnPluginStart()
{	
	for (int i = 0; i < CSGO_MAP_COUNT; i++)
	{
		char cvarName[32];
		Format(cvarName, sizeof(cvarName), "sm_delete_%s", csgoMapName[i]);
		
		char cvarDesc[64];
		Format(cvarDesc, sizeof(cvarDesc), "Deletes all %s files", csgoMapName[i]);
		
		g_DeleteMap[i] = CreateConVar(cvarName, "1", cvarDesc, _, true, 0.0, true, 1.0);
	}
	
	AutoExecConfig(true, "AutoDeleteOfficialMaps");
}

public void OnMapStart()
{
	DeleteAllMaps();
	return;
}

void DeleteAllMaps()
{
	char fileExt[4][] = {
		"bsp",
		"nav",
		"txt",
		"jpg"
	};
		
	for (int i = 0; i < CSGO_MAP_COUNT; i++)
	{		
		if (g_DeleteMap[i].BoolValue)
		{		
			for (int f = 0; f < 4; f++)
			{
				char fileName[32];
				Format(fileName, sizeof(fileName), "maps/%s.%s", csgoMapName[i], fileExt[f]);
				
				if (FileExists(fileName))
					DeleteFile(fileName);
			}
		}
	}
}
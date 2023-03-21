#pragma semicolon 1
#pragma newdecls required

#include <sourcemod>

#define PLUGIN_VERSION	"1.0.1"

#define MAP_COUNT_AR 7
#define MAP_COUNT_CS 12
#define MAP_COUNT_DE 43
#define MAP_COUNT_DZ 5
#define MAP_COUNT_GD 1
#define MAP_COUNT_LOBBY 1
#define MAP_COUNT_TRAINING 1

ConVar h_enable_plugin;
ConVar h_ar_map;
ConVar h_cs_map;
ConVar h_de_map;
ConVar h_dz_map;
ConVar h_gd_map;
ConVar h_lobby_map;
ConVar h_training_map;

bool bh_enable_plugin = false;
bool bh_ar_map = false;
bool bh_cs_map = false;
bool bh_de_map = false;
bool bh_dz_map = false;
bool bh_gd_map = false;
bool bh_lobby_map = false;
bool bh_training_map = false;


char csgoMapar[MAP_COUNT_AR][] = {
"ar_monastery",
"ar_shoots",
"ar_shoots_story",
"ar_baggage",
"ar_baggage_story",
"ar_dizzy",
"ar_lunacy"
};

char csgoMapcs[MAP_COUNT_CS][] = {
"cs_office_cameras",
"cs_office_story",
"cs_agency",
"cs_agency_cameras",
"cs_assault",
"cs_assault_cameras",
"cs_italy",
"cs_italy_cameras",
"cs_italy_story",
"cs_militia",
"cs_militia_cameras",
"cs_office"
};

char csgoMapde[MAP_COUNT_DE][] = {
"de_vertigo_cameras",
"de_vertigo_retake",
"de_ancient",
"de_ancient_retake",
"de_anubis",
"de_bank",
"de_boyard",
"de_cache",
"de_cache_cameras",
"de_canals",
"de_cbble",
"de_cbble_cameras",
"de_chalice",
"de_dust",
"de_dust2",
"de_dust2_cameras",
"de_dust2_retake",
"de_dust2_story",
"de_inferno",
"de_inferno_cameras",
"de_inferno_retake",
"de_inferno_story",
"de_lake",
"de_mirage",
"de_mirage_cameras",
"de_mirage_retake",
"de_nuke",
"de_nuke_cameras",
"de_nuke_retake",
"de_nuke_story",
"de_overpass",
"de_overpass_cameras",
"de_overpass_retake",
"de_safehouse",
"de_shortdust",
"de_shortnuke",
"de_stmarc",
"de_sugarcane",
"de_train",
"de_train_cameras",
"de_train_retake",
"de_tuscan",
"de_vertigo"
};

char csgoMapdz[MAP_COUNT_DZ][] = {
"dz_vineyard",
"dz_blacksite",
"dz_blacksite_cameras",
"dz_ember",
"dz_sirocco"
};

char csgoMapgd[MAP_COUNT_GD][] = {
"gd_cbble"
};

char csgoMaplobby[MAP_COUNT_LOBBY][] = {
"lobby_mapveto"
};

char csgoMaptraining[MAP_COUNT_TRAINING][] = {
"training1"
};

public Plugin myinfo =
{
	name = "[CSGO] Auto Delete Official Maps", 
	author = "Gold KingZ", 
	description = "Deletes Official CSGO Maps", 
	version = PLUGIN_VERSION,
	url = "https://github.com/oqyh"
}

public void OnPluginStart()
{
	CreateConVar("dl_map_version", PLUGIN_VERSION, "[CSGO] Auto Delete Official Maps Plugin Version", FCVAR_NOTIFY|FCVAR_DONTRECORD);
	
	h_enable_plugin =  CreateConVar("dl_map_enable", "1", "Enable Auto Delete Official Maps Plugin\n1= Yes\n0= No", _, true, 0.0, true, 1.0);
	
	h_ar_map =  CreateConVar("dl_map_ar", "1", "Delete Maps Start With [ar_]\n1= Yes\n0= No", _, true, 0.0, true, 1.0);
	
	h_cs_map =  CreateConVar("dl_map_cs", "1", "Delete Maps Start With [cs_]\n1= Yes\n0= No", _, true, 0.0, true, 1.0);
	
	h_de_map =  CreateConVar("dl_map_de", "1", "Delete Maps Start With [de_]\n1= Yes\n0= No", _, true, 0.0, true, 1.0);
	
	h_dz_map =  CreateConVar("dl_map_dz", "1", "Delete Maps Start With[dz_] (Danger Zone Maps)\n1= Yes\n0= No", _, true, 0.0, true, 1.0);
	
	h_gd_map =  CreateConVar("dl_map_gd", "1", "Delete Maps Start With [gd_] (gd_cbble.bsp)\n1= Yes\n0= No", _, true, 0.0, true, 1.0);

	h_lobby_map =  CreateConVar("dl_map_lobby", "1", "Delete Maps Start With [lobby_] (lobby_mapveto.bsp)\n1= Yes\n0= No", _, true, 0.0, true, 1.0);

	h_training_map =  CreateConVar("dl_map_training", "1", "Delete Maps Start With [training] (training1.bsp)\n1= Yes\n0= No", _, true, 0.0, true, 1.0);

	HookConVarChange(h_enable_plugin, OnSettingsChanged);
	HookConVarChange(h_ar_map, OnSettingsChanged);
	HookConVarChange(h_cs_map, OnSettingsChanged);
	HookConVarChange(h_de_map, OnSettingsChanged);
	HookConVarChange(h_dz_map, OnSettingsChanged);
	HookConVarChange(h_gd_map, OnSettingsChanged);
	HookConVarChange(h_lobby_map, OnSettingsChanged);
	HookConVarChange(h_training_map, OnSettingsChanged);
	
	AutoExecConfig(true, "AutoDeleteOfficialMaps");
}

public void OnConfigsExecuted()
{
	bh_enable_plugin = GetConVarBool(h_enable_plugin);
	bh_ar_map = GetConVarBool(h_ar_map);
	bh_cs_map = GetConVarBool(h_cs_map);
	bh_de_map = GetConVarBool(h_de_map);
	bh_dz_map = GetConVarBool(h_dz_map);
	bh_gd_map = GetConVarBool(h_gd_map);
	bh_lobby_map = GetConVarBool(h_lobby_map);
	bh_training_map = GetConVarBool(h_training_map);
	
	
	if(bh_enable_plugin)
	{
		if(bh_ar_map)
		{
			DeleteArMaps();
		}
		
		if(bh_cs_map)
		{
			DeleteCsMaps();
		}
		
		if(bh_de_map)
		{
			DeleteDeMaps();
		}
		
		if(bh_dz_map)
		{
			DeleteDzMaps();
		}
		
		if(bh_gd_map)
		{
			DeleteGdMaps();
		}
		
		if(bh_lobby_map)
		{
			DeleteLobbyMaps();
		}
		
		if(bh_training_map)
		{
			DeleteTrainingMaps();
		}
	}
}
public int OnSettingsChanged(Handle convar, const char[] oldValue, const char[] newValue)
{
	if(convar == h_enable_plugin)
	{
		bh_enable_plugin = h_enable_plugin.BoolValue;
	}
	
	if(convar == h_ar_map)
	{
		bh_ar_map = h_ar_map.BoolValue;
	}
	
	if(convar == h_cs_map)
	{
		bh_cs_map = h_cs_map.BoolValue;
	}
	
	if(convar == h_de_map)
	{
		bh_de_map = h_de_map.BoolValue;
	}
	
	if(convar == h_dz_map)
	{
		bh_dz_map = h_dz_map.BoolValue;
	}
	
	if(convar == h_gd_map)
	{
		bh_gd_map = h_gd_map.BoolValue;
	}
	
	if(convar == h_lobby_map)
	{
		bh_lobby_map = h_lobby_map.BoolValue;
	}
	
	if(convar == h_training_map)
	{
		bh_training_map = h_training_map.BoolValue;
	}
	
	return 0;
}

void DeleteArMaps()
{
	if(!bh_enable_plugin || !bh_ar_map)return;
	
	char fileExt[4][] = {
		"bsp",
		"nav",
		"txt",
		"jpg"
	};
	
	for (int i = 0; i < MAP_COUNT_AR; i++)
	{	
		for (int f = 0; f < 4; f++)
		{
			char fileName[32];
			Format(fileName, sizeof(fileName), "maps/%s.%s", csgoMapar[i], fileExt[f]);
			
			if (FileExists(fileName))
				DeleteFile(fileName);
		}
	}
}

void DeleteCsMaps()
{
	if(!bh_enable_plugin || !bh_cs_map)return;
	
	char fileExt[4][] = {
		"bsp",
		"nav",
		"txt",
		"jpg"
	};
	
	for (int i = 0; i < MAP_COUNT_CS; i++)
	{	
		for (int f = 0; f < 4; f++)
		{
			char fileName[32];
			Format(fileName, sizeof(fileName), "maps/%s.%s", csgoMapcs[i], fileExt[f]);
			
			if (FileExists(fileName))
				DeleteFile(fileName);
		}
	}
}

void DeleteDeMaps()
{
	if(!bh_enable_plugin || !bh_de_map)return;
	
	char fileExt[4][] = {
		"bsp",
		"nav",
		"txt",
		"jpg"
	};
	
	for (int i = 0; i < MAP_COUNT_DE; i++)
	{	
		for (int f = 0; f < 4; f++)
		{
			char fileName[32];
			Format(fileName, sizeof(fileName), "maps/%s.%s", csgoMapde[i], fileExt[f]);
			
			if (FileExists(fileName))
				DeleteFile(fileName);
		}
	}
}

void DeleteDzMaps()
{
	if(!bh_enable_plugin || !bh_dz_map)return;
	
	char fileExt[4][] = {
		"bsp",
		"nav",
		"txt",
		"jpg"
	};
	
	for (int i = 0; i < MAP_COUNT_DZ; i++)
	{	
		for (int f = 0; f < 4; f++)
		{
			char fileName[32];
			Format(fileName, sizeof(fileName), "maps/%s.%s", csgoMapdz[i], fileExt[f]);
			
			if (FileExists(fileName))
				DeleteFile(fileName);
		}
	}
}

void DeleteGdMaps()
{
	if(!bh_enable_plugin || !bh_gd_map)return;
	
	char fileExt[4][] = {
		"bsp",
		"nav",
		"txt",
		"jpg"
	};
	
	for (int i = 0; i < MAP_COUNT_GD; i++)
	{	
		for (int f = 0; f < 4; f++)
		{
			char fileName[32];
			Format(fileName, sizeof(fileName), "maps/%s.%s", csgoMapgd[i], fileExt[f]);
			
			if (FileExists(fileName))
				DeleteFile(fileName);
		}
	}
}

void DeleteLobbyMaps()
{
	if(!bh_enable_plugin || !bh_lobby_map)return;
	
	char fileExt[4][] = {
		"bsp",
		"nav",
		"txt",
		"jpg"
	};
	
	for (int i = 0; i < MAP_COUNT_LOBBY; i++)
	{	
		for (int f = 0; f < 4; f++)
		{
			char fileName[32];
			Format(fileName, sizeof(fileName), "maps/%s.%s", csgoMaplobby[i], fileExt[f]);
			
			if (FileExists(fileName))
				DeleteFile(fileName);
		}
	}
}

void DeleteTrainingMaps()
{
	if(!bh_enable_plugin || !bh_training_map)return;
	
	char fileExt[4][] = {
		"bsp",
		"nav",
		"txt",
		"jpg"
	};
	
	for (int i = 0; i < MAP_COUNT_TRAINING; i++)
	{	
		for (int f = 0; f < 4; f++)
		{
			char fileName[32];
			Format(fileName, sizeof(fileName), "maps/%s.%s", csgoMaptraining[i], fileExt[f]);
			
			if (FileExists(fileName))
				DeleteFile(fileName);
		}
	}
}
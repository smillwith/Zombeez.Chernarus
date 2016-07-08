dingus_fnc_FillLoot = {

    //Old: "NVGoggles_indep", "optic_TWS", "optic_Nightstalker", "Rangefinder", "ItemGPS", 
  _eliteItems = ["srifle_DMR_06_olive_F", "arifle_MXM_F", "hgun_ACPC2_F", "hgun_Pistol_heavy_01_F", "SMG_02_F"];
  _rareItems = ["optic_DMS", "muzzle_snds_B", "bipod_01_F_blk", "optic_SOS", "muzzle_snds_L", "optic_Aco"];
  _clothingItems = ["U_B_CombatUniform_mcam", "U_BG_Guerilla2_1", "U_BG_Guerilla2_2", "U_BG_Guerilla2_3", "U_BG_Guerilla3_1", "U_BG_Guerilla3_2", "V_BandollierB_rgr", "V_PlateCarrier1_blk", "H_Cap_grn_BI", "H_MilCap_mcamo", "V_BandollierB_khk", "H_Booniehat_grn", "H_Cap_blk", "H_Cap_grn_BI", "V_TacVest_blk", "V_TacVest_brn", "V_TacVestIR_blk"];
  _magazines = ["30Rnd_9x21_Mag", "9Rnd_45ACP_Mag", "20Rnd_762x51_Mag", "11Rnd_45ACP_Mag", "30Rnd_65x39_caseless_mag"];
  _commonItems = ["ItemWatch", "ItemWatch", "ItemWatch", "ItemWatch", "ItemCompass", "ItemCompass", "ItemCompass", "ItemCompass", "optic_MRD", "acc_flashlight", "acc_flashlight", "acc_flashlight", "FirstAidKit", "FirstAidKit", "FirstAidKit", "FirstAidKit", "FirstAidKit", "Binocular", "Chemlight_Blue", "Chemlight_Green", "Chemlight_Red", "Chemlight_Blue", "Chemlight_Green", "Chemlight_Red"];

  //Get boxes
  params ["_boxes"];
  _box = _boxes select 0;

  //For each Box
  {
    //Delete everytyhing in the box
    clearItemCargo _x; clearWeaponCargo _x; clearMagazineCargo _x; clearBackpackCargo _x;
  } forEach _boxes;

  if (!isServer) exitwith {};

  //For each Box
  {
    //Pick a number to determine which type of loot we are going to get
    _seed = floor random 100;

    //chance at elite
    if (_seed >= 85) then {
      
      //Elite
      //_x addItemCargo [(_eliteItems select floor random count _eliteItems), 1];

    } else {
      if (_seed < 85 && _seed > 60) then {
      
        //Rare
        _x addItemCargo [(_rareItems select floor random count _rareItems), 1];

      } else {

        //??

      };
    };

    //1 Magazine
    _x addMagazineCargo [(_magazines select floor random count _magazines), 1];

    //always get at least 1 Common item
    _x addItemCargo [(_commonItems select floor random count _commonItems), 1];

    //Sometimes you get one more Common
    if (_seed mod 3 == 0) then {
      _x addItemCargo [(_commonItems select floor random count _commonItems), 1];  
    };

    //Temp for now
    _x addItemCargo [(_clothingItems select floor random count _clothingItems), 1];
    //_x addBackpackCargo [(_backpacks select floor random count _backpacks), 1];
    //_x addItemCargo [(_eliteItems select floor random count _eliteItems), 1];
    //_x addItemCargo [(_rareItems select floor random count _rareItems), 1];
    //_x addItemCargo [(_commonItems select floor random count _commonItems), 1];
    //_x addMagazineCargo [(_magazines select floor random count _magazines), 1];

  } forEach _boxes;

  //Distribute the elite items
  {
    //pick a box
    _box = _boxes select floor random count _boxes;

    //put it in
    _box addItemCargo [_x, 1];

  } forEach _eliteItems;

  true;
};
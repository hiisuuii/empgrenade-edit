AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

local emp_sounds = {
	[1] = "weapons/droidpopper1.wav",
	[2] = "weapons/droidpopper2.wav",
	[3] = "weapons/droidpopper3.wav"
}


/*---------------------------------------------------------
Initialize
---------------------------------------------------------*/
function ENT:Initialize()

	self.Entity:SetModel("models/t3m4/empprimed.mdl")
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:DrawShadow( false )
	
	-- Don't collide with the player
	self.Entity:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self.Entity:SetNetworkedString("Owner", "World")
	
	local phys = self.Entity:GetPhysicsObject()
	
	if (phys:IsValid()) then
		phys:Wake()
	end
	
	self.timer = CurTime() + 3
end

local exp

/*---------------------------------------------------------
Think
---------------------------------------------------------*/
function ENT:Think()
	if self.timer < CurTime() then
		self:Explosion()
		self.Entity:Remove()
	end
end

/*---------------------------------------------------------
HitEffect
---------------------------------------------------------*/
function ENT:HitEffect()
	for k, v in pairs ( ents.FindInSphere( self.Entity:GetPos(), 600 ) ) do
		if v:IsValid() && v:IsPlayer() then
		end
	end
end
/*---------------------------------------------------------
Explosion
---------------------------------------------------------*/
function ENT:Explosion()

	local dmginfo = DamageInfo()
	dmginfo:SetDamage(10000)
	dmginfo:SetAttacker(self.GrenadeOwner)
	dmginfo:SetInflictor(self.Entity)
	dmginfo:SetDamageType(DMG_DIRECT)
	dmginfo:SetReportedPosition(self.Entity:GetPos())
	dmginfo:SetDamageForce(Vector(1,1,1))

	//lol?
	local DroidNPCs = {
		["models/npc_b1/npc_droid_cis_b1_h.mdl"] = true,
		["models/npc_b1_co/npc_droid_cis_b1_co_h.mdl"] = true,
		["models/npc_b1_forest/npc_droid_cis_b1_forest_h.mdl"] = true,
		["models/npc_b1_geo/npc_droid_cis_b1_geo_h.mdl"] = true,
		["models/npc_b1_geo_co/npc_droid_cis_b1_geo_co_h.mdl"] = true,
		["models/npc_b1_marine/npc_droid_cis_b1_marine_h.mdl"] = true,
		["models/npc_b1_pilot/npc_droid_cis_b1_pilot_h.mdl"] = true,
		["models/npc_b1_security/npc_droid_cis_b1_security_h.mdl"] = true,
		["models/npc_b1_snow/npc_droid_cis_b1_snow_h.mdl"] = true,
		["models/npc_b1_training/npc_droid_cis_b1_training_h.mdl"] = true,
		["models/tfa/comm/gg/npc_comb_magna_guard_combined.mdl"] = true,
		["models/tfa/comm/gg/npc_comb_magna_guard_season4.mdl"] = true,
		["models/tfa/comm/gg/npc_comb_magna_guard_trainer.mdl"] = true,
		["models/npc_b2_jet/npc_droid_b2_jet_h.mdl"] = true,
		["models/npc_b2_pvt/npc_droid_b2_pvt_h.mdl"] = true,
		["models/npc_b2_training/npc_droid_b2_training_h.mdl"] = true,
		["models/npc_b2_xo/npc_droid_b2_xo_h.mdl"] = true,
		["models/npc_tactical_black/npc_droid_tactical_black_h.mdl"] = true,
		["models/npc_tactical_blue/npc_droid_tactical_blue_h.mdl"] = true,
		["models/npc_tactical_gold/npc_droid_tactical_gold_h.mdl"] = true,
		["models/npc_tactical_purple/npc_droid_tactical_purple_h.mdl"] = true,
		["models/bx/npc_droid_cis_bx_h.mdl"] = true,
		["models/bx_captain/npc_droid_cis_bx_cpt_h.mdl"] = true,
		["models/bx_citadel/npc_droid_cis_bx_citadel_h.mdl"] = true,
		["models/bx_senate/npc_droid_cis_bx_senate_h.mdl"] = true,
		["models/bx_training/npc_droid_cis_bx_training_h.mdl"] = true,
		
		["models/npc_b1/npc_droid_cis_b1_f.mdl"] = true,
		["models/npc_b1_co/npc_droid_cis_b1_co_f.mdl"] = true,
		["models/npc_b1_forest/npc_droid_cis_b1_forest_f.mdl"] = true,
		["models/npc_b1_geo/npc_droid_cis_b1_geo_f.mdl"] = true,
		["models/npc_b1_geo_co/npc_droid_cis_b1_geo_co_f.mdl"] = true,
		["models/npc_b1_marine/npc_droid_cis_b1_marine_f.mdl"] = true,
		["models/npc_b1_pilot/npc_droid_cis_b1_pilot_f.mdl"] = true,
		["models/npc_b1_security/npc_droid_cis_b1_security_f.mdl"] = true,
		["models/npc_b1_snow/npc_droid_cis_b1_snow_f.mdl"] = true,
		["models/npc_b1_training/npc_droid_cis_b1_training_f.mdl"] = true,
		["models/tfa/comm/gg/npc_reb_magna_guard_combined.mdl"] = true,
		["models/tfa/comm/gg/npc_reb_magna_guard_season4.mdl"] = true,
		["models/tfa/comm/gg/npc_reb_magna_guard_trainer.mdl"] = true,
		["models/npc_b2_jet/npc_droid_b2_jet.mdl"] = true,
		["models/npc_b2_pvt/npc_droid_b2_pvt.mdl"] = true,
		["models/npc_b2_training/npc_droid_b2_training.mdl"] = true,
		["models/npc_b2_xo/npc_droid_b2_xo.mdl"] = true,
		["models/npc_tactical_black/npc_droid_tactical_black_f.mdl"] = true,
		["models/npc_tactical_blue/npc_droid_tactical_blue_f.mdl"] = true,
		["models/npc_tactical_gold/npc_droid_tactical_gold_f.mdl"] = true,
		["models/npc_tactical_purple/npc_droid_tactical_purple_f.mdl"] = true,
		["models/bx/npc_droid_cis_bx_f.mdl"] = true,
		["models/bx_captain/npc_droid_cis_bx_cpt_f.mdl"] = true,
		["models/bx_citadel/npc_droid_cis_bx_citadel_f.mdl"] = true,
		["models/bx_senate/npc_droid_cis_bx_senate_f.mdl"] = true,
		["models/bx_training/npc_droid_cis_bx_training_f.mdl"] = true,
	}

	local entpos = self.Entity:GetPos() 
	local entindex = self.Entity:EntIndex()

	timer.Create("tesla_zap" .. entindex,math.Rand(0.03,0.1),math.random(5,10),function()
	local lightning = ents.Create( "point_tesla" )
		lightning:SetPos(entpos)
		lightning:SetKeyValue("m_SoundName", "")
		lightning:SetKeyValue("texture", "sprites/bluelight1.spr")
		lightning:SetKeyValue("m_Color", "255 255 150")
		lightning:SetKeyValue("m_flRadius", "150")
		lightning:SetKeyValue("beamcount_max", "15")
		lightning:SetKeyValue("thick_min", "15")
		lightning:SetKeyValue("thick_max", "30")
		lightning:SetKeyValue("lifetime_min", "0.15")
		lightning:SetKeyValue("lifetime_max", "0.4")
		lightning:SetKeyValue("interval_min", "0.15")
		lightning:SetKeyValue("interval_max", "0.25")
		lightning:Spawn()
		lightning:Fire("DoSpark", "", 0)
		lightning:Fire("kill", "", 0.2)

	local light = ents.Create("light_dynamic")
		light:SetPos( entpos )
		light:Spawn()
		light:SetKeyValue("_light", "100 100 255")
		light:SetKeyValue("distance","550")
		light:Fire("Kill","",0.20)

	end)

	sound.Play(emp_sounds[math.random(#emp_sounds)], entpos,110)

	for k, v in pairs ( ents.FindInSphere( self.Entity:GetPos(), 300 ) ) do
		if v:IsValid() && v:IsNPC() && ( v:GetClass() == "npc_combine_s" ) then
			local npcModel = v:GetModel()
			if DroidNPCs[npcModel] then
				timer.Simple(1, function()
					local mat = v:GetMaterial()
					v:SetMaterial("models/alyx/emptool_glow")
					timer.Create(v:EntIndex().."_DroidMaterialTimer",0.6,1, function()
						v:SetMaterial(mat)
						dmginfo:SetDamage(v:Health()*2)
						v:TakeDamageInfo(dmginfo)
					end)
				end)
			end
    	elseif v:IsValid() && v:IsNPC() && ( v:GetClass() == "npc_citizen" ) then
			local npcModel = v:GetModel()
			if DroidNPCs[npcModel] then
				timer.Simple(1, function()
					local mat = v:GetMaterial()
					v:SetMaterial("models/alyx/emptool_glow")
					timer.Create(v:EntIndex().."_DroidMaterialTimer",0.6,1, function()
						v:SetMaterial(mat)
						dmginfo:SetDamage(v:Health()*2)
						v:TakeDamageInfo(dmginfo)
					end)
				end)
			end
	    end
	end
end
/*---------------------------------------------------------
OnTakeDamage
---------------------------------------------------------*/
function ENT:OnTakeDamage( dmginfo )
end


/*---------------------------------------------------------
Use
---------------------------------------------------------*/
function ENT:Use( activator, caller, type, value )
end


/*---------------------------------------------------------
StartTouch
---------------------------------------------------------*/
function ENT:StartTouch( entity )
end


/*---------------------------------------------------------
EndTouch
---------------------------------------------------------*/
function ENT:EndTouch( entity )
end


/*---------------------------------------------------------
Touch
---------------------------------------------------------*/
function ENT:Touch( entity )
end
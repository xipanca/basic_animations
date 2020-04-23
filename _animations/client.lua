local Tunnel = module('_core', 'libs/Tunnel')
local Proxy = module('_core', 'libs/Proxy')

cAPI = Proxy.getInterface('API')
API = Tunnel.getInterface('API')

local player = PlayerPedId()
local apontar = false

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÃO DO APONTAR
-----------------------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if apontar then
			local camPitch = GetGameplayCamRelativePitch()
			if camPitch < -70.0 then
				camPitch = -70.0
			elseif camPitch > 42.0 then
				camPitch = 42.0
			end
			camPitch = (camPitch + 70.0) / 112.0

			local camHeading = GetGameplayCamRelativeHeading()
			local cosCamHeading = Cos(camHeading)
			local sinCamHeading = Sin(camHeading)
			if camHeading < -180.0 then
				camHeading = -180.0
			elseif camHeading > 180.0 then
				camHeading = 180.0
			end
			camHeading = (camHeading + 180.0) / 360.0

			local blocked = 0
			local nn = 0
			local coords = GetOffsetFromEntityInWorldCoords(player,(cosCamHeading*-0.2)-(sinCamHeading*(0.4*camHeading+0.3)),(sinCamHeading*-0.2)+(cosCamHeading*(0.4*camHeading+0.3)),0.6)
			local ray = Cast_3dRayPointToPoint(coords.x,coords.y,coords.z-0.2,coords.x,coords.y,coords.z+0.2,0.4,95,player,7);
			nn,blocked,coords,coords = GetRaycastResult(ray)

			SetTaskMoveNetworkSignalFloat(player,"Pitch",camPitch)
			SetTaskMoveNetworkSignalFloat(player,"Heading",camHeading*-1.0+1.0)
			SetTaskMoveNetworkSignalBool(player,"isBlocked",blocked)
			SetTaskMoveNetworkSignalBool(player,"isFirstPerson",Citizen.InvokeNative(0xEE778F8C7E1142E2,Citizen.InvokeNative(0x19CAFA3C87F7C2FF))==4)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		-- CRUZAR O BRACO (F1)
        if IsControlJustPressed(0,288) then
            loadAnimDict("anim@heists@heist_corona@single_team")
			if not IsPedInAnyVehicle(player) and GetEntityHealth(player) > 101 then
				TaskPlayAnim(player,"anim@heists@heist_corona@single_team","single_team_loop_boss",3.0,1.0,-1,49,0,0,0,0)
        	end
		end

		-- DEDO DO MEIO (F3)
        if IsControlJustPressed(0,170) then
            loadAnimDict("anim@mp_player_intselfiethe_bird")            
			if not IsPedInAnyVehicle(player) and GetEntityHealth(player) > 101 then
				TaskPlayAnim(player,"anim@mp_player_intselfiethe_bird","idle_a",3.0,1.0,-1,49,0,0,0,0)
        	end
		end

		--AJOELHAR (F5)
        if IsControlJustPressed(0,166) then
            loadAnimDict("random@arrests")
            loadAnimDict("random@arrests@busted")
			if not IsPedInAnyVehicle(player) and GetEntityHealth(player) > 101 then                
                TaskPlayAnim(player,"random@arrests","idle_2_hands_up",8.0,1.0,-1,2,0,0,0,0)
                Citizen.Wait(4000)
                TaskPlayAnim(player,"random@arrests","kneeling_arrest_idle",8.0,1.0,-1,2,0,0,0,0)
                Citizen.Wait(500)
                TaskPlayAnim(player,"random@arrests@busted","enter",8.0,1.0,-1,2,0,0,0,0)
                Citizen.Wait(1000)
                TaskPlayAnim(player,"random@arrests@busted","idle_a",8.0,1.0,-1,9,0,0,0,0)
                Citizen.Wait(100)				
        	end
        end

		-- PARA TODAS AS ANIMAÇÕES (F6)
		if IsControlJustPressed(0,167) then			
            if GetEntityHealth(player) > 101 then					
                ClearPedTasks(player)					
            end			
		end

		-- MÃOS NA CABEÇA (F10)
        if IsControlJustPressed(0,57) then
            loadAnimDict('random@arrests@busted')
			if GetEntityHealth(player) > 101 then
				TaskPlayAnim(player, 'random@arrests@busted','idle_a', 3.0, -3.0, -1, 49, 0, 0, 0, 0); 
        	end
		end

		-- ASSOBIAR (ARROW DOWN)
        if IsControlJustPressed(0,187) then
            loadAnimDict('rcmnigel1c')
			if not IsPedInAnyVehicle(player) and GetEntityHealth(player) > 101 then
                TaskPlayAnim(player, 'rcmnigel1c', 'hailing_whistle_waive_a', 3.0, -3.0, -1, 120, 0, 0, 0, 0)
        	end
		end

		-- JOIA (ARROW LEFT)
        if IsControlJustPressed(0,189) then
            loadAnimDict('anim@mp_player_intupperthumbs_up')
			if not IsPedInAnyVehicle(player) and GetEntityHealth(player) > 101 then
				TaskPlayAnim(player, 'anim@mp_player_intupperthumbs_up', 'enter', 3.0, -3.0, -1, 120, 0, 0, 0, 0)
        	end
		end

		-- FACEPALM (ARROW RIGHT)
        if IsControlJustPressed(0,190) then
            loadAnimDict('anim@mp_player_intcelebrationmale@face_palm')
			if not IsPedInAnyVehicle(player) and GetEntityHealth(player) > 101 then
				TaskPlayAnim(player, 'anim@mp_player_intcelebrationmale@face_palm', 'face_palm', 3.0, -3.0, -1, 120, 0, 0, 0, 0)
        	end
		end

		-- SAUDACAO (ARROW UP)
        if IsControlJustPressed(0,188) then
            loadAnimDict('anim@mp_player_intcelebrationmale@salute')
			if not IsPedInAnyVehicle(player) and GetEntityHealth(player) > 101 then
				TaskPlayAnim(player, 'anim@mp_player_intcelebrationmale@salute', 'salute', 3.0, -3.0, -1, 120, 0, 0, 0, 0)
        	end
		end

		-- LEVANTAR A MAO (X)
        if IsControlJustPressed(0,73) then
            loadAnimDict('random@mugging3')
			if not IsPedInAnyVehicle(player) and GetEntityHealth(player) > 101 then
				TaskPlayAnim(player, 'random@mugging3', '"handsup_standing_base', 3.0, -3.0, -1, 120, 0, 0, 0, 0)
        	end
		end

		-- APONTAR O DEDO (B)
		if IsControlJustPressed(0,29) then
			if GetEntityHealth(player) > 101 then
				loadAnimDict("anim@mp_point")
				if not apontar then
					SetPedCurrentWeaponVisible(player,0,1,1,1)
					SetPedConfigFlag(player,36,1)
					TaskMoveNetworkByName(player,"task_mp_pointing",0.5,0,"anim@mp_point",24)
                	apontar = true
            	else
            		RequestTaskMoveNetworkStateTransition(player,"Stop")
					if not IsPedInjured(player) then
						ClearPedSecondaryTask(player)
					end
					if not IsPedInAnyVehicle(player) then
						SetPedCurrentWeaponVisible(player,1,1,1,1)
					end
					SetPedConfigFlag(player,36,0)
					ClearPedSecondaryTask(player)
                	apontar = false
            	end
        	end
		end
	end
end)

--------------------------------------------------------------------------------------------------------------
--FUNCOES
--------------------------------------------------------------------------------------------------------------

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

function LoadAnimSet(clipset)
    while (not HasAnimSetLoaded(clipset)) do
        RequestAnimSet(clipset)
        Citizen.Wait(5)
    end
end


-- =========================================
-- MODULE: Alarm System
-- =========================================
-- HP/Mana/Player detection alarms with sounds

alarmsPanelName = "alarms"

local ui = setupUI([[
Panel
  height: 19

  BotSwitch
    id: title
    anchors.top: parent.top
    anchors.left: parent.left
    text-align: center
    width: 130
    !text: tr('Alarme')

  Button
    id: alerts
    anchors.top: prev.top
    anchors.left: prev.right
    anchors.right: parent.right
    margin-left: 3
    height: 17
    text: Edite
]])

ui:setId(alarmsPanelName)

-- Initialize storage
if not storage[alarmsPanelName] then
    storage[alarmsPanelName] = {
        enabled = false,
        playerAttack = false,
        playerDetected = false,
        playerDetectedLogout = false,
        creatureDetected = false,
        healthBelow = false,
        healthValue = 40,
        manaBelow = false,
        manaValue = 50,
        privateMessage = false,
        playerpk = false
    }
end

-- UI Setup
ui.title:setOn(storage[alarmsPanelName].enabled)
ui.title.onClick = function(widget)
    storage[alarmsPanelName].enabled = not storage[alarmsPanelName].enabled
    widget:setOn(storage[alarmsPanelName].enabled)
end

-- Alarms Window
rootWidget = g_ui.getRootWidget()
if rootWidget then
    alarmsWindow = g_ui.createWidget('AlarmsWindow', rootWidget)
    alarmsWindow:hide()

    alarmsWindow.closeButton.onClick = function(widget)
        alarmsWindow:hide()
    end

    -- Player Attack Alarm
    alarmsWindow.playerAttack:setOn(storage[alarmsPanelName].playerAttack)
    alarmsWindow.playerAttack.onClick = function(widget)
        storage[alarmsPanelName].playerAttack = not storage[alarmsPanelName].playerAttack
        widget:setOn(storage[alarmsPanelName].playerAttack)
    end

    -- Player Detection Alarm
    alarmsWindow.playerDetected:setOn(storage[alarmsPanelName].playerDetected)
    alarmsWindow.playerDetected.onClick = function(widget)
        storage[alarmsPanelName].playerDetected = not storage[alarmsPanelName].playerDetected
        widget:setOn(storage[alarmsPanelName].playerDetected)
    end

    alarmsWindow.playerDetectedLogout:setChecked(storage[alarmsPanelName].playerDetectedLogout)
    alarmsWindow.playerDetectedLogout.onClick = function(widget)
        storage[alarmsPanelName].playerDetectedLogout = not storage[alarmsPanelName].playerDetectedLogout
        widget:setChecked(storage[alarmsPanelName].playerDetectedLogout)
    end

    -- Creature Detection Alarm
    alarmsWindow.creatureDetected:setOn(storage[alarmsPanelName].creatureDetected)
    alarmsWindow.creatureDetected.onClick = function(widget)
        storage[alarmsPanelName].creatureDetected = not storage[alarmsPanelName].creatureDetected
        widget:setOn(storage[alarmsPanelName].creatureDetected)
    end

    -- PK Alarm
    alarmsWindow.playerpk:setOn(storage[alarmsPanelName].playerpk)
    alarmsWindow.playerpk.onClick = function(widget)
        storage[alarmsPanelName].playerpk = not storage[alarmsPanelName].playerpk
        widget:setOn(storage[alarmsPanelName].playerpk)
    end

    -- Health Alarm
    alarmsWindow.healthBelow:setOn(storage[alarmsPanelName].healthBelow)
    alarmsWindow.healthBelow.onClick = function(widget)
        storage[alarmsPanelName].healthBelow = not storage[alarmsPanelName].healthBelow
        widget:setOn(storage[alarmsPanelName].healthBelow)
    end

    alarmsWindow.healthValue.onValueChange = function(scroll, value)
        storage[alarmsPanelName].healthValue = value
        alarmsWindow.healthBelow:setText("Health < " .. storage[alarmsPanelName].healthValue .. "%")  
    end
    alarmsWindow.healthValue:setValue(storage[alarmsPanelName].healthValue)

    -- Mana Alarm
    alarmsWindow.manaBelow:setOn(storage[alarmsPanelName].manaBelow)
    alarmsWindow.manaBelow.onClick = function(widget)
        storage[alarmsPanelName].manaBelow = not storage[alarmsPanelName].manaBelow
        widget:setOn(storage[alarmsPanelName].manaBelow)
    end

    alarmsWindow.manaValue.onValueChange = function(scroll, value)
        storage[alarmsPanelName].manaValue = value
        alarmsWindow.manaBelow:setText("Mana < " .. storage[alarmsPanelName].manaValue .. "%")  
    end
    alarmsWindow.manaValue:setValue(storage[alarmsPanelName].manaValue)

    -- Private Message Alarm
    alarmsWindow.privateMessage:setOn(storage[alarmsPanelName].privateMessage)
    alarmsWindow.privateMessage.onClick = function(widget)
        storage[alarmsPanelName].privateMessage = not storage[alarmsPanelName].privateMessage
        widget:setOn(storage[alarmsPanelName].privateMessage)
    end

    local configName = modules.game_bot.contentsPanel.config:getCurrentOption().text

    -- Player Attack Detection
    onTextMessage(function(mode, text)
        if storage[alarmsPanelName].enabled and storage[alarmsPanelName].playerAttack 
           and mode == 16 and string.match(text, "hitpoints due to an attack") 
           and not string.match(text, "hitpoints due to an attack by a ") then
            playSound("/bot/" .. configName.. "/Alarme/Player_Attack.ogg")
        end
    end)

    -- Main Alarm Loop
    macro(100, function()
        if not storage[alarmsPanelName].enabled then return end
        
        -- Player Detection
        if storage[alarmsPanelName].playerDetected then
            for _, spec in ipairs(getSpectators()) do
                if spec:isPlayer() and spec:getName() ~= name() then
                    specPos = spec:getPosition()
                    if math.max(math.abs(posx()-specPos.x), math.abs(posy()-specPos.y)) <= 8 then
                        playSound("/bot/" .. configName.. "/Alarme/jogador.ogg")
                        delay(1500)
                        if storage[alarmsPanelName].playerDetectedLogout then
                            modules.game_interface.tryLogout(false)
                        end
                        return
                    end
                end
            end
        end

        -- Creature Detection
        if storage[alarmsPanelName].creatureDetected then
            for _, spec in ipairs(getSpectators()) do
                if not spec:isPlayer() then
                    specPos = spec:getPosition()
                    if math.max(math.abs(posx()-specPos.x), math.abs(posy()-specPos.y)) <= 8 then
                        playSound("/bot/" .. configName.. "/Alarme/monstro.ogg")
                        delay(1500)
                        return
                    end
                end
            end
        end

        -- Health Alarm
        if storage[alarmsPanelName].healthBelow then
            if hppercent() <= storage[alarmsPanelName].healthValue then
                playSound("/bot/" .. configName.. "/Alarme/vida.ogg")
                delay(1500)
                return
            end
        end

        -- PK Detection
        if storage[alarmsPanelName].playerpk then
            for _, spec in ipairs(getSpectators()) do
                if spec:isPlayer() and spec:getSkull() ~= skull() then
                    playSound("/bot/" .. configName.. "/Alarme/pk.ogg")
                    delay(1500)
                    return
                end
            end
        end

        -- Mana Alarm
        if storage[alarmsPanelName].manaBelow then
            if manapercent() <= storage[alarmsPanelName].manaValue then
                playSound("/bot/" .. configName.. "/Alarme/mana.ogg")
                delay(1500)
                return
            end
        end
    end)

    -- Private Message Alarm
    onTalk(function(name, level, mode, text, channelId, pos)
        if mode == 4 and storage[alarmsPanelName].enabled and storage[alarmsPanelName].privateMessage then
            playSound("/sounds/mensagem.ogg")
            return
        end
    end)
end

ui.alerts.onClick = function(widget)
    alarmsWindow:show()
    alarmsWindow:raise()
    alarmsWindow:focus()
end

UI.Separator()

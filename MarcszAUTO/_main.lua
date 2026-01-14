UI.Separator()

-- =====================================
-- CONFIGURAÇÕES Boss Timer
-- =====================================
local bossConfig = {
    alarmSeconds = 60,            
    sound = "AlarmClock.wav",     
    raidHours = {                 
        "01:30", "03:30", "05:30", "07:30", "09:30", "11:30",
        "13:30", "15:30", "17:30", "19:30", "21:30", "23:30"
    }
}

local lastAlarmTime = ""

-- =====================================
-- FUNÇÕES DE TEMPO
-- =====================================
local function getSecondsSinceMidnight()
    local t = os.date("*t")
    return t.hour * 3600 + t.min * 60 + t.sec
end

local function timeToSeconds(hhmm)
    local h, m = string.match(hhmm, "(%d+):(%d+)")
    return tonumber(h) * 3600 + tonumber(m) * 60
end

local function getNextRaid()
    local now = getSecondsSinceMidnight()
    for _, timeStr in ipairs(bossConfig.raidHours) do
        local raidSec = timeToSeconds(timeStr)
        if raidSec > now then
            return raidSec - now, timeStr
        end
    end
    local firstRaidSec = timeToSeconds(bossConfig.raidHours[1])
    return (24 * 3600 - now) + firstRaidSec, bossConfig.raidHours[1]
end

-- =====================================
-- MACRO E ÍCONE
-- =====================================
local bossMacro = macro(1000, "Boss Timer", function()
    local remaining, nextTime = getNextRaid()
    
    local hrs = math.floor(remaining / 3600)
    local mins = math.floor((remaining % 3600) / 60)
    local secs = remaining % 60
    local timeStr = string.format("%02d:%02d:%02d", hrs, mins, secs)
    
    if bossIcon then
        -- Mantive o ajuste visual (pular linhas)
        bossIcon:setText("\n\n" .. nextTime .. "\n" .. timeStr)
        
        if remaining < 120 then
            bossIcon:setColor("red") 
        else
            bossIcon:setColor("white")
        end
    end

    if remaining <= bossConfig.alarmSeconds and lastAlarmTime ~= nextTime then
        -- Toca o som
        playSound("Alarme/" .. bossConfig.sound)
        
        -- CORREÇÃO DO ERRO: Verifica se o comando flash existe antes de usar
        if g_window and g_window.flash then
            g_window.flash()
        end
        
        modules.game_textmessage.displayGameMessage("BOSS EM " .. remaining .. " SEGUNDOS!")
        lastAlarmTime = nextTime
    end
end)

-- Ícone sem texto inicial e tamanho ajustado
bossIcon = addIcon("BossTimer", {item=2036, text="", moveable=true}, bossMacro)
bossIcon:setSize({height=85, width=50}) 

UI.Separator()
local showhp = macro(20000, "Monstro Hp %", function() end)
onCreatureHealthPercentChange(function(creature, healthPercent)
    if showhp:isOff() then  return end
    if creature:isMonster() or creature:isPlayer() and creature:getPosition() and pos() then
        if creature:getPosition() then
            creature:setText(healthPercent .. "%")
        else
            creature:clearText()
  

      end
    end
end)

UI.Separator ()

macro(250, "Atacar Seguindo", "Shift+R", function()
   if g_game.isOnline() and g_game.isAttacking() then
         g_game.setChaseMode(1)
           end
           end)

UI.Separator()


if type(storage.moneyItems) ~= "table" then
  storage.moneyItems = {3031, 3035}
end
macro(100, "Converter dinheiro", function()
  if not storage.moneyItems[1] then return end
  local containers = g_game.getContainers()
  for index, container in pairs(containers) do
    if not container.lootContainer then -- ignore monster containers
      for i, item in ipairs(container:getItems()) do
        if item:getCount() == 100 then
          for m, moneyId in ipairs(storage.moneyItems) do
            if item:getId() == moneyId.id then
              return g_game.use(item)
            end
          end
        end
      end
    end
  end
end)

local moneyContainer = UI.Container(function(widget, items)
  storage.moneyItems = items
end, true)
moneyContainer:setHeight(35)
moneyContainer:setItems(storage.moneyItems)

UI.Separator()
-- =====================================
-- CONFIGURAÇÕES HOUSE TRAINER
-- =====================================
local trainerConfig = {
    house = { x1 = 1051, y1 = 1040, x2 = 1057, y2 = 1044, z = 7 },
    dummy = { id = 54005, pos = {x = 1051, y = 1043, z = 7} },
    wands = { 55486, 55484, 55634 }, -- Prioridade: Esquerda -> Direita
    delay = 1500
}

-- =====================================
-- FUNÇÕES AUXILIARES
-- =====================================
local function isInsideHouse()
    local p = pos() 
    return p.z == trainerConfig.house.z 
       and p.x >= trainerConfig.house.x1 and p.x <= trainerConfig.house.x2
       and p.y >= trainerConfig.house.y1 and p.y <= trainerConfig.house.y2
end

local function getPriorityWand()
    for _, id in ipairs(trainerConfig.wands) do
        local item = findItem(id) 
        if item then
            return item
        end
    end
    return nil
end

local function getDummyThing()
    local tile = g_map.getTile(trainerConfig.dummy.pos)
    if not tile then return nil end
    
    for _, thing in ipairs(tile:getThings()) do
        if thing:getId() == trainerConfig.dummy.id then
            return thing
        end
    end
    return nil
end

-- =====================================
-- MACRO E ÍCONE
-- =====================================

-- 1. Criamos o macro e salvamos na variável 'HouseMacro'
local HouseMacro = macro(trainerConfig.delay, "House Trainer", function()
    if not isInsideHouse() then return end

    local targetDummy = getDummyThing()
    if not targetDummy then return end

    local wandItem = getPriorityWand()
    
    if wandItem then
        g_game.useWith(wandItem, targetDummy)
    end
end)

-- 2. Adicionamos o ícone vinculado à variável 'HouseMacro'
-- moveable=true permite arrastar o ícone pela tela
addIcon("Trainer", {item=55486, text="Trainer", moveable=true}, HouseMacro)

UI.Separator()

macro(100, "Attack", function()
if g_game.isAttacking() then
  say(storage.magia1) delay(100) say(storage.magia2) delay(100) say(storage.magia3)
end
end)
UI.TextEdit(storage.magia1 or "spell", function(widget, newText)
  storage.magia1 = newText
end)
UI.TextEdit(storage.magia2 or "spell2", function(widget, newText)
  storage.magia2 = newText
end)
UI.TextEdit(storage.magia3 or "spell3", function(widget, newText)
  storage.magia3 = newText
end)

UI.Separator()
Panels.AttackItem(batTab)
addSeparator("sep", batTab)

UI.Separator()


local dodgeConfig = {
    forbiddenId = 55636, -- ID do piso que mata (Fogo/Mecânica)
    anchorId = 10145,    -- ID do piso seguro (Centro/Âncora)
    
    ranges = {
        anchorSearch = 7,  -- Distância para procurar a âncora
        dangerScan = 5     -- Raio para verificar se a mecânica ainda está ativa
    },
    
    returnDelay = 500      -- Tempo em milissegundos para voltar ao boss (500ms = 0.5s)
}

-- Variável para controlar o tempo da última mecânica vista
if not storage.lastMechanicTime then
    storage.lastMechanicTime = 0
end

-- =====================================
-- FUNÇÕES AUXILIARES
-- =====================================

-- CORREÇÃO AQUI: Verifica item manualmente sem usar :hasItem()
local function hasItemOnPos(pos, itemId)
    local tile = g_map.getTile(pos)
    if tile then
        -- Pega todas as coisas no tile (items, efeitos, criaturas)
        local things = tile:getThings()
        for _, thing in ipairs(things) do
            if thing:getId() == itemId then
                return true
            end
        end
    end
    return false
end

-- Escaneia a área ao redor para ver se a mecânica (piso proibido) existe
local function isMechanicNearby(pos, range)
    for x = -range, range do
        for y = -range, range do
            local checkPos = {x = pos.x + x, y = pos.y + y, z = pos.z}
            if hasItemOnPos(checkPos, dodgeConfig.forbiddenId) then
                return true
            end
        end
    end
    return false
end

-- Procura o piso seguro (Anchor) mais próximo
local function getSafeAnchor(pos)
    local bestPos = nil
    local minDist = 999

    for x = -dodgeConfig.ranges.anchorSearch, dodgeConfig.ranges.anchorSearch do
        for y = -dodgeConfig.ranges.anchorSearch, dodgeConfig.ranges.anchorSearch do
            local checkPos = {x = pos.x + x, y = pos.y + y, z = pos.z}
            
            -- Verifica se é o piso âncora
            if hasItemOnPos(checkPos, dodgeConfig.anchorId) then
                -- Verifica se ESTE piso âncora não está pegando fogo agora
                if not hasItemOnPos(checkPos, dodgeConfig.forbiddenId) then
                    local dist = getDistanceBetween(pos, checkPos)
                    if dist < minDist then
                        minDist = dist
                        bestPos = checkPos
                    end
                end
            end
        end
    end
    return bestPos
end

-- =====================================
-- MACRO PRINCIPAL
-- =====================================
macro(200, "Boss Dodge Logic", function()
    local player = g_game.getLocalPlayer()
    if not player then return end
    
    local playerPos = player:getPosition()
    
    -- 1. Verifica se estamos pisando no perigo AGORA (Emergência)
    local standingOnDanger = hasItemOnPos(playerPos, dodgeConfig.forbiddenId)

    if standingOnDanger then
        -- ESTADO: EMERGÊNCIA
        storage.lastMechanicTime = now
        
        local safeSpot = getSafeAnchor(playerPos)
        if safeSpot then
            -- Tenta andar para o local seguro
            if not player:isWalking() then
                 autoWalk(safeSpot, 10, {ignoreNonPathable = true, precision = 1})
            end
        end
        return 
    end

    -- 2. Se não estamos no fogo, verificamos se a mecânica está por perto
    if isMechanicNearby(playerPos, dodgeConfig.ranges.dangerScan) then
        -- ESTADO: ALERTA (Fica parado esperando)
        storage.lastMechanicTime = now
        return
    end

    -- 3. A mecânica sumiu. Vamos verificar o delay.
    local timeSinceGone = now - storage.lastMechanicTime
    
    if timeSinceGone >= dodgeConfig.returnDelay then
        -- ESTADO: RETORNAR AO COMBATE
        local target = g_game.getAttackingCreature()
        if target then
            local targetPos = target:getPosition()
            -- Só anda se estiver longe (mais de 1 sqm)
            if getDistanceBetween(playerPos, targetPos) > 1 then
                autoWalk(targetPos, 20, {ignoreNonPathable = true, precision = 1})
            end
        end
    end
end)

UI.Separator()
-- ==============================================================
-- 1. MAGIA DE CURA (SINGLE SPELL)
-- ==============================================================
UI.Separator()

if type(storage.singleHeal) ~= "table" then
  storage.singleHeal = {on=false, title="HP%", text="exura gran san", min=0, max=90}
end

local healMacro = macro(20, function()
  local hp = player:getHealthPercent()
  if storage.singleHeal.max >= hp and hp >= storage.singleHeal.min then
    if TargetBot then 
      TargetBot.saySpell(storage.singleHeal.text) 
    else
      say(storage.singleHeal.text)
    end
  end
end)
healMacro.setOn(storage.singleHeal.on)

UI.DualScrollPanel(storage.singleHeal, function(widget, newParams) 
  storage.singleHeal = newParams
  healMacro.setOn(storage.singleHeal.on)
end)

UI.Separator()

-- ==============================================================
-- 2. POTION (1 SLOT)
-- ==============================================================

Panels.HealthItem() 
UI.Separator()

-- ==============================================================
-- 3. ANTI-PARALYZE
-- ==============================================================
Panels.AntiParalyze()
UI.Separator()

-- ==============================================================
-- 4. HASTE (SPEED)
-- ==============================================================
Panels.Haste()
UI.Separator()

-- ==============================================================
-- 5. BUFF SYSTEM (COM ÍCONE)
-- ==============================================================

local buffMacro = macro(1000, "Buff System", function()
    -- Verifica se não está com buff de party e não está em PZ
    if not hasPartyBuff() and not isInPz() then
        if storage.buff1 and storage.buff1:len() > 0 then
            say(storage.buff1)
        end
    end
end)

UI.Label("Buff:")
addTextEdit("buff1", storage.buff1 or "utito tempo san", function(widget, text) 
    storage.buff1 = text
end)

UI.Separator()

-- Configuração do Tempo (2 minutos = 120000 ms)
local renewDelay = 2 * 60 * 1000 
local command = "!taskrenew"

-- Cria o botão com a lógica
macro(renewDelay, "Renovar Task (2min)", function()
    say(command)
end)

-- [[ UTILITÁRIOS AUTOMÁTICOS ]] --
-- Configuração de Tempo (30 segundos = 30000 ms)
local interval = 30000

-- BOTÃO 1: Auto Sell (Item 54995)
macro(interval, "Auto Sell (54995)", function()
    local item = findItem(54995)
    if item then
        g_game.use(item)
    end
end)

-- BOTÃO 2: Auto Deposit (Item 54991)
macro(interval, "Auto Deposit (54991)", function()
    local item = findItem(54991)
    if item then
        g_game.use(item)
    end
end)

-- [[ AUTO BLESS (RELOG/DEATH) ]] --

-- Configurações
local blessId = 54531

-- Controle de Estado
if not storage.autoBless then
    storage.autoBless = {
        wasOnline = false, -- Para detectar quando logar
        pending = false    -- Para saber se precisa usar a bless
    }
end

-- 1. DETECTOR DE MORTE (Lê o chat)
onTextMessage(function(mode, text)
    -- Se detectar morte, marca como pendente para usar assim que possível
    if string.find(text, "You are dead") or string.find(text, "You were downgraded") then
        storage.autoBless.pending = true
        print("[AutoBless] Morte detectada! Bless agendada para o retorno.")
    end
end)

-- 2. MACRO PRINCIPAL
macro(1000, "Auto Bless (54531)", function()
    local isOnline = g_game.isOnline()
    
    -- Lógica de Reconexão:
    -- Se estava offline (false) e agora está online (true) -> Marca para usar
    if isOnline and not storage.autoBless.wasOnline then
        storage.autoBless.pending = true
        print("[AutoBless] Reconexão detectada! Tentando usar bless...")
    end
    
    -- Atualiza o estado para o próximo loop
    storage.autoBless.wasOnline = isOnline

    -- Execução: Se estiver online e tiver uma bless pendente
    if isOnline and storage.autoBless.pending then
        local item = findItem(blessId)
        if item then
            g_game.use(item)
            storage.autoBless.pending = false -- Desmarca após usar
            print("[AutoBless] Item de Bless usado com sucesso!")
            modules.game_textmessage.displayGameMessage("AutoBless: Item Usado!")
        end
    end
end)

-- ==============================================================
-- 1. CONFIGURAÇÕES
-- ==============================================================
local config = {
    distance = 1,          -- Distância alvo (1 = colar)
    interactionDelay = 100 -- Delay mínimo entre interações (ms)
}

-- IDs que precisam de "USE" (Clique Direito -> Bueiros, Tumbas Fechadas)
local useIds = {
    433, 435, 482, 1948, 1968, 5542, 7771, 9116, 12799, 17230, 20469, 20474, 
    20488, 20489, 20895, 20896, 28209, 28210, 28656, 31129, 31130, 31262, 33770, 
    34324, 43374
}

-- IDs que precisam "ANDAR EM CIMA" (Portais, Escadas, Pisos Mágicos)
-- Adicione aqui o ID do seu portal se faltar
local stepIds = {
    166, 167, 413, 427, 427, 428, 433, 437, 438, 465, 468, 566, 855, 856, 857, 
    1947, 1950, 1951, 1952, 1953, 1954, 1955, 1956, 1957, 1958, 1977, 1978, 
    4823, 5081, 5257, 5258, 5259, 7881, 7888, 8657, 8658, 8690, 8932, 10206, 
    11707, 11709, 14133, 15144, 15145, 15146, 15147, 15718, 16272, 17394, 17395, 
    15590, 15591, 20123, 20124, 20142, 20224, 20225, 20253, 20254, 20255, 20256, 
    20257, 20258, 20259, 20328, 20329, 20330, 20331, 20332, 20333, 20334, 20335, 
    20336, 20491, 20492, 20493, 20494, 20495, 20496, 20750, 20751, 20752, 20753, 
    20754, 20755, 21365, 21564, 21566, 21568, 21570, 21156, 22517, 22565, 22566, 
    22749, 29111, 31907, 39919, 39921, 39923, 39925, 40262, 40263, 40279, 40281, 
    40296, 40298, 40302, 40428, 40430, 40432, 40434, 42619, 42621, 42623, 42632, 
    43134, 42395, 42391, 23483, 1967, 1966, 293, 294, 369, 370, 385, 394, 411, 
    412, 414, 426, 432, 434, 469, 476, 483, 484, 485, 594, 595, 600, 601, 602, 
    607, 609, 610, 615, 868, 874, 877, 1066, 1067, 1080, 1156, 4824, 4825, 4826, 
    5544, 5691, 5731, 5763, 6127, 6128, 6129, 6130, 6172, 6173, 6754, 6755, 6756, 
    6916, 7053, 7181, 7182, 7476, 7477, 7478, 7479, 7515, 7516, 7517, 7518, 7520, 
    7521, 7522, 7729, 7730, 7731, 7732, 7733, 7734, 7735, 7736, 7737, 7755, 7764, 
    8144, 8709, 8924, 12200, 12236, 12797, 12798, 12939, 12940, 12941, 12942, 
    12943, 12944, 12945, 12946, 12947, 12948, 12949, 12950, 12951, 12952, 12953, 
    12954, 12955, 12956, 12957, 12958, 12959, 12960, 14134, 16265, 16266, 16267, 
    16268, 16269, 16270, 16271, 16696, 16697, 16698, 16699, 16700, 16701, 16702, 
    16703, 16785, 16786, 16787, 16788, 16789, 16790, 16791, 16792, 17239, 18642, 
    18643, 18644, 18645, 18646, 18647, 18648, 18649, 19143, 19220, 20260, 20261, 
    20262, 20263, 20344, 20470, 20471, 20472, 20073, 21034, 21342, 21344, 21971, 
    21972, 21973, 22157, 22748, 23364, 27628, 28655, 30452, 30453, 31168, 32020, 
    33709, 34166, 34255, 38831, 38832, 43372, 6920,
    505, 628, 775, 878, 1756, 1761, 1949, 1959, 5022, 5756, 8193, 11552, 11553, 
    12795, 15320, 19243, 20142, 21739, 21740, 21741, 21743, 22106, 22747, 22761, 
    23482, 25047, 25049, 25051, 25052, 25053, 25054, 25055, 25056, 25057, 25058, 
    27589, 27590, 27658, 28671, 29975, 29979, 29980, 32974, 33004, 33005, 33006, 
    33007, 33790, 34111, 35502, 36972, 37000, 37001, 31469, 37065, 5068, 5069, 
    44027, 32979, 23483
}

-- ==============================================================
-- 2. VARIÁVEIS LOCAIS (Memória Rápida)
-- ==============================================================
local lastKnownX, lastKnownY, lastKnownZ = 0, 0, 0
local hasLastPos = false
local lastInteraction = 0

if not storage.TurboFollowName then storage.TurboFollowName = "" end

-- ==============================================================
-- 3. INTERFACE
-- ==============================================================
UI.Label("Nome do Alvo:")
local followEdit = UI.TextEdit(storage.TurboFollowName or "", function(widget, text)
    storage.TurboFollowName = text
end)

-- ==============================================================
-- 4. FUNÇÕES OTIMIZADAS
-- ==============================================================

local function isIdInList(id, list)
    for i = 1, #list do
        if list[i] == id then return true end
    end
    return false
end

-- Busca rápida de alvo
local function findTarget(name)
    if not name or #name < 1 then return nil end
    local player = g_game.getLocalPlayer()
    if not player then return nil end
    
    local specs = g_map.getSpectators(player:getPosition(), false)
    for _, c in ipairs(specs) do
        if c:isPlayer() and c ~= player and c:getName():lower() == name:lower() then
            return c
        end
    end
    return nil
end

local function getDist(pos1, pos2)
    return math.max(math.abs(pos1.x - pos2.x), math.abs(pos1.y - pos2.y))
end

-- Lógica Inteligente de Pisos
local function checkSurroundings(pPos)
    if now - lastInteraction < config.interactionDelay then return end
    
    -- Varre 3x3 ao redor
    for x = -1, 1 do
        for y = -1, 1 do
            local checkPos = {x = pPos.x + x, y = pPos.y + y, z = pPos.z}
            local tile = g_map.getTile(checkPos)
            if tile then
                local things = tile:getThings()
                for _, thing in ipairs(things) do
                    if thing:isItem() then
                        local id = thing:getId()
                        
                        -- CASO 1: Portais e Escadas (ANDAR EM CIMA)
                        if isIdInList(id, stepIds) then
                            -- Força o AutoWalk para cima do portal
                            autoWalk(checkPos, 10, {ignoreNonPathable=true, precision=0})
                            lastInteraction = now
                            return
                        end
                        
                        -- CASO 2: Buracos e Alavancas (USAR)
                        if isIdInList(id, useIds) then
                            g_game.use(thing)
                            lastInteraction = now
                            return
                        end
                    end
                end
            end
        end
    end
end

-- ==============================================================
-- 5. EVENTO LOOK
-- ==============================================================
onTextMessage(function(mode, text)
    if not followMacro or not followMacro.isOn() then return end
    if string.find(text, "You see") then
        local name = string.match(text, "You see ([^%.%(]+)")
        if name then
            name = string.gsub(name, "^%s*(.-)%s*$", "%1")
            storage.TurboFollowName = name
            if followEdit then followEdit:setText(name) end
        end
    end
end)

-- ==============================================================
-- 6. MACRO DE ALTA VELOCIDADE (50ms)
-- ==============================================================
followMacro = macro(50, "Turbo Follow", function()
    local player = g_game.getLocalPlayer()
    if not player then return end
    local myPos = player:getPosition()
    if not myPos then return end

    local targetName = storage.TurboFollowName
    if not targetName or targetName == "" then return end

    local target = findTarget(targetName)

    -- 1. Alvo na Tela
    if target then
        local tPos = target:getPosition()
        
        -- Atualiza memória
        lastKnownX, lastKnownY, lastKnownZ = tPos.x, tPos.y, tPos.z
        hasLastPos = true

        local dist = getDist(myPos, tPos)
        
        -- Só anda se estiver longe (evita "dançar" no mesmo piso)
        if dist > config.distance then
            autoWalk(tPos, 10, {ignoreNonPathable=true, precision=1})
        end
        
    -- 2. Alvo Sumiu (Ir para última posição e entrar no portal)
    elseif hasLastPos then
        local lastPos = {x=lastKnownX, y=lastKnownY, z=lastKnownZ}
        local dist = getDist(myPos, lastPos)
        
        if dist > 1 then
            -- Corre para onde ele sumiu
            autoWalk(lastPos, 10, {ignoreNonPathable=true, precision=1})
        else
            -- Chegou no local. Verifica Portais/Buracos
            checkSurroundings(lastPos)
        end
    end
end)
-- =========================================
-- MODULE: General Utilities
-- =========================================
-- Bag opener, item stacker, hotkeys editor

-- Auto-open main bag
macro(1000, "Abrir Bag Principal", function()
    bpItem = getBack()
    bp = getContainer(0)

    if not bp and bpItem ~= nil then
        g_game.open(bpItem)
    end
end)

UI.Separator()

-- Stack Items Automatically
macro(1000, "Juntar itens", function()
    local containers = g_game.getContainers()
    local toStack = {}
    
    for index, container in pairs(containers) do
        if not container.lootContainer then
            for i, item in ipairs(container:getItems()) do
                if item:isStackable() and item:getCount() < 100 then
                    local stackWith = toStack[item:getId()]
                    if stackWith then
                        g_game.move(item, stackWith[1], math.min(stackWith[2], item:getCount()))
                        return
                    end
                    toStack[item:getId()] = {container:getSlotPosition(i - 1), 100 - item:getCount()}
                end
            end
        end
    end
end)

UI.Separator()

-- Hotkeys Editor
UI.Button("Hotkeys", function(newText)
    UI.MultilineEditorWindow(storage.ingame_hotkeys or "", {
        title = "Hotkeys editor", 
        description = "Adicione suas scripts aqui!\n@Luiz"
    }, function(text)
        storage.ingame_hotkeys = text
        reload()
    end)
end)

-- Load hotkeys from storage
for _, scripts in pairs({storage.ingame_hotkeys}) do
    if type(scripts) == "string" and scripts:len() > 3 then
        local status, result = pcall(function()
            assert(load(scripts, "ingame_editor"))()
        end)
        if not status then 
            error("Hotkeys:\n" .. result)
        end
    end
end

UI.Separator()

-- Hotkeys Editor 2
UI.Button("Hotkeys 2", function(newText)
    UI.MultilineEditorWindow(storage.ingame_hotkeys2 or "", {
        title = "Hotkeys editor 2", 
        description = "Adicione suas scripts aqui!\n@Luiz"
    }, function(text)
        storage.ingame_hotkeys2 = text
        reload()
    end)
end)

-- Load hotkeys 2 from storage
for _, scripts in pairs({storage.ingame_hotkeys2}) do
    if type(scripts) == "string" and scripts:len() > 3 then
        local status, result = pcall(function()
            assert(load(scripts, "ingame_editor"))()
        end)
        if not status then 
            error("Ingame editor error:\n" .. result)
        end
    end
end

UI.Separator()

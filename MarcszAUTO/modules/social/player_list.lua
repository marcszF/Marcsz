-- =========================================
-- MODULE: Player List Management
-- =========================================
-- Manage friend and enemy lists

local listPanelName = "playerList"

local ui = setupUI([[
Panel
  height: 18

  Button
    id: editList
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    height: 18
    text: Lista de Amigos
]], parent)

ui:setId(listPanelName)

-- Initialize storage
if not storage[listPanelName] then
    storage[listPanelName] = {
        enemyList = {},
        friendList = {},
        blackList = {},
        groupMembers = true,
        outfits = false,
        marks = false
    }
end

-- Backward compatibility
if not storage[listPanelName].blackList then
    storage[listPanelName].blackList = {}
end

-- Create Player List Window
rootWidget = g_ui.getRootWidget()
playerListWindow = g_ui.createWidget('PlayerListsWindow', rootWidget)
playerListWindow:hide()

playerListWindow.Members:setOn(storage[listPanelName].groupMembers)
playerListWindow.Members.onClick = function(widget)
    storage[listPanelName].groupMembers = not storage[listPanelName].groupMembers
    widget:setOn(storage[listPanelName].groupMembers)
end

-- Load existing friends
if storage[listPanelName].friendList and #storage[listPanelName].friendList > 0 then
    for _, name in ipairs(storage[listPanelName].friendList) do
        local label = g_ui.createWidget("PlayerName", playerListWindow.FriendList)
        label.remove.onClick = function(widget)
            table.removevalue(storage[listPanelName].friendList, label:getText())
            label:destroy()
        end
        label:setText(name)
    end
end

-- Add Friend button
playerListWindow.AddFriend.onClick = function(widget)
    local friendName = playerListWindow.FriendName:getText()
    if friendName:len() > 0 and not table.contains(storage[listPanelName].friendList, friendName, true) then
        table.insert(storage[listPanelName].friendList, friendName)
        local label = g_ui.createWidget("PlayerName", playerListWindow.FriendList)
        label.remove.onClick = function(widget)
            table.removevalue(storage[listPanelName].friendList, label:getText())
            label:destroy()
        end
        label:setText(friendName)
        playerListWindow.FriendName:setText('')
    end
end

-- UI Callbacks
ui.editList.onClick = function(widget)
    playerListWindow:show()
    playerListWindow:raise()
    playerListWindow:focus()
end

playerListWindow.closeButton.onClick = function(widget)
    playerListWindow:hide()
end

-- Creature appear event
onCreatureAppear(function(creature)
    if creature:isPlayer() then
        -- Future: Add auto-detection logic here
    end
end)

addSeparator()

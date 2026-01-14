# Guia de Desenvolvimento - Marcsz Auto

## 🎯 Como Funciona o Sistema de Bot do OTClient

O OTClient carrega arquivos Lua automaticamente em **ordem alfabética** do diretório do bot. Por isso:
- Arquivos com números (0_, 1_, 2_) carregam primeiro
- Arquivos com _ (_main, _vlib) carregam depois  
- A ordem de carregamento é importante!

## 📁 Estrutura Atual

```
MarcszAUTO/
├── 00_README.txt          - Este guia
├── 0_AAmain.lua           - Interface visual (título rainbow)
├── _vlib.lua              - Funções utilitárias (load depois)
├── _main.lua              - Features principais
├── 1_alarms.lua           - Sistema de alarmes
├── 3_Sio.lua              - Cura de amigos
├── 3_player_list.lua      - Lista de jogadores
├── tools.lua              - Ferramentas gerais
├── tools2.lua             - Ferramentas adicionais
├── spy_level.lua          - Visualizar andares
├── MzBugmap.lua           - Bug map
└── Alarme/                - Sons de alarme
```

## ✨ Como Adicionar Nova Funcionalidade

### Método 1: Adicionar no arquivo existente
Se a feature é relacionada a algo que já existe:

1. Abra o arquivo apropriado (ex: `_main.lua` para combat/healing)
2. Adicione sua feature no final
3. Use `UI.Separator()` para organizar visualmente
4. Adicione comentários explicando o que faz

**Exemplo:**
```lua
UI.Separator()

-- =====================================
-- MINHA NOVA FEATURE
-- =====================================
-- Descrição: O que esta feature faz

local config = {
    delay = 1000,
    spell = "exori gran"
}

macro(config.delay, "Minha Feature", function()
    if g_game.isAttacking() then
        say(config.spell)
    end
end)
```

### Método 2: Criar novo arquivo
Para features completamente novas:

1. Crie arquivo com nome descritivo: `minha_feature.lua`
2. Use prefixo numérico se precisar controlar ordem de carregamento
3. Adicione o código
4. Recarregue o bot

**Exemplo de novo arquivo (`4_auto_loot.lua`):**
```lua
-- =====================================
-- AUTO LOOT SYSTEM
-- =====================================
-- Pega itens automaticamente do chão

setDefaultTab("Tools")
UI.Label("Auto Loot")

local lootMacro = macro(500, "Auto Loot", function()
    -- Seu código aqui
end)

UI.Separator()
```

## 🔧 Configurações

### Onde Configurar
- **Boss Timer**: Linha 6-13 do `_main.lua`
- **House Trainer**: Linha 139-144 do `_main.lua`
- **Dodge System**: Linha 224-234 do `_main.lua`
- **Alarmes**: Dentro do `1_alarms.lua`

### Como Mudar Configurações
1. Abra o arquivo
2. Encontre o bloco de configuração (procure por "CONFIG" ou "config")
3. Modifique os valores
4. Salve e recarregue o bot

**Exemplo:**
```lua
-- Mudar horários do boss
local bossConfig = {
    alarmSeconds = 60,
    sound = "AlarmClock.wav",
    raidHours = {
        "02:00", "04:00", "06:00"  -- <-- Modifique aqui
    }
}
```

## 💡 Dicas Importantes

### Variáveis Globais
Variáveis sem `local` são globais e compartilhadas entre arquivos:
```lua
minhaVariavel = 100  -- Global (acessível em todos os arquivos)
local minhaVariavel = 100  -- Local (só neste arquivo)
```

### Storage (Salvar Configurações)
Use `storage` para salvar configurações que persistem:
```lua
if not storage.minhaConfig then
    storage.minhaConfig = {
        enabled = true,
        value = 50
    }
end
```

### Macros
Macros rodam periodicamente:
```lua
-- Roda a cada 1000ms (1 segundo)
macro(1000, "Nome da Macro", function()
    -- Seu código aqui
end)

-- Com hotkey
macro(1000, "Nome", "Ctrl+F", function()
    -- Código
end)
```

### UI Elements
Criar interface:
```lua
UI.Label("Meu Texto")  -- Adiciona texto
UI.Separator()  -- Adiciona separador
UI.Button("Clique", function()  -- Adiciona botão
    -- Ação ao clicar
end)
```

## 🐛 Debug

### Ver Mensagens no Console
```lua
print("Minha mensagem: " .. valor)
```

### Verificar se Algo Existe
```lua
if player and player:getHealthPercent() then
    print("HP: " .. player:getHealthPercent())
end
```

## 📚 Funções Úteis Disponíveis

### Player
```lua
player:getHealthPercent()  -- HP %
player:getManaPercent()    -- Mana %
player:getPosition()       -- Posição
pos()  -- Posição atual (atalho)
```

### Game
```lua
g_game.isOnline()  -- Está online?
g_game.isAttacking()  -- Está atacando?
g_game.use(item)  -- Usar item
say("texto")  -- Falar
```

### Items
```lua
findItem(itemId)  -- Encontrar item no inventário
```

## 🎓 Exemplos Práticos

### Exemplo 1: Auto Spell Simples
```lua
UI.Separator()

macro(1000, "Auto Exura", function()
    if player:getHealthPercent() < 70 then
        say("exura gran")
    end
end)
```

### Exemplo 2: Com Configuração
```lua
UI.Separator()

if not storage.autoHeal then
    storage.autoHeal = {
        enabled = true,
        spell = "exura gran",
        hpPercent = 70
    }
end

local healMacro = macro(1000, "Auto Heal", function()
    if player:getHealthPercent() < storage.autoHeal.hpPercent then
        say(storage.autoHeal.spell)
    end
end)

healMacro.setOn(storage.autoHeal.enabled)
```

### Exemplo 3: Com UI
```lua
UI.Separator()
UI.Label("Meu Sistema de Cura")

local healSpell = "exura gran"

UI.TextEdit(healSpell, function(widget, text)
    healSpell = text
end)

macro(1000, "Heal", function()
    if player:getHealthPercent() < 70 then
        say(healSpell)
    end
end)
```

## ⚠️ Coisas a Evitar

❌ **NÃO** use `dofile()` com caminhos relativos
❌ **NÃO** crie subdirectórios para módulos (OTClient não carrega)
❌ **NÃO** use `require()` (não funciona no OTClient)
✅ **SIM** mantenha tudo em arquivos .lua na pasta MarcszAUTO
✅ **SIM** use prefixos numéricos para controlar ordem
✅ **SIM** teste antes de usar em produção

## 🚀 Próximos Passos

1. Explore os arquivos existentes
2. Copie um exemplo e modifique
3. Teste em ambiente seguro
4. Adicione comentários no seu código
5. Compartilhe suas criações!

---

**Dúvidas?** Leia os comentários nos arquivos ou procure na comunidade OTClient.

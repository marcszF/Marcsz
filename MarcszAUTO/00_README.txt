=====================================
MARCSZ AUTO - Bot para OTClient
=====================================

COMO FUNCIONA:
- OTClient carrega arquivos .lua em ordem alfabética
- Por isso usamos prefixos numéricos (0_, 1_, etc.)
- Arquivos com _ no início carregam depois

ESTRUTURA DE ARQUIVOS:
00_README.txt       - Este arquivo (documentação)
0_AAmain.lua        - Interface visual (título rainbow)
_vlib.lua           - Funções utilitárias compartilhadas
_main.lua           - Features principais (boss timer, heal, attack, etc.)
1_alarms.lua        - Sistema de alarmes
3_Sio.lua           - Sistema de cura de amigos
3_player_list.lua   - Lista de amigos/inimigos
tools.lua           - Ferramentas gerais
tools2.lua          - Ferramentas adicionais  
spy_level.lua       - Visualizar outros andares
MzBugmap.lua        - Sistema de bug map

COMO ADICIONAR NOVAS FUNCIONALIDADES:
1. Crie um novo arquivo .lua com nome descritivo
2. Use prefixo numérico se precisar de ordem específica
3. Adicione comentários claros no código
4. Teste antes de usar em prod

DICAS:
- Variáveis globais são compartilhadas entre arquivos
- Use 'storage' para salvar configurações
- 'macro()' cria funções que rodam periodicamente
- 'UI.Separator()' adiciona separador visual

Para mais informações, veja os comentários nos arquivos.

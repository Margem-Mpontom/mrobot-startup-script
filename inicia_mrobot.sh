#!/bin/bash

# Definindo variáveis para melhor legibilidade
nome_do_servico="MROBOT"
script_de_inicializacao="/etc/init.d/margem.sh"
arquivo_de_log="/Margem/log_reinicio_mrobot"

# Verificando se o script de inicialização existe e é executável
if [ ! -x "$script_de_inicializacao" ]; then
    echo "Erro: O script de inicialização $script_de_inicializacao não existe ou não é executável." >> "$arquivo_de_log"
    exit 1
fi

# Verificando se o serviço está em execução
pid_servico=$(pgrep -x "$nome_do_servico")

if [ -z "$pid_servico" ]; then
    # Iniciando o serviço se não estiver em execução
    cd "$(dirname "$script_de_inicializacao")"
    ./$(basename "$script_de_inicializacao")
    
    # Escrevendo no log
    if [ $? -eq 0 ]; then
        echo "$nome_do_servico estava parado e foi iniciado corretamente - Está em execução com o PID = $(pgrep -x "$nome_do_servico") em $(date)" >> "$arquivo_de_log"
    else
        echo "Erro ao iniciar o serviço $nome_do_servico em $(date)" >> "$arquivo_de_log"
    fi
else
    # Escrevendo no log que o serviço já está em execução
    echo "$nome_do_servico já está ativo com PID = $pid_servico. Processo de reinicialização abortado." >> "$arquivo_de_log"
fi

exit 0

# mrobot-startup-script

## Descrição

O `mrobot-startup-script` é um script de inicialização para o serviço `MROBOT`. Ele verifica se o serviço está em execução e, se não estiver, o inicia e registra a ação em um arquivo de log. Se o serviço já estiver em execução, o script registra que o processo de reinicialização foi abortado.

## Estrutura do Script

### Variáveis

- `nome_do_servico`: Nome do serviço a ser verificado e iniciado (`MROBOT`).
- `script_de_inicializacao`: Caminho para o script de inicialização do serviço (`/etc/init.d/margem.sh`).
- `arquivo_de_log`: Caminho para o arquivo de log onde as ações serão registradas (`/Margem/log_reinicio_mrobot`).

### Verificação do Serviço

O script utiliza o comando `pgrep` para verificar se o serviço está em execução:
```bash
pid_servico=$(pgrep -x $nome_do_servico)
```

## Início do Serviço

- Se o serviço não estiver em execução, o script navega até o diretório do script de inicialização e o executa:

```bash
cd $(dirname $script_de_inicializacao)
./$(basename $script_de_inicializacao)
```
### Registro no Log
- O script registra as ações no arquivo de log especificado:

- Se o serviço foi iniciado:
```bash
echo "$nome_do_servico estava parado e foi iniciado corretamente - Está em execução com o PID = $(pgrep -x $nome_do_servico) em $(date)" >> $arquivo_de_log
```
- Se o serviço já estava em execução:
```bash
echo "$nome_do_servico já está ativo com PID = $pid_servico. Processo de reinicialização abortado." >> $arquivo_de_log
```
## Instalação e Configuração

### Transferir o Script
- Transfira o script para o diretório /etc/init.d/:
```bash
sudo cp /caminho/para/o/seu/inicia_mrobot.sh /etc/init.d/inicia_mrobot.sh
```
### Definir Permissões de Execução
- Certifique-se de que o script tenha permissões de execução:
```bash
sudo chmod +x /etc/init.d/inicia_mrobot.sh
```
### Adicionar aos Níveis de Execução
- Adicione o script aos níveis de execução apropriados:
```bash
sudo update-rc.d inicia_mrobot.sh defaults
```
### Testar o Script
Execute o script manualmente para garantir que ele funcione corretamente:
```bash
sudo /etc/init.d/inicia_mrobot.sh
```
### Verificar na Inicialização
Reinicie o servidor e verifique se o script é executado automaticamente:
```bash
sudo reboot
```
## Contribuição
Se você deseja contribuir com este projeto, sinta-se à vontade para abrir um pull request ou relatar problemas na seção de issues.

## Licença

### Este projeto está licenciado sob a licença MIT. Veja o arquivo LICENSE para mais detalhes.

```bash
Você pode copiar e colar este conteúdo no arquivo `README.md` do seu repositório. Se precisar de mais alguma coisa ou tiver outras perguntas, estou aqui para ajudar!
```

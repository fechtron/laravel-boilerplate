
# Create a empty basic project

`./create-project.sh`


sudo rm -rf database/ app/ storage/


Em caso de erro de permissão ao tentar salvar um arquivo fora do container para ser sincronizado via volumes:
Failed to save 'home.blade.php': Insufficient permissions. Select 'Retry as Sudo' to retry as superuser.

`sudo chown -R $USER:$USER /caminho/para/seu/projeto`

`sudo chown -R $USER:$USER .`


cmd()
{
    shell=$1
    #echo $shell
    $shell
}

cmd "sudo ufw disable"
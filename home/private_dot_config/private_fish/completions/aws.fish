function __aws_cli_completer
    command -q aws_completer; or return

    set -lx COMP_LINE (commandline -cp)
    set -lx COMP_POINT (string length -- "$COMP_LINE")
    command aws_completer
end

complete --command aws --erase
complete --command aws --no-files --arguments '(__aws_cli_completer)'

# kubectl + kubecolor — interactive only, so scripts get a plain, uncolored kubectl
if status is-interactive
    if command -q kubectl; and command -q kubecolor
        set -gx KUBECOLOR_PRESET light

        function kubectl --wraps kubectl --description 'kubectl with kubecolor output'
            command kubecolor $argv
        end
        function k --wraps kubectl --description 'kubectl shorthand with kubecolor output'
            command kubecolor $argv
        end
        function kubecolor --wraps kubectl --description 'kubecolor with kubectl completions'
            command kubecolor $argv
        end
        complete -c k -w kubectl
        complete -c kubecolor -w kubectl
    else if command -q kubectl
        alias k kubectl
    end

    command -q kubectx; and alias kx kubectx
    command -q kubens; and alias kn kubens
end

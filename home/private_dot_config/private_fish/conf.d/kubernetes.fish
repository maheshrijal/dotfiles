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

    # Abbreviations, not aliases — these expand inline so the full command stays
    # visible and editable before it runs (matters when appending -n/--context).
    if command -q kubectl
        abbr -a kgp 'k get pod'
        abbr -a kgd 'k get deploy'
        abbr -a kgn 'k get nodes'
        abbr -a kgi 'k get ing'
        abbr -a kgs 'k get svc'
        abbr -a kdp 'k describe pod'
        abbr -a klf 'k logs -f'
        # 'kroll', not 'krr' — krr is Robusta's resource recommender on PATH
        abbr -a kroll 'k rollout restart'
        abbr -a kex 'k exec -ti'
    end
end

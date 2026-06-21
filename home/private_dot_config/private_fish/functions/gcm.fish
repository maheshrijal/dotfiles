function gcm --description 'Checkout the default branch, preferring main over master'
    if not git rev-parse --is-inside-work-tree >/dev/null 2>&1
        echo "gcm: not in a git repository" >&2
        return 1
    end

    for branch in main master
        if git show-ref --verify --quiet refs/heads/$branch
            git checkout $branch
            return $status
        end

        if git show-ref --verify --quiet refs/remotes/origin/$branch
            git checkout --track origin/$branch
            return $status
        end
    end

    echo "gcm: neither 'main' nor 'master' exists in this repository" >&2
    return 1
end

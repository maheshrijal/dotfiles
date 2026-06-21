function getip --description 'Show public IPv4 and IPv6 addresses'
    curl -4 icanhazip.com
    and curl -6 icanhazip.com
end

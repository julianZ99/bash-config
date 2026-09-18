# Custom

# System update
up() {
    sudo xbps-install -Su "$@"
    flatpak update -y
}

# Docker

# Real-time logs of all running containers (new logs only)
dlogs() {
    local c ids
    ids=($(docker ps -q))
    if [ ${#ids[@]} -eq 0 ]; then
        echo "no running containers"
        return 1
    fi
    for c in "${ids[@]}"; do
        docker logs -f --tail 0 "$c" &
    done
    trap 'kill $(jobs -p) 2>/dev/null' EXIT INT
    wait
}

# Compose shortcuts (run from the compose file directory)
dcu() {
    docker compose up -d "$@"
}
dcd() {
    docker compose down "$@"
}
dcl() {
    docker compose logs -f "$@"
}
dcr() {
    docker compose up -d --build "$@" && docker compose logs -f
}

# Enter a container shell (bash, falling back to sh)
dsh() {
    docker exec -it "$1" "${DOCKER_SHELL:-bash}" 2>/dev/null || docker exec -it "$1" sh
}

# Docker daemon + containerd (runit on Void)
dservice() {
    case "${1:-status}" in
        up)
            sudo sv up docker containerd
            ;;
        down)
            # stop containers first: the containerd shims outlive the daemons
            local ids
            if [ -S /var/run/docker.sock ]; then
                ids=($(docker ps -q))
                [ ${#ids[@]} -gt 0 ] && docker stop "${ids[@]}"
            fi
            sudo sv down docker containerd
            # force-kill any container processes left behind by orphaned shims
            for cg in /sys/fs/cgroup/docker/*; do
                [[ "$cg" == *buildkit* ]] && continue
                [ -f "$cg/cgroup.kill" ] && echo 1 | sudo tee "$cg/cgroup.kill" >/dev/null 2>&1
            done
            ;;
        restart)
            sudo sv restart docker containerd
            ;;
        status)
            sudo sv status docker containerd
            ;;
        *)
            echo "usage: dservice {up|down|restart|status}"
            ;;
    esac
}

# Prune unused containers, images and volumes
dprune() {
    docker system prune -af --volumes
}
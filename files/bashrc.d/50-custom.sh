# Custom

# System update
up() {
    sudo xbps-install -Su "$@"
    flatpak update -y
}

# Docker

# Real-time logs of all running containers (new logs only)
dlogs() {
    local c
    for c in $(docker ps -q); do
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
        up)      sudo sv up docker containerd ;;
        down)    sudo sv down docker containerd ;;
        restart) sudo sv restart docker containerd ;;
        status)  sudo sv status docker containerd ;;
        *)       echo "usage: dservice {up|down|restart|status}" ;;
    esac
}

# Prune unused containers, images and volumes
dprune() {
    docker system prune -af --volumes
}
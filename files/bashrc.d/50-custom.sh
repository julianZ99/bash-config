# Custom

# System update
up() {
    sudo xbps-install -Su "$@"
    flatpak update -y
}
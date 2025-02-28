#!/bin/bash 
 
# Update package list 
sudo apt-get update 
 
# Install Python3 and pip 
sudo apt-get install -y python3 python3-pip 
 
# Variabel untuk versi Go yang akan diinstal 
GO_VERSION="1.22.1" 
GO_TARBALL="go$GO_VERSION.linux-amd64.tar.gz" 
GO_URL="https://go.dev/dl/$GO_TARBALL" 
INSTALL_DIR="/usr/local" 
 
# Fungsi untuk menampilkan pesan 
log() { 
    echo "[INFO] $1" 
} 
 
# Periksa apakah Go sudah terinstal 
if command -v go &>/dev/null; then 
    log "Go sudah terinstal." 
else 
    log "Mengunduh Go..." 
    wget -q "$GO_URL" -O "/tmp/$GO_TARBALL" 
    log "Ekstrak Go ke $INSTALL_DIR..." 
    sudo tar -C "$INSTALL_DIR" -xzf "/tmp/$GO_TARBALL" 
    rm "/tmp/$GO_TARBALL" 
fi 
 
# Tambahkan konfigurasi PATH ke ~/.zshrc 
log "Menambahkan konfigurasi PATH ke ~/.zshrc" 
CONFIG_FILE="$HOME/.zshrc" 
CONFIG_CONTENT="\n# Go Environment\nexport PATH=\$PATH:/usr/local/go/bin\nexport GOPATH=\$HOME/go\nexport PATH=\$PATH:\$GOPATH/bin\nexport PATH=\$PATH:\$HOME/.local/bin\n" 
 
grep -qxF "export PATH=\$PATH:/usr/local/go/bin" "$CONFIG_FILE" || echo -e "$CONFIG_CONTENT" >> "$CONFIG_FILE" 
 
# Instruksi kepada pengguna 
log "Silakan jalankan 'source ~/.zshrc' agar perubahan langsung berlaku." 
 
# Periksa apakah Go telah terinstal dengan benar 
if command -v go &>/dev/null; then 
    log "Instalasi Go berhasil. Gunakan 'go version' untuk memverifikasi." 
else 
    log "Instalasi gagal. Pastikan dependencies seperti wget dan tar telah terinstal." 
    log "Pada Kali Linux, jalankan: sudo apt update && sudo apt install wget tar -y" 
fi 
 
# Install required tools 
sudo apt-get install -y sublist3r amass assetfinder subfinder dirsearch lolcat masscan 
 
# Install Go-based tools 
echo "Installing Go-based tools..." 
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest 
go install github.com/tomnomnom/waybackurls@latest 
go install -v github.com/PentestPad/subzy@latest 
go install github.com/projectdiscovery/katana/cmd/katana@latest 
go install github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest 
go install github.com/ffuf/ffuf@latest 
go install github.com/phor3nsic/kxss@latest 
go install github.com/KathanP19/Gxss@latest 
 
# Install Python modules with --break-system-packages 
echo "Installing Python modules..." 
pip3 install -r requirements.txt --break-system-packages  
 
echo "Installation complete!"
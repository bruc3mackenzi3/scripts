VERSION="1.19"
OS=linux
ARCH=amd64
INSTALL_PATH="/usr/local"

CHOICE="none"
echo "Remove existing go installation(s), [y]es or [n]o?"
read CHOICE
if [[ $CHOICE == "y" ]]; then
    sudo rm -rf /usr/local/go* && sudo rm -rf /usr/local/go
elif [[ $CHOICE != "n" ]]; then
    1>&2 echo "Invalid option \"$CHOICE\""
    exit 1
fi

cd $HOME
wget https://storage.googleapis.com/golang/go$VERSION.$OS-$ARCH.tar.gz
if [[ ! -f go$VERSION.$OS-$ARCH.tar.gz ]]; then
    1>&2 echo "Faiiled to download Go tarball, file not found. Exiting."
    exit 1
fi

echo "Installing Go..."
tar -xvf "go$VERSION.$OS-$ARCH.tar.gz"
# Rename the Go installation folder to the specific version.  This has benefits:
# - easier to keep track of the version installed
# - compatibility with multiple Go installations
mv "go" "go-$VERSION"
sudo mv "go-$VERSION" $INSTALL_PATH
rm "go$VERSION.$OS-$ARCH.tar.gz"

# Create GOPATH directory if doesn't already exist
mkdir -p ~/go

echo "Go installed at $INSTALL_PATH/go-$VERSION"
echo "Remember to add GOPATH and GOROOT bin directories to PATH environment variable."

echo "Testing \"go env GOROOT\": $(go env GOROOT)"

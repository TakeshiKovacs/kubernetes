# First of all, what is Istio?  Istio is a service mesh
# Ok, so what is a service mesh?

# A service mesh is an infrastructure layer that gives applications capabilities like zero-trust security, observability, and advanced traffic management, without code changes.

# Lets go home
cd ~

# Install istio command line
curl -L https://istio.io/downloadIstio | sh -

# Note the version you downloaded and switch to the directory
# use ls to list directories if you are not sure
cd istio-<version>

# Update you bash profile with the istio cmd line tool added to path, 
# then reload your bash profile to pickup the change
echo 'export PATH=$HOME/istio-<version>/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

# If you get the following error:
# bash: version: No such file or directory
# You probably forgot the replace <version> in the echo command above
# run nano ~/.bashrc and hit ctrl-end then update the command to use the correct version

# Confirm the istio cmd line is working
istioctl version

# Install istio onto your cluster
istioctl install --set profile=demo -y
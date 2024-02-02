set -eux
#To follow conda-forge's best practices, we got the sources via a tarball, but
#simplebuild uses setuptools-git-versioning which gets the version from the git
#tag. So we initialise a git repo and add the version tag.
git init
git config init.defaultBranch main
git config user.email "${PKG_NAME}-feedstock@noreply.github.com"
git config user.name "Dummy Name"
git add .
git commit -m "Source version v${PKG_VERSION}"
git tag v${PKG_VERSION}
python -m pip install --no-deps -vv .
mkdir -p "${PREFIX}/etc/conda/activate.d"
mkdir -p "${PREFIX}/etc/conda/deactivate.d"
cp ./resources/shellrc_snippet.sh \
   "${PREFIX}/etc/conda/activate.d/${PKG_NAME}_activate.sh"
cp ./resources/shellrc_snippet_deactivate.sh \
   "${PREFIX}/etc/conda/deactivate.d/${PKG_NAME}_deactivate.sh"

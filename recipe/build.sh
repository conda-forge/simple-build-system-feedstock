set -eux
#To follow conda-forge's best practices, we got the sources via a tarball, but
#simplebuild uses setuptools-git-versioning which gets the version from the git
#tag. So we initialise a git repo and add the version tag.
#
# NOTICE: We can not use a pypi sdist package as source (as is done in the
# simple-build-dgcode package), since it does not currently include the
# ./resources/shellrc_snippet.sh and ./resources/shellrc_snippet_deactivate.sh
# files. This should eventually change and is tracked at
# https://github.com/mctools/simplebuild/issues/60
#
git init
git config init.defaultBranch main
git config user.email "${PKG_NAME}-feedstock@noreply.github.com"
git config user.name "Dummy Name"
git add .
git commit -m "Source version v${PKG_VERSION}"
git tag v${PKG_VERSION} -m "Tagging v${PKG_VERSION}"
git log
python -m pip install --no-deps -vv .
mkdir -p "${PREFIX}/etc/conda/activate.d"
mkdir -p "${PREFIX}/etc/conda/deactivate.d"
cp ./resources/shellrc_snippet.sh \
   "${PREFIX}/etc/conda/activate.d/${PKG_NAME}_activate.sh"
cp ./resources/shellrc_snippet_deactivate.sh \
   "${PREFIX}/etc/conda/deactivate.d/${PKG_NAME}_deactivate.sh"

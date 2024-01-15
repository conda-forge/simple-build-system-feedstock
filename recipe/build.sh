set -eux
python -m pip install --no-deps -vv .
mkdir -p "${PREFIX}/etc/conda/activate.d"
mkdir -p "${PREFIX}/etc/conda/deactivate.d"
cp ./resources/shellrc_snippet.sh \
   "${PREFIX}/etc/conda/activate.d/${PKG_NAME}_activate.sh"
cp ./resources/shellrc_snippet_deactivate.sh \
   "${PREFIX}/etc/conda/deactivate.d/${PKG_NAME}_deactivate.sh"

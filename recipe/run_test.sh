set -eux
pip list
pip check
#Verify pkg version also works on python level:
python -c 'from importlib.metadata import version as v;from os import environ as e;assert e["PKG_VERSION"]==v(e["PKG_NAME"])'
#Explicitly source activation script, since the test environment apparently does
#not always trigger these scripts automatically.
test -f "${PREFIX}/etc/conda/activate.d/simple-build-system_activate.sh"
. "${PREFIX}/etc/conda/activate.d/simple-build-system_activate.sh"
sb --help
python3 -c 'import _simple_build_system._cli'
unwrapped_simplebuild --help
mkdir testsbproj
cd testsbproj
sb --init core_val COMPACT
test -f simplebuild.cfg
cat simplebuild.cfg
sb -t
sb_core_extdeps --require-disabled NCrystal Numpy matplotlib Geant4 ZLib
python3 -c 'import _simple_build_system.envsetup as sbe; sbe.verify_env_already_setup()'
eval "$(sb --env-setup)"
sb_core_extdeps --require-disabled NCrystal Numpy matplotlib Geant4 ZLib
eval "$(sb --env-unsetup)"
EC=0
sb_core_extdeps || EC=$?
test $EC -ne 0
sbenv sb_core_extdeps --require-disabled NCrystal Numpy matplotlib Geant4 ZLib

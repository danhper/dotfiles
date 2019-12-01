set history save on
set non-stop on
set target-async on

python
import sys
from os import path

BOOST_PP_PATH = path.expanduser('~/.local/opt/Boost-Pretty-Printer')
LIBSTD_PP_PATH = path.expanduser('~/.local/opt/libstd-pretty-printer')

if path.exists(BOOST_PP_PATH ):
    sys.path.insert(0, BOOST_PP_PATH)
    import boost
    boost.register_printers(boost_version=(1,69,0))
if path.exists(LIBSTD_PP_PATH):
    sys.path.insert(0, path.expanduser(LIBSTD_PP_PATH))
    from libstdcxx.v6.printers import register_libstdcxx_printers
    register_libstdcxx_printers (None)
end

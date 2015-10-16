from distutils.core import setup, Extension
from Cython.Build import cythonize

extensions = [ Extension("lib/windows/*", ["lib/windows/*.pyx"]) ]
setup(
    ext_modules = cythonize(extensions)
)

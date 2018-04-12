set R=%CD%
cd /D %R%

copy bin\x64\Debug_CUDA\AstraCuda64D.dll "%CONDA_PREFIX%\Library\bin\AstraCuda64.dll"
copy bin\x64\Debug_CUDA\AstraCuda64D.lib "%CONDA_PREFIX%\Library\lib\AstraCuda64.lib"
copy "%CUDA_PATH%\bin\cudart64_80.dll" "%CONDA_PREFIX%\Library\bin"
copy "%CUDA_PATH%\bin\cufft64_80.dll" "%CONDA_PREFIX%\Library\bin"

cd python

rd /s /q build
rd /s /q "%CONDA_PREFIX%\lib\site-packages\astra"

set VS90COMNTOOLS=%VS140COMNTOOLS%
set CL=/DASTRA_CUDA /DASTRA_PYTHON
set INCLUDE=%R%\include;%R%\lib\include;%CUDA_PATH%\include
copy "%CONDA_PREFIX%\Library\lib\AstraCuda64.lib" astra.lib
python builder_debug.py build_ext --compiler=msvc install
copy "%CONDA_PREFIX%\Library\bin\AstraCuda64.dll" "%CONDA_PREFIX%\lib\site-packages\astra"

cd /D %R%
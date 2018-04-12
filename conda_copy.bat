set R=%CD%
cd /D %R%

copy bin\x64\Release_CUDA\AstraCuda64.dll "%CONDA_PREFIX%\Library\bin\AstraCuda64.dll"
copy bin\x64\Release_CUDA\AstraCuda64.lib "%CONDA_PREFIX%\Library\lib\AstraCuda64.lib"
copy "%CUDA_PATH%\bin\cudart64_80.dll" "%CONDA_PREFIX%\Library\bin"
copy "%CUDA_PATH%\bin\cufft64_80.dll" "%CONDA_PREFIX%\Library\bin"

cd python

rd /s /q build
rd /s /q "%CONDA_PREFIX%\lib\site-packages\astra"

set VS90COMNTOOLS=%VS140COMNTOOLS%
REM set CL=/DASTRA_CUDA /DASTRA_PYTHON "/I%R%\include" "/I%R%\lib\include" "/I%CUDA_PATH%\include"
set CL=/DASTRA_CUDA /DASTRA_PYTHON
set INCLUDE=%R%\include;%R%\lib\include;%CUDA_PATH%\include
copy "%CONDA_PREFIX%\Library\lib\AstraCuda64.lib" astra.lib
python builder.py build_ext --compiler=msvc install
copy "%CONDA_PREFIX%\Library\bin\AstraCuda64.dll" "%CONDA_PREFIX%\lib\site-packages\astra"

cd /D %R%
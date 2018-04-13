cd /D %~dp0
cd ..\..
set R=%CD%

call "%~dp0build_env.bat"
call "%B_VC%\vcvars64.bat"

copy bin\x64\Debug_CUDA\AstraCuda64D.dll "%CONDA_PREFIX%\Library\bin\AstraCuda64D.dll"
copy bin\x64\Debug_CUDA\AstraCuda64D.lib "%CONDA_PREFIX%\Library\lib\AstraCuda64D.lib"
copy "%CUDA_PATH%\bin\cudart64_80.dll" "%CONDA_PREFIX%\Library\bin"
copy "%CUDA_PATH%\bin\cufft64_80.dll" "%CONDA_PREFIX%\Library\bin"

cd python

rd /s /q build
del /q "%CONDA_PREFIX%\lib\site-packages\astra"
rd /s /q "%CONDA_PREFIX%\lib\site-packages\astra"

copy "%CONDA_PREFIX%\Library\lib\AstraCuda64D.lib" astra.lib
python builder_debug.py build_ext --compiler=msvc install
copy "%CONDA_PREFIX%\Library\bin\AstraCuda64D.dll" "%CONDA_PREFIX%\lib\site-packages\astra"

cd /D %R%

pause
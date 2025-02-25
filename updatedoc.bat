@echo off
setlocal

:: Configuración
set REPO_URL=https://github.com/LeRayRC/3PVG_PMG_garciaroi_riverodi.git
set CLONE_DIR=temp_repo
set DOXYFILE=doc\Doxyfile
set SOURCE_DIR=%CLONE_DIR%\doc\html  :: Carpeta cuyo contenido quieres mover

set DOXYGEN_PATH=C:\Program Files\doxygen\bin\doxygen.exe


echo Clonando el repositorio...
git clone %REPO_URL% %CLONE_DIR%

if errorlevel 1 (
    echo Error al clonar el repositorio.
    exit /b 1
)

cd %CLONE_DIR%

echo Generando documentación con Doxygen...
"%DOXYGEN_PATH%" %DOXYFILE% HTML_OUTPUT=.. OUTPUT_DIRECTORY=..\

if errorlevel 1 (
    echo Error al generar la documentación.
    cd .. 
    rmdir /s /q %CLONE_DIR%
    exit /b 1
)

cd ..

xcopy /E /I /Y .\temp_repo\doc\html\ .

echo Eliminando el repositorio clonado...
rmdir /s /q %CLONE_DIR%

echo Proceso completado.

git add .
git commit -m "doc: update doc from script"
git push
exit /b 0

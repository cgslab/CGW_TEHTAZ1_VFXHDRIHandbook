@echo off
setlocal enabledelayedexpansion

:: Darktable CLIのパス
set "dt_cli=C:\Program Files\darktable\bin\darktable-cli.exe"
:: dtstyleのパス
set "Style=--verbose --out-ext tif --hq 0 --style THETA_Z1_HDRI_IDT_REC2020_v2 --style-overwrite"
:: Configディレクトリのパス
::Config_dirのUSERNAMEをdtstyleが配置されるユーザー名に変更してください
set "Config_dir=--core --conf C:\Users\USERNAME\.config\darktable\"

:: 入力ディレクトリと出力ディレクトリの入力
set /p "In_dir=Input Directory: "
set /p "Out_dir=Output Directory: "

:: パスの末尾のバックスラッシュを削除（もし存在する場合）
if "%In_dir:~-1%"=="\" set "In_dir=%In_dir:~0,-1%"
if "%Out_dir:~-1%"=="\" set "Out_dir=%Out_dir:~0,-1%"

:: バックスラッシュをスラッシュに置換
set "In_dir=%In_dir:\=/%"
set "Out_dir=%Out_dir:\=/%"

:: 入力ディレクトリのファイルを処理
for %%f in ("%In_dir%\*.*") do (
    set "input_path=%%f"
    set "file_name=%%~nf"
    set "output_path=%Out_dir%/%!file_name!.tif"

    echo Processing: !input_path!
    "%dt_cli%" "!input_path!" "!output_path!" %Style% %Config_dir%
    if errorlevel 1 (
        echo Error occurred during processing !input_path!
    )
    echo ----------------------
)

echo Processing complete.
pause

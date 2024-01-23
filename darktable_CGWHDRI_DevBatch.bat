@echo off
setlocal enabledelayedexpansion

:: Darktable CLIのパス
set "dt_cli=C:\Program Files\darktable\bin\darktable-cli.exe"
:: dtstyleのパス
set "Style=--hq 0 --style THETA_Z1_HDRI_IDT_REC2020_v2 --style-overwrite --out-ext tiff --icc-file"
:: ICCプロファイルのパス
set "Icc_file=C:\Users\(USERNAME)\AppData\Local\darktable\color\out\REC2020(Rec709 Gamma).icc"
:: tiffオプション
set "tiff_option=--verbose  --core --conf plugins/imageio/format/tiff/bpp=16 plugins/imageio/format/tiff/bcompress=2 plugins/imageio/format/tiff/compresslevel=5"

:: 入力ディレクトリと出力ディレクトリの入力
set /p "In_dir=Input Directory: "
set /p "Out_dir=Output Directory: "

:: パスの末尾のバックスラッシュを削除（もし存在する場合）
if "%In_dir:~-1%"=="\" set "In_dir=%In_dir:~0,-1%"
if "%Out_dir:~-1%"=="\" set "Out_dir=%Out_dir:~0,-1%"

:: バックスラッシュをスラッシュに置換
set "In_dir=%In_dir:\=/%"
set "Out_dir=%Out_dir:\=/%"

echo !In_dir!
:: 入力ディレクトリのファイルを処理
for %%f in ("%In_dir%\*.*") do (
    set "input_path=%%f"
    echo loading file=!input_path!
    set "file_name=%%~nf"
    set "output_path=!Out_dir!/%!file_name!"
    echo "%dt_cli%" "!input_path!" "!output_path!" !Style! "!Icc_file!" !tiff_option! !Config_dir!
    echo ----------------------
    echo Processing: !input_path!
    "%dt_cli%" "!input_path!" "!output_path!" !Style! "!Icc_file!" !tiff_option! !Config_dir!

    if errorlevel 1 (
        echo Error occurred during processing !input_path!
    )
    echo ======================
)

echo Processing complete.
pause

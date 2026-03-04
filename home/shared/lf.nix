{ config, pkgs, lib, ... }:

{
  home.packages = [ pkgs.lf ];

  xdg.configFile."lf/lfrc".text = ''
    # Settings
    set hidden false
    set ignorecase true
    set icons true
    set relativenumber true
    set number true
    set dircounts true

    set previewer ~/.config/lf/preview
    set cleaner ~/.config/lf/cleaner

    set rulerfmt "  %a|  %p|  \033[7;31m %m \033[0m|  \033[7;33m %c \033[0m|  \033[7;35m %s \033[0m|  \033[7;34m %f \033[0m|  %i/%t"
    set statfmt "\033[36m%p\033[0m| %c| %u| %g| %s| %t| -> %l"

    cmd mkdir %{{
      printf "Directory Name: "
      read ans
      mkdir $ans
    }}

    cmd mkfile %{{
      printf "File Name: "
      read ans
      touch $ans
    }}

    cmd unarchive ''${{
      case "$f" in
        *.zip)               unzip -o "$f" ;;
        *.tar.gz | *.tgz)   tar -xzvf "$f" ;;
        *.tar.bz2 | *.tbz2) tar -xjvf "$f" ;;
        *.tar.xz | *.txz)   tar -xJvf "$f" ;;
        *.tar)               tar -xvf "$f" ;;
        *.jar)               jar -xvf "$f" ;;
        *.rar)               unrar x "$f" ;;
        *)
          echo "Unsupported archive format: $f"
          return 1
          ;;
      esac
    }}

    cmd archive_zip    ''${{ zip -r "$f.zip" "$f" }}
    cmd archive_tar    ''${{ tar -cvf "$f.tar" "$f" }}
    cmd archive_tar_gz ''${{ tar -czvf "$f.tar.gz" "$f" }}
    cmd trash          ''${{ mv "$fx" ~/.trash }}
    cmd force_delete   ''${{ rm -rf "$fx" }}

    cmd quit_and_cd &{{
      pwd > "$LF_CD_FILE"
      lf -remote "send $id quit"
    }}

    cmd open ''${{
      case "$(file --mime-type -b "$f")" in
        application/pdf)
          xdg-open "$f"
          ;;
        text/* | application/json | application/xml | application/javascript | application/x-shellscript)
          if [ -n "$fs" ]; then
            nvim -p $fs
          else
            nvim -p "$f"
          fi
          ;;
        image/*)
          xdg-open "$f"
          ;;
        application/zip | application/x-tar | application/gzip | application/x-bzip2)
          unarchive
          ;;
        *)
          if [ -n "$fs" ]; then
            nvim -p $fs
          else
            nvim -p "$f"
          fi
          ;;
      esac
    }}

    map d
    map m

    map za unarchive
    map zz archive_zip
    map zt archive_tar
    map zg archive_tar_gz

    map dd trash
    map dD force_delete

    map . set hidden!

    map p paste
    map x cut
    map y copy
    map c :clear; unselect

    map V invert
    map v invert-below

    map R reload

    map mf mkfile
    map md mkdir

    map Q quit_and_cd

    map <up>    echo "\033[1;31m⚠ Use hjkl\033[0m"
    map <down>  echo "\033[1;31m⚠ Use hjkl\033[0m"
    map <left>  echo "\033[1;31m⚠ Use hjkl\033[0m"
    map <right> echo "\033[1;31m⚠ Use hjkl\033[0m"

    map gd cd ~/Desktop
    map gD cd ~/Documents
    map gg cd ~/Downloads
    map gp cd ~/Pictures
    map gc cd ~/Dotfiles
    map gt cd ~/.Trash
  '';

  home.file.".config/lf/preview" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      file="$1"
      w="$2"
      h="$3"
      x="$4"
      y="$5"

      TEMPDIR="''${XDG_CACHE_HOME:-$HOME/.cache}/lf"
      mkdir -p "$TEMPDIR"

      preview() {
        [[ -f "$1" ]] || return 1
        kitty +kitten icat \
          --silent \
          --stdin no \
          --transfer-mode file \
          --place "''${w}x''${h}@''${x}x''${y}" \
          "$1" < /dev/null > /dev/tty
      }

      ext="''${file##*.}"
      ext_lower="$(echo "$ext" | tr '[:upper:]' '[:lower:]')"

      if command -v md5sum >/dev/null 2>&1; then
        thumbnail="$TEMPDIR/$(echo "$file" | md5sum | cut -d' ' -f1).png"
      else
        thumbnail="$TEMPDIR/thumbnail.png"
      fi

      case "$ext_lower" in
        tar|tgz|tbz|tbz2|txz|tlz) tar tf "$file" 2>/dev/null || echo "Failed to read archive" ;;
        gz|bz2|xz)                 tar tf "$file" 2>/dev/null || file "$file" ;;
        zip)                       unzip -l "$file" 2>/dev/null || echo "Failed to read zip" ;;
        rar)                       unrar l "$file" 2>/dev/null || echo "Failed to read rar" ;;
        7z)                        7z l "$file" 2>/dev/null || echo "Failed to read 7z" ;;

        avi|mp4|mkv|mov|webm|flv|wmv|m4v|mpg|mpeg)
          if command -v ffmpegthumbnailer >/dev/null 2>&1; then
            ffmpegthumbnailer -i "$file" -o "$thumbnail" -s 900 2>/dev/null && preview "$thumbnail"
          else
            mediainfo "$file" 2>/dev/null || file "$file"
          fi ;;

        pdf)
          if [[ -f "$thumbnail" && "$thumbnail" -nt "$file" ]]; then
            preview "$thumbnail"
          elif command -v pdftocairo >/dev/null 2>&1; then
            pdftocairo -png -singlefile -f 1 -l 1 -scale-to-x 1200 -scale-to-y -1 "$file" "''${thumbnail%.png}" 2>/dev/null
            [[ -f "$thumbnail" ]] && preview "$thumbnail"
          elif command -v pdftotext >/dev/null 2>&1; then
            pdftotext -l 10 "$file" - 2>/dev/null
          else
            echo "PDF: $(basename "$file")"
          fi ;;

        jpg|jpeg|png|webp|gif|bmp|tiff|tif|ico) preview "$file" ;;

        svg)
          if command -v rsvg-convert >/dev/null 2>&1; then
            rsvg-convert -w 1920 "$file" -o "$thumbnail" 2>/dev/null && preview "$thumbnail"
          else
            head -n 50 "$file"
          fi ;;

        mp3|flac|m4a|aac|ogg|opus|wav|wma)
          command -v mediainfo >/dev/null 2>&1 && mediainfo "$file" || file "$file" ;;

        docx|doc|odt)
          command -v pandoc >/dev/null 2>&1 && pandoc "$file" -t plain 2>/dev/null | head -n 200 || file "$file" ;;

        md|markdown)
          if command -v glow >/dev/null 2>&1; then
            glow -s dark "$file" 2>/dev/null
          elif command -v bat >/dev/null 2>&1; then
            bat --style numbers --color=always --theme=base16 "$file"
          else
            cat "$file"
          fi ;;

        json)
          if command -v jq >/dev/null 2>&1; then
            jq -C . "$file" 2>/dev/null || cat "$file"
          elif command -v bat >/dev/null 2>&1; then
            bat --style numbers --color=always --theme=base16 -l json "$file"
          else
            cat "$file"
          fi ;;

        *)
          if [[ -d "$file" ]]; then
            ls -lAh --color=always "$file" 2>/dev/null
          elif command -v bat >/dev/null 2>&1; then
            bat --style numbers --color=always --theme=base16 "$file" 2>/dev/null
          else
            cat "$file"
          fi ;;
      esac
      exit 127
    '';
  };

  home.file.".config/lf/cleaner" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      kitty +kitten icat --clear --stdin no --silent --transfer-mode file < /dev/null > /dev/tty
      TEMPDIR="''${XDG_CACHE_HOME:-$HOME/.cache}/lf"
      rm -f "$TEMPDIR"/*.png
    '';
  };

  home.file.".config/lf/icons".source = ./assets/lf-icons;
}

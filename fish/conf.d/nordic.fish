# Nordic — https://github.com/AlexvZyl/nordic.nvim
set -g fish_color_normal 81A1C1
set -g fish_color_command EBCB8B
set -g fish_color_keyword B48EAD
set -g fish_color_quote A3BE8C
set -g fish_color_redirection D8DEE9
set -g fish_color_end BBC3D4
set -g fish_color_error C5727A
set -g fish_color_param 88C0D0
set -g fish_color_comment 4C566A
set -g fish_color_selection --background=3B4252
set -g fish_color_search_match --background=1E222A
set -g fish_color_operator D08770
set -g fish_color_escape 81A1C1
set -g fish_color_autosuggestion 60728A
set -g fish_pager_color_progress 81A1C1
set -g fish_pager_color_prefix EBCB8B
set -g fish_pager_color_completion D8DEE9
set -g fish_pager_color_description 81A1C1
set -g fish_pager_color_selected_background --background=3B4252

# Nordic palette for fzf.
set -Ux FZF_DEFAULT_OPTS "\
--color=bg+:#2e3440,bg:#242933,spinner:#b48ead,hl:#d08770 \
--color=fg:#c0c8d8,header:#b48ead,info:#81a1c1,pointer:#c5727a \
--color=marker:#a3be8c,fg+:#d8dee9,prompt:#81a1c1,hl+:#d08770 \
--color=selected-bg:#3b4252 \
--color=border:#4c566a,label:#c0c8d8"

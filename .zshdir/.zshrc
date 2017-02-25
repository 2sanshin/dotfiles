##Prompt
PROMPT="%{[32m%}%T %m>%{[m%}"
RPROMPT='%{[36m%}%~%{[m%}'

if [ $TERM = "xterm" -o $TERM = "kterm" -o $TERM = "xterm-256color" ]
then
  hostname=`hostname -s`
  function _setcaption() { echo -ne  "\e]1;${hostname}\a\e]2;${hostname}$1\a" > /dev/tty }

#  function chpwd() {  print -Pn "\e]2; [%m] : %~\a" }
#   (cd . )
#  chpwd
#  precmd () {print -Pn "\e]0;%n@%m\a"}

   #for special command
#  function _cmdcaption() { _setcaption " ($1)"; "$@"; chpwd }
#
#  for cmd in telnet slogin ssh rlogin rsh su sudo
#  do
#    alias $cmd="_cmdcaption $cmd"
#  done
fi

### mask
umask 022

### Complete control
#compctl -v -x 's[DISPLAY=]' -k hosts -S ':0' -- export
#compctl -c man jman which
#compctl -x 's[-]' -k signals -- kill

#ports name comp
#fpath、FPATHのどちらでもよい。fpathはスペース区切り、FPATHはコロン区切り
#fpath=(/usr/local/share/zsh-completions $fpath)
fpath=(~/.zshdir/functions $fpath)
#fpath=(~/.zshdir/functions/zload(N-/) $fpath)
#rm -f ~/.zshdir/.zcompdump;
#autoload -Uz compinit; compinit
#autoload -Uz compinit
#autoload -Uz peco-select-history; peco-select-history
#autoload -Uz ~/.zshdir/functions/*(:t)
#autoload -Uz zload

### Set shell option
setopt AUTO_CD
# 補完候補が複数ある時に、一覧表示する
setopt AUTO_LIST
# TAB で順に補完候補を切り替える
setopt AUTO_MENU
# ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt AUTO_PARAM_SLASH
# cd -[tab] でpushd
setopt AUTO_PUSHD
# シンボリックリンクは実体を追うようになる
setopt CHASE_LINKS
#setopt CORRECT
# =command を command のパス名に展開する
setopt equals
# ファイル名で #, ~, ^ の 3 文字を正規表現として扱う
setopt EXTENDED_GLOB
#setopt KSH_GLOB
# auto_list の補完候補一覧で、ls -F のようにファイルの種別をマーク表示
setopt LIST_TYPES
# 複数のリダイレクトやパイプなど、必要に応じて tee や cat の機能が使われる
setopt multios
# Ctrl+S/Ctrl+Q によるフロー制御を使わないようにする
setopt noflowcontrol
# バックグラウンドジョブが終了したら(プロンプトの表示を待たずに)すぐに知らせる
setopt NOTIFY
# プロンプトに escape sequence (環境変数) を通す
setopt PROMPT_SUBST
# 8 ビット目を通すようになり、日本語のファイル名などを見れるようになる
setopt print_eightbit
# 戻り値が 0 以外の場合終了コードを表示する
#setopt print_exit_value
# ディレクトリスタックに同じディレクトリを追加しないようになる
setopt PUSHD_IGNORE_DUPS
# pushd を引数なしで実行した場合 pushd $HOME と見なされる
setopt PUSHD_TO_HOME
#setopt SUN_KEYBOARD_HACK
#コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt magic_equal_subst
# 補完候補を詰めて表示
setopt list_packed
# レポートタイム閾値
REPORTTIME=15
# コピペしやすいようにコマンド実行後は右プロンプトを消す。
setopt transient_rprompt


### key-bind
bindkey -e

bindkey '^P' history-beginning-search-backward # 先頭マッチのヒストリサーチ
bindkey '^N' history-beginning-search-forward # 先頭マッチのヒストリサーチ

# zsh 4.3.10 以降じゃないと動かないと思う
#bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward
#bindkey '^R' peco-select-history

### etc
limit coredumpsize 0

# ls color
export CLICOLOR=true
## color for BSD ls
export LSCOLORS='dxgxcxdxcxegedabagacad'
## color for gnu ls
export LS_COLORS='di=33:ln=36:so=32:pi=33:ex=32:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'

# select complementary nomination with a cursole
zstyle ':completion:*default' menu select=1
zstyle ':completion:*' use-cache true

# 補完関数の表示を過剰にする編
## 補完方法の設定。指定した順番に実行する。
## _oldlist 前回の補完結果を再利用する。
## _complete: 補完する。
## _match: globを展開しないで候補の一覧から補完する。
## _history: ヒストリのコマンドも補完候補とする。
## _ignored: 補完候補にださないと指定したものも補完候補とする。
## _approximate: 似ている補完候補も補完候補とする。
## _prefix: カーソル以降を無視してカーソル位置までで補完する。
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format $YELLOW'%d'$DEFAULT
zstyle ':completion:*:warnings' format $RED'No matches for:'$YELLOW' %d'$DEFAULT
zstyle ':completion:*:descriptions' format $YELLOW'completing %B%d%b'$DEFAULT
zstyle ':completion:*:corrections' format $YELLOW'%B%d '$RED'(errors: %e)%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'

# 補完候補に色を付ける。
## "": 空文字列はデフォルト値を使うという意味。
#zstyle ':completion:*:default' list-colors ""
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# マッチ種別を別々に表示
zstyle ':completion:*' group-name ''

# 大文字小文字を区別しない（大文字を入力した場合は区別する）
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# for deleting directory by backward-kill-word 
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'


### history
setopt APPEND_HISTORY        # 複数のzshを同時に使用した際に履歴ファイルを上書きせず追加する
setopt EXTENDED_HISTORY      # 履歴ファイルにzsh の開始・終了時刻を記録する
setopt HIST_IGNORE_ALL_DUPS  # 重複するコマンド行は古い方を削除
setopt HIST_IGNORE_DUPS      # 直前と同じコマンドの場合は履歴に追加しない
setopt HIST_IGNORE_SPACE     # 先頭がスペースで始まる場合は履歴に追加しない
setopt HIST_NO_STORE         # histroyコマンドは記録しない
setopt HIST_REDUCE_BLANKS    # 余分な空白は詰めて記録
setopt SHARE_HISTORY         # 履歴を複数の端末で共有する
HISTFILE=~/.zshdir/.zsh-history
HISTSIZE=10000 # 履歴キャッシュの格納サイズ
SAVEHIST=100000 # 履歴ファイルの格納サイズ
### function
#function history-all { history -E 1 }

# http://mollifier.hatenablog.com/entry/20090728/p1
# history 追加対象を限定
zshaddhistory() {
    local line=${1%%$'\n'}  #コマンドライン全体から改行を除去したもの
    local cmd=${line%% *}    #１つ目のコマンド
    # 以下の条件をすべて満たすものだけをヒストリに追加する
    [[ ${#line} -ge 5
        && ${cmd} != (l|l[sal])
        && ${cmd} != (c|cd)
        && ${cmd} != (m|man)
        && ${cmd} != (whoami)
        && ${cmd} != (run-help)
        && ${cmd} != (timestamp)
        && ${cmd} != (finger)
    ]]
}
### ignoring list
#alias pwd=' pwd'
#alias top=' top'
#alias last=' last'
#alias who=' who'
#alias whoami=' whoami'
#alias finger=' finger'

### aliases
if [ -f $ZDOTDIR/aliases ]; then
  source $ZDOTDIR/aliases
fi

# help 強化 コマンドを表示させてM-hでヘルプ表示
unalias run-help
autoload -Uz run-help
autoload -Uz run-help-git
autoload -Uz run-help-openssl
HELPDIR=/usr/local/share/zsh/help

### global alias
alias -g A='|awk'
alias -g F='|fzf'
alias -g G='|grep'
alias -g L='|less'
alias -g S='|sed'
alias -g W='|wc'
alias -g P='|peco'

### zplug
if [ -f $HOME/.zplug/init.zsh ]; then
  source $HOME/.zplug/init.zsh
  source $ZDOTDIR/zplug
fi

### env
if [ -f $ZDOTDIR/env ]; then
  source $ZDOTDIR/env
fi

# iterm shell integration conf
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
# zsh: Place this in .zshrc after "source /Users/georgen/.iterm2_shell_integration.zsh".
iterm2_print_user_vars() {
  iterm2_set_user_var gitBranch $((git branch 2> /dev/null) | grep \* | cut -c3-)
}

# for profile
if (which zprof > /dev/null) ;then
  zprof | less
fi


#make install会从git库中的配置文件同步至系统相应目录
#make sync会从系统文件中同步至git库中的配置文件。
VIM_INSTALL_PATH:=/etc/vimrc
VIM_REPO_PATH:=./vim/vimrc

.PHONY:install sync i_vim s_vim

install:i_vim

#安装vim配置文件
i_vim:
	@rsync -u $(VIM_REPO_PATH) $(VIM_INSTALL_PATH)

sync:s_vim

#同步vim的系统配置文件至仓库
s_vim:
	@rsync -u $(VIM_INSTALL_PATH) $(VIM_REPO_PATH)

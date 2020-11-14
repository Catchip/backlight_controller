# Backlight_Controller

终端环境下调节背景亮度的 zsh 脚本

## 依赖
* dialog

## 使用方法
```zsh
sudo ./fun.sh
```

若不想每次执行 sudo 命令，可以将用户加入 video 组，命令如下：
```zsh
sudo usermod -G video yourusername
```
之后可直接执行`./fun.sh`


| 按键 | 作用     |
|------|----------|
| h    | 调低亮度 |
| l    | 调高亮度 |
| q    | 退出     |

#!/bin/bash
# 获取 qbittorrent 下载任务的信息。脚本保存为upload.sh。魔改MOERATS的脚本使其适应qbittorrent。因为aria2不能批量上传种子文件。需要在qbt设置里的种子完成运行外部程序填/downloads/upload.sh %I %N %F
GID="$1";
FileNum="$2";
File="$3";
LocalDIR="/downloads/";  #qbittorrent下载目录，记得最后面加上/。不设置，只拼接
Thread="5";  #默认3线程，自行修改，服务器配置不好的话，不建议太多
Block="40";  #默认分块20m，自行修改

# 设置 OneDriveUploader 的参数和配置
RemoteDIR="offline";  # 上传到 Onedrive 的路径，默认为根目录，如果要上传到 MOERATS 目录，"" 里面请填成 MOERATS
Uploader="/downloads/OneDriveUploader";  # 上传的程序完整路径，默认为本文安装的目录
Config="/downloads/auth.json";  # 初始化生成的配置 auth.json 绝对路径，参考第 3 步骤生成的路径


tmpFile="$(echo "${File/#$LocalDIR}" |cut -f1 -d'/')"
FileLoad="${LocalDIR}${tmpFile}"
echo $1 $2 $3 >> /downloads/111.json
# 调用 OneDriveUploader 上传文件或文件夹
${Uploader} -c "${Config}" -t "${Thread}" -b "${Block}" -s "${FileLoad}" -r "${RemoteDIR}" >> /downloads/111.json
# 判断是否上传成功，如果成功则删除本地文件或文件夹
if [[ $? == '0' ]]; then
  rm -rf "${FileLoad}";
fi





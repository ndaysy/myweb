#!/bin/sh

# 应用名必须唯一
appName="myweb"

# 生成压缩包的根路径
#zipPath="/var/jenkins_home/packtemp"
echo "WORKSPACE_TMP=$WORKSPACE_TMP"
zipPath="${WORKSPACE}/packtemp"
appPath="${zipPath}/${appName}"

mkdir -p ${appPath}
rm -rf   ${appPath}/*
rm -rf   ${zipPath}/${appName}.zip

# 编译生成的包路径,注意按照实际情况修改
targetPath="/var/jenkins_home/workspace/myweb/target"

#####################################
# 将应用编译后生成的文件及依赖文件复制到/data/${appName} 路径下

# 必须包含构建docker镜像的Dockerfile文件
cp ${targetPath}/../Dockerfile ${appPath}

# 复制应用编译生成的文件
cp ${targetPath}/myweb.war ${appPath}

#####################################
# 压缩成${appName}.tar.gz
tar -czvfP ${zipPath}/${appName}.tar.gz ${appPath}

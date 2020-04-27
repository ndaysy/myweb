#!/bin/sh

# 镜像名称,不需要加tag
imageName="myweb"

# jenkins的工作路径,
# 为一个路径加上应用名，例如：/var/jenkins/myweb
echo "WORKSPACE=${WORKSPACE}"

# jenkins的temp工作路径,
# 为一个路径加上应用名@tmp，例如：/var/jenkins/myweb@tmp
# 该路径不一定存在，因此如果使用需要主动创建
echo "WORKSPACE_TMP=${WORKSPACE_TMP}"

# 生成压缩包的根路径
zipPath="${WORKSPACE_TMP}/${imageName}"

mkdir -p ${zipPath}
rm -rf   ${zipPath}/*

# 编译生成的包路径,注意按照实际情况修改
targetPath="${WORKSPACE}/target"

#####################################
# 将应用编译后生成的文件及依赖文件复制到临时路径下准备压缩

# 必须包含构建docker镜像的Dockerfile文件
cp ${WORKSPACE}/Dockerfile ${zipPath}

# 复制应用编译生成的文件
cp ${targetPath}/myweb.war ${zipPath}

#####################################
# 压缩成${imageName}.tar.gz
# 注意压缩包需要放到Jenkins的WORKSPACE下，否则ssh publishers插件会找不到文件
rm -rf ${WORKSPACE}/${imageName}.tar.gz
tar -czvPf ${WORKSPACE}/${imageName}.tar.gz -C ${zipPath}/.. ${imageName}
rm -rf ${zipPath}

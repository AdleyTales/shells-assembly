#
# 同步git脚本 gitee github gitlab
#
# Example；
#    bash sync-git.bash nodejs-spider-tiny-example "modify md file"
#
#

PROJECT_NAME=$1
GIT_COMMIT_MESSAGE=$2
GITEE_PROJECT_DIR=../gitee/$PROJECT_NAME
GITHUB_PROJECT_DIR=../../github/$PROJECT_NAME
GITLAB_PROJECT_DIR=../../gitlab/$PROJECT_NAME

if [[ -z "$PROJECT_NAME" ]];then
    echo "请输入工程名"
    exit 1
fi

if [[ -z "$GIT_COMMIT_MESSAGE" ]];then
    echo "请输入git commit message"
    exit 1
fi

if [[ -z "$GIT_COMMIT_MESSAGE" ]];then
  echo "请输入git commit message"
  exit 1
fi

# 直接拷贝源代码到不同的git库下
cpFunc() {
    cp -rf $PROJECT_NAME ../gitlab/
    cp -rf $PROJECT_NAME ../github/
    cp -rf $PROJECT_NAME ../gitee/
}

# 执行git
gitShellFunc() {
    git pull
    git add .
    git commit -m "$GIT_COMMIT_MESSAGE"
    git push
}

gitlabFunc() {
    echo "---------------------------------------------------- git sync gitlab begin ..."
    cd $GITLAB_PROJECT_DIR
    gitShellFunc
    echo "---------------------------------------------------- git sync gitlab success!"
}

githubFunc() {
    echo "---------------------------------------------------- git sync github begin ..."
    cd $GITHUB_PROJECT_DIR
    gitShellFunc
    echo "---------------------------------------------------- git sync github success!"
}

giteeFunc() {
    echo "---------------------------------------------------- git sync gitee begin ..."
    cd $GITEE_PROJECT_DIR
    gitShellFunc
    echo "---------------------------------------------------- git sync gitee success!"
}

main() {
    echo "开始同步 ..."
    cpFunc
    giteeFunc
    githubFunc
    gitlabFunc
    echo "同步完成！"
}

main


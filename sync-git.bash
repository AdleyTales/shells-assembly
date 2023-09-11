# 
# 同步git脚本
# Example；
#    bash sync.bash nodejs-spider-tiny-example "modify md file"
# 

PROJECT_NAME=$1
GIT_COMMIT_MESSAGE=$2
GITLAB_PROJECT_DIR=../gitlab/$PROJECT_NAME
GITHUB_PROJECT_DIR=../../github/$PROJECT_NAME
GITEE_PROJECT_DIR=../../gitee/$PROJECT_NAME




if [[ -z "$PROJECT_NAME" ]];then
  echo "请输入工程名"
  exit 1
fi

# 直接拷贝源代码到不同的git库下
cpFunc() {
  if [[ -z "$GIT_COMMIT_MESSAGE" ]];then
    echo "请输入git commit message"
    exit 1
  fi

  cp -rf $PROJECT_NAME ../gitlab/
  cp -rf $PROJECT_NAME ../github/
  cp -rf $PROJECT_NAME ../gitee/
}

# 执行git
gitShellFunc() {
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

# init gitlab
gitlabInitFunc() {
  echo "---------------------------------------------------- git init gitlab begin ..."
  cd ../gitlab
  mkdir $PROJECT_NAME
  cd shells-assembly
  git init 
  git add .
  git commit -m "first commit"
  git branch -M main
  git remote add origin git@gitlab.com:AdleyTales/shells-assembly.git
  git push -u origin main
  echo "---------------------------------------------------- git init gitlab push origin success!"
}

# init github
githubInitFunc() {
  echo "---------------------------------------------------- git init gitee begin ..."
  cd ../../github
  mkdir $PROJECT_NAME
  cd shells-assembly
  git init 
  git add .
  git commit -m "first commit"
  git branch -M main
  git remote add origin git@github.com:AdleyTales/shells-assembly.git
  git push -u origin main
  echo "---------------------------------------------------- git init gitee push origin success!"
}

# init gitee
giteeInitFunc() {
  echo "---------------------------------------------------- git init gitee begin ..."
  cd ../../gitee
  mkdir $PROJECT_NAME
  cd shells-assembly
  git init 
  git add .
  git commit -m "first commit"
  git remote add origin git@gitee.com:adleytales/shells-assembly.git
  git push -u origin "master" 
  echo "---------------------------------------------------- git init gitee push origin success!"
}

main() {
  # 判断是否需要初始化
  if [ ! -d "../gitlab/$PROJECT_NAME" ];then 
    gitlabInitFunc
  elif [ ! -d "../../github/$PROJECT_NAME" ];then 
    githubInitFunc
  elif [ ! -d "../../gitee/$PROJECT_NAME" ];then 
    giteeInitFunc
  else
    echo "开始同步 ..."
    cpFunc 
    gitlabFunc
    githubFunc
    giteeFunc
    echo "同步完成！"
  fi
}

main


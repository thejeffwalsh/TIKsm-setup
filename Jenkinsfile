pipeline {
  agent any
  stages {
    stage('myStage'){
      steps {
        apt-get update -qq && apt-get install -y -qq sshpass
        export SSHPASS=kube
        sshpass -e ssh -o stricthostkeychecking=no kube@10.0.0.1 'git clone https://github.com/Eliforbes42/TIKsm-setup.git; ./create.sh'        
      }
    }
  }
}
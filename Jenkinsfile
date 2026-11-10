pipeline {
  agent {label 'ubuntu-agent2' }

  stages { 
    stage('Git Clone') {
      steps { 
        sh ' git clone https://github.com/megharajbr/devops-assignment-04.git'
      }
    }
    stage('System Information') {
      steps {
         dir('devops-assignment-04') {
        sh 'bash scripts/system_info.sh'
         }
      }
    }
    stage('Health Check') {
      steps {
         dir('devops-assignment-04') {
        sh 'bash scripts/health_check.sh cron nginx'
         }
      }
    }
    stage('Disk check') {
      steps {
        sh 'df -h'
      }
    }
    stage('Create Directory') {
      steps {
        sh 'mkdir -p /tmp/jenkins-assignment'
      }
    }
    stage('create file') {
      steps {
        sh '''
             echo "hi this assignment" >/tmp/jenkins-assignment/app.log
             echo "how are u" >> /tmp/jenkins-assignment/app.log 
             echo "i am fine" >> /tmp/jenkins-assignment/app.log 
             '''
      }
    }
    stage('Backup') {
      steps {
         dir('devops-assignment-04') {
        sh 'bash scripts/backup_manager.sh'
         }
      }
    }
    stage('User_Reports') {
      steps {
         dir('devops-assignment-04') {
        sh 'bash scripts/user_audit.sh'
         }
      }
    }
    stage('system-info') {
      steps {
        sh '''
        hostname
        date
        uname -v
        '''
      }
    }
  }
    post {
       success {
         echo 'Pipeline SUCCESS'
       }
      failure {
        echo 'Pipeline FAILED'
      }
  }
}
#

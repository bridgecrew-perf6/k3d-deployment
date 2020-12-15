pipeline {

  agent { label 'master' }

  parameters {
    string(name: 'CLUSTER_NAME', defaultValue: 'k3s-test', description: 'What do you want to name your k3s cluster?')
  }

  stages {

    stage('Install k3d') {
      steps {
        sh """
          echo 'install k3d....'
        """
      }
    }

    stage('Create Cluster') {
      steps {
        sh """
          ./scripts/create_cluster.sh ${CLUSTER_NAME}
        """
      }
    }
    
    stage('Deploy Sample Website') {
      steps {
        sh """
          ./scripts/deploy_nginx.sh
        """
      }
    }

  }
}
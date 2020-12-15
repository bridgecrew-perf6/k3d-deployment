pipeline {

  agent { label 'master' }

  parameters {
    string(name: 'CLUSTER_NAME', defaultValue: 'k3s-test', description: 'What do you want to name your k3s cluster?')
    string(name: 'PORT_MAP_LB', defaultValue: '9099:80', description: 'How do you want to map ports on the load balancer <localPort:hostPort>?')
  }

  stages {

    stage('Install k3d') {
      steps {
        sh """
          curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash
        """
      }
    }

    stage('Create Cluster') {
      steps {
        sh """
          ./scripts/create_cluster.sh ${CLUSTER_NAME} ${PORT_MAP_LB}
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
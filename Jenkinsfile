pipeline {

  agent { label 'master' }

  parameters {
    string(name: 'CLUSTER_NAME', defaultValue: 'k3s-test', description: 'What do you want to name your k3s cluster?')
    string(name: 'PORT_MAP_LB', defaultValue: '9099:80', description: 'How do you want to map ports on the load balancer <localPort:hostPort>?')
    string(name: 'API_PORT', defaultValue: '6555', description: 'What API port shall we use for this cluster?')
    string(name: 'AGENT_NODES', defaultValue: '2', description: 'How many agent nodes do you want in this cluster?')
  }

  stages {

    stage('Install k3d') {
      steps {
        sh """
          echo 'curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash'
        """
      }
    }

    stage('Create Cluster') {
      steps {
        sh """
          echo './pipeline_scripts/create_cluster.sh ${CLUSTER_NAME} ${PORT_MAP_LB} ${API_PORT} ${AGENT_NODES}'
        """
      }
    }
    
    stage('Deploy Sample Website') {
      steps {
        sh """
          echo './pipeline_scripts/deploy_nginx.sh'
        """
      }
    }

  }
}
pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git branch: 'dev', url: 'https://github.com/PuppyDestroyer/DevMastersP2.git'
            }
        }
        stage('Build') {
            steps {
                sh 'echo "Compilando proyecto..."'
            }
        }
        stage('Test') {
            steps {
                sh 'echo "Ejecutando tests..."'
            }
        }
        stage('Docker Build & Run') {
            steps {
                sh '''
                  echo "Construyendo imagen Docker..."
                  docker build -t devmasters-app .
                  echo "Ejecutando contenedor..."
                  docker run -d -p 80:80 --name devmasters-app devmasters-app
                '''
            }
        }
    }
}

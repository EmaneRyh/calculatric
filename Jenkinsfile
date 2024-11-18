pipeline {
    agent any

    stages {
        stage("Package") {
            steps {
                sh "./gradlew build"
            }
        }

        stage("Docker Build") {
            steps {
                sh "docker build -t localhost:5000/calculatrice ."
            }
        }

        stage("Docker Push") {
            steps {
                sh "docker push localhost:5000/calculatrice"
            }
        }

        stage("Deploy to Staging (Préproduction)") {
            steps {
                // Supprime le conteneur en cours, si existant
                sh "docker rm -f calculatrice || true"
                // Lancement du conteneur en mode détaché
                sh "docker run -d --rm -p 8882:8888 --name calculatrice localhost:5000/calculatrice"
            }
        }

        stage("Test d\'acceptation") {
            steps {
                 sleep 60
 		 sh "chmod +x acceptance_test.sh && ./acceptance_test.sh"
            }
        }
    }

    
}


pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                echo "Récupération du code source depuis le dépôt Git."
                checkout scm // Vérifie automatiquement le code depuis le dépôt configuré
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

        stage("Acceptance Test") {
            steps {
                // Attente pour garantir que le service est bien démarré
                sleep 60
                // Lancement des tests d'acceptation
                sh "./gradlew acceptanceTest -Dcalculatrice.url=http://localhost:8765"
            }
        }
    }

    post {
        always {
            // Arrêt du conteneur, peu importe le résultat des étapes précédentes
            sh "docker stop calculatrice"
        }
    }
}


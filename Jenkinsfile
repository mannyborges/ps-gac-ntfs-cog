pipeline {
    agent any // or specify a Windows agent if needed: agent { label 'windows-agent' }
    environment {
        // Define any environment variables if needed
        // Example: PSModulePath = 'C:\\Path\\To\\Your\\Modules'
    }
    options {
        // Keep the build logs for 30 days
        buildDiscarder(logRotator(daysToKeepStr: '30'))
        // Timeout the build if it takes longer than 60 minutes
        timeout(time: 60, unit: 'MINUTES')
    }  
    stages {    
        stage('Checkout Code') {
            steps {
                
                git branch: 'main', credentialsId: 'd4ea153c-8f10-4ab1-bdbd-84dfc6246f97', url: 'https://github.com/mannyborges/ps-gac-ntfs-cog.git',
                
                // If authentication is needed, use credentialsId
                // If you need to checkout a specific branch, use the 'branch' parameter
                // If you need to checkout a specific commit, use the 'commit' parameter
                // Example: 
                //git branch: 'main', credentialsId: 'your-credentials-id', url: '
                
                //git 'https://github.com/mannyborges/ps-gac-ntfs-cog.git' // Replace with your SCM URL
            }
        }

        stage('Build EXE from PowerShell Script') {
            steps { 
                script {
                    // Define the path to your PowerShell script
                    def psScriptPath = '/script/ps-gac-ntfs-cog.ps1' // Replace with your script name
                    // Define the desired output path for the EXE
                    def outputPath = '/build/ps-gac-ntfs-cog.exe' // Replace with your desired EXE name
                    // Ensure the output directory exists
                    sh "mkdir -p /build"
                    // Install PS2EXE module and its dependencies
                    // Note: This step assumes you have internet access to install the module
                    // You might want to cache the module installation in a real-world scenario
                    // You can also pre-install the module on your Jenkins agent to speed up the build process
                    // You can specify the version of PS2EXE if needed
                    // Example: Install-Module -Name PS2EXE -RequiredVersion 1.0.0 -Force -Scope CurrentUser
                    // You can also add error handling to ensure the module is installed correctly
                    // You can also check if the module is already installed before attempting to install it
                    // You can also use a private repository for the module if needed
                    // You can also use a different method to convert the script to EXE if needed
                    // Example: Use a different tool or script to perform the conversion
                    // You can also customize the output EXE with additional parameters if needed
                    // Execute PS2EXE to convert the PowerShell script to an EXE
                    powershell """
                        Install-Module -Name PS2EXE -Force -Scope CurrentUser
                        Invoke-PS2EXE -File "${psScriptPath}" -OutputPath "${outputPath}"
                    """
                }
            }
        }

        stage('Archive Artifacts') {
            steps {
                archiveArtifacts artifacts: '**/*.exe', fingerprint: true // Adjust the pattern to match your output EXE files
                // You can also publish the artifacts to a repository if needed 
                // Example: Use a plugin to publish to Nexus, Artifactory, etc.
                // You can also add error handling to ensure the artifacts are archived correctly
                // You can also notify stakeholders about the build status if needed
                // Example: Send an email notification or Slack message
                // You can also add post-build actions if needed
                // Example: Trigger another job or deploy the artifacts
                // You can also clean up the workspace if needed
                // Example: Use the 'cleanWs()' step to clean the workspace after archiving
                // You can also customize the archive options if needed
                // Example: Change the fingerprint option or add more patterns
                // You can also add a summary of the build in the console output if needed
                // Example: Print the location of the archived artifacts
                echo "Artifacts archived successfully."

            }   
        }
    }
}
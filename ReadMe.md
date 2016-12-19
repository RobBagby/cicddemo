Windows Server Containers CI/CD Starter
================================

## Overview
This purpose of this project is to provide a headstart setting up a CI/CD pipeline with the following components/technologies:
* Windows Server Containers 
* Windows Server 2016 Datacenter with Containers in Azure
* Jenkins
* GitHub
* Docker Hub

We will be creating an ASP.NET MVC 4.6 application, hosted in IIS.  The following is a high-level overview of the pipeline:
![image](https://github.com/RobBagby/cicddemo/raw/master/images/Pipeline.jpg)

## Steps
1. Write your code
2. Push your code / changes to a GitHub repository
3. A webhook registered in your GitHub repository will notify Jenkins of the push, triggering a build job
4. The job will pull the code from GitHub
5. Build Step: Build the Docker image
6. Build Step: A container will be created via docker run and the unit tests will be run in the container
7. Build Step: Push the image to Docker Hub if the tests pass
8. Build Step: Deploy a container to a staging server via docker compose
## Recording
You can view a recording of how to set this pipeline up here: [Windows Svr Containers - CI/CD Pipeline on DevEducate](http://www.deveducate.com/Module/1014)
## Assets
Here is a list of the assets you can find in this repo:
1. [The SampleApp](https://github.com/RobBagby/cicddemo/tree/master/SampleApp)
  * Contains an out-of-the-box MVC App
  * Contains a test project that illustrates how to use NUnitLite to run unit tests as an exe.  **This makes executing tests in a container very easy**
2. [RunTests.ps1](https://github.com/RobBagby/cicddemo/blob/master/RunTests.ps1).  
  * This is a powershell script that is called to execute the tests in the container
  * Illustrates how to control the unit test output file name, location and format
3. [Dockerfile](https://github.com/RobBagby/cicddemo/blob/master/Dockerfile)
  * This is the Dockerfile used to build the image
  * Illustrates creating the image with the microsoft/iis base, adding the necessary dependencies and copying the necessary files over to the appropriate locations
4. [Docker Compose file](https://github.com/RobBagby/cicddemo/blob/master/docker-compose.yml) This is the compose file used to deploy to a Windows Server that supports Windows Server Container.
5. [ARM Template](https://github.com/RobBagby/cicddemo/blob/master/azuredeploy.json)
  * This is an ARM template that can be used to create a Jenkins Server on a Windows Server that supports Windows Server containers
  * The template calls a [custom script extension](https://github.com/RobBagby/cicddemo/blob/master/InstallGitAndJenkins.ps1) that installs Jenkins, Git and docker-compose
6. [Powershell Script to configure server](https://github.com/RobBagby/cicddemo/blob/master/InstallGitAndJenkins.ps1)
  * Installs Git
  * Installs Jenkins
  * Installs Docker Compose
7. [Jenkins Build File](https://github.com/RobBagby/cicddemo/blob/master/jenkinsconfig/sampleapp/config.xml)
  * Xml file representing the build 
  * Not a completed solution - as it will require you to customize - setting up your Git repo, etc.  
  

---
title: "Azure DevOps Exploration"
description: "Deploy an Azure Function using Azure Pipelines"
date: 2018-11-10T16:13:53-07:00
tags: ["Azure Functions", "DevOps"]
categories:
  - DevOps
  - Software
---

Building software has always been a hassle. Over the years, the effort it takes to create a reliable build system has decreased drastically. Tools like [Travis CI](https://travis-ci.org) dramatically reduce the time and effort it takes to go from nothing to a functioning continuous integration pipeline. I've tried a few CI tools like Travis, AppVeyor, and TeamCity. One CI application I had not tried, was Visual Studio Team Services  — better known as VSTS. Microsoft rebranded VSTS to Azure DevOps in September, so what better time to give Azure DevOps a try?

In order to test out Azure DevOps, I needed a project. Luckily, I had one — a Pomodoro application I have been writing for my Mac. Right now, the app tracks how many pomodoros I've completed in memory. Instead of trying to store the completed pomodoros locally, why not push those events into an Azure Function where it could save that information into Azure Table Storage? With a project in mind, I got started.

## What is Azure DevOps?

Azure DevOps started its life as VSTS which bundled several tools into one application. Azure DevOps still has those same tools, but you can choose which of the tools you would like to use. So what are the tools available? First, you have Azure Pipelines. Pipelines seem to be the most publicized of the tools, and it happens to be what I'm most interested in learning. Pipelines provide two main things: build pipelines and release pipelines. Along with Pipelines, there is Azure Boards which is a Kanban board. Azure Artifacts hosts software artifacts such as NPM packages or Nuget Packages. Azure Repos lets you host your source code. Finally, there is Azure Test Plans which does what it describes — create, manage, and execute test plans.

## Creating an Organization

To get started with Azure DevOps, I needed to create an organization. Going through the setup process was simple, I gave my organization a unique name and a region I wanted to host my projects in. After that, my organization was created. That was quick and easy, but I would love to be able to script the creation of an organization. From what research I did, that does not seem like it is possible yet. That isn't a huge issue, but I very much prefer to have all my infrastructure setup and configuration done through automation and not by clicking through the portal.

![Azure DevOps screen to create a project](/images/posts/create-devops-project.png)

## My First Project

With my organization created, I was able to get started on my project.

![Azure DevOps UI to create a new Project](/images/posts/create-devops-project.png)

Creating a project was as simple as picking a name and hitting create. From there, the project was created and all the services enabled. Since I only planned on using Pipelines, I went into the settings and unchecked the services I did not need. Easy.

## The Build Pipeline

Next step, I created my first build pipeline. After clicking on Pipelines and then the New pipeline button I was faced with a problem.

![Azure DevOps screen to create a build pipeline](/images/posts/devops-build-pipeline.png)

I was planning on hosting the function code in GitLab since that is where I host the code to the Pomodoro app. I want to keep that code private for now and I didn't want to spend time making GitLab work, I gave Azure Repos a try. Now, I realize I could have hooked up the pipeline to GitLab, but Azure Repos is working well for me. Enough so, that I plan on keeping the source code there and I might also move the repository for my Mac application as well.

I selected the newly created repository and then I was presented with a list of templates to start my build pipeline. Scrolling through the templates I noticed Microsoft has built steps for many common types of applications. From .NET, .NET Core, C++, Python, Ruby, Node, Docker to Xamarin or Xcode projects. It is clear that Azure DevOps will work with any project and that Microsoft wants you to know that.

### Defining the Build

I started with the suggested Starter Pipeline template. Once I selected the template, I was given an editor showing the contents of the template. This is the template in its entirety:

```yaml
# Starter pipeline
# Start with a minimal pipeline that you can customize to build and deploy your code.
# Add steps that build, run tests, deploy, and more:
# https://aka.ms/yaml

pool:
  vmImage: 'Ubuntu 16.04'

steps:
- script: echo Hello, world!
  displayName: 'Run a one-line script'

- script: |
    echo Add other tasks to build, test, and deploy your project.
    echo See https://aka.ms/yaml
  displayName: 'Run a multi-line script'
```

Pretty straightforward. This prompted me to look at each component of the YAML file to try and understand what it was describing. the `pool` section describes what sort of VM to run the build on. Since I am using an Azure Function V2, I'm using .NET Core so an Ubuntu image works nicely. Microsoft provides other images to use and you also can manage your own VMs to run the Pipelines Service. That isn't something I wanted to do so I stuck with the Ubuntu image.

The next section is `steps`. Looking at it was easy enough to understand. Each item in the list is executed one after the other. The example has a single line script and a multi-line script. Since I wanted to see what the build would look like, I clicked the Save and Run button. Pipelines committed the `azure-pipelines.yml` file to my repository and started a build. Nice. With that file committed to the repository, this should make it very easy to define, and version, my build pipeline.

### Commit, Push, Build

With the pipeline YAML file in my repo, I could edit the pipeline from Visual Studio Code. The process was easy to understand: change the script step, commit the change, push to the repository. As soon as I pushed the code, Pipelines was running a build with those changes. As with other CI services I've used, I ran into the problem of not being able to run locally before I commit and push. I didn't spend much time trying to find a way to test locally, but it would be nice to have more confidence in my changes before I commit the code.

While working out how to build my Function App, I ran into trouble with the documentation. The starter script shows only script steps, but the documentation I read used tasks. The concept of tasks isn't new to me, but I didn't see any links to what tasks are available in Pipelines. It took me a half hour before I stumbled on the [documentation for Tasks](https://docs.microsoft.com/en-us/azure/devops/pipelines/tasks). The documentation for the tasks themselves is fairly clear, but the descriptions of the properties were confusing to me. For example, the [dotnet core cli Task](https://docs.microsoft.com/en-us/azure/devops/pipelines/tasks/build/dotnet-core-cli?view=vsts) has a whole host of inputs. Each input is documented, but the table describing the inputs below doesn't exactly match the name of the input. I couldn't tell what `Zip Published Projects` matched to in the actual inputs. Maybe `zipAfterPublish`? Once I got my build where I thought I needed it to be, I was ready to move on to how to deploy my code.

## On to the Release Pipeline

The Release Pipeline doesn't seem to be versioned the same way as the build pipeline. That is somewhat understandable, but also felt strange when I realized that. Since I couldn't version the pipeline, I went through the site to create my release pipeline. You get a nice prompt suggesting starter release pipelines for many different types of application as you can see below:

![Azure DevOps release pipeline template selection](/images/posts/azure-devops-release-pipeline.png)

Since I was deploying a Function App, I searched for "function" and found a template available and selected it.

## Deploying my Function App

Once I selected the template I was shown the UI for managing the release pipeline. The Azure Function template is very simple, which was a great place to start.

![The default Azure Function release pipeline](/images/posts/azure-devops-release-template-for-function.png)

After looking at the overview of the function, I realized I needed to click on the `1 job, 1 task` section. From there, all I had to do was fill out the required information for my Function App. This consisted of the Azure Subscription I wanted to use and then the App Service for the Function App I was deploying. Pretty easy.

So now that I had that configured, the next step was to get the artifacts from my build pipeline into my release pipeline. I clicked on the "Add an artifact" option under the Artifacts section of the Release pipeline and I picked my source pipeline as well as selected using the Latest build. There are several options under what build version the pipeline can use but Latest fit what I was trying to do.

Now that my pipeline was ready, I created a release and went to get to deploy my code. But I couldn't, the release couldn't find any artifacts for me to find. With that, I went back to the build pipeline to try and figure out how I get artifacts published so that the Release pipeline could use them.

This took several attempts to figure out what I needed to do to promote my artifacts. At first, I thought that I needed to call `dotnet publish` and push the output into Azure DevOps `Build.ArtifactStagingDirectory`. At the time, I was trying to understand if Azure DevOps then picked up the staged artifacts and published them after the build passed. This was not correct and my attempted deployment failed because there were no artifacts to deploy.

My second attempt was to then publish the app and then zip the contents into the Staging Directory. Still no luck, but it felt like I was on the right track, I was just missing something. And indeed I was missing something, I then found the `PublishArtifacts` task. I updated my build process to publish the zip file that I had placed in the staging directory and then my release pipeline worked! I now had a working Azure Function and a simple build and release pipeline. All within the course of an evening. Not bad.

## Impressions of Azure DevOps

I am quite pleased by what I've used in Azure DevOps. Rebranding VSTS to Azure DevOps was a smart move, VSTS had baggage that it was only for Microsoft applications. With the new name, I was interested enough to give it a try. The pipeline YAML file is a great way to manage the build process. I'm glad to see that Microsoft recognized what Travis CI, Appveyor and others have been doing and followed that process. Defining my release process was extremely easy, and from what I can tell, extremely powerful. I do find it strange my release process isn't versioned the same way as the build process though. I would be curious to see what that file would look like.

I did have some hurdles finding documentation that was clear on how to hook up the build and release pipeline as well as describing where tasks were. These were annoying, but I did manage to figure out everything in a relatively short amount of time. The documentation was helpful, but like most documentation, always can use some more work and clarity. I'm confident Microsoft will keep improving this area of Azure DevOps.

Overall it was a great experience and I plan on still using Azure DevOps. I also plan on bringing this to my coworkers and investigating if it makes sense for us to start trying out Azure DevOps at work as well.

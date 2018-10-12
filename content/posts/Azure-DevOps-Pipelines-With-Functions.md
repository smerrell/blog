---
title: "Azure DevOps Exploration"
date: 2018-09-29T11:29:53-06:00
draft: true
---

Building software has always been a hassle. Over the years, the effort it takes to create a reliable build system has decreased drastically. Tools like [Travis CI](https://travis-ci.org) dramatically cut down the time and effort it takes to go from no build to a functioning continuous integration pipeline. I've tried a few CI applications from Travis, AppVeyor, and TeamCity. One CI application I had not tried, though, was Visual Studio Team Services  — better known as VSTS. Microsoft rebranded VSTS to Azure DevOps in September, so what better time to give Azure DevOps a try?

In order to test out Azure DevOps, I need a project. Luckily, I had one in mind — a Pomodoro application I have been writing for my Mac. Right now, the app tracks how many pomodoros I've completed in memory. Instead of trying to store the completed pomodoros locally, why not push those events into an Azure Function? The function would then save that information into Azure Table Storage. With a project in mind, I got started.

## What is Azure DevOps?

Azure DevOps started its life as VSTS which bundled several tools into one application. Azure DevOps still has those same tools, but you can choose which of the tools you would like to use. So what are the tools available? First, you have Azure Pipelines. Pipelines seem to be the most publicized of the tools, and it happens to be what I'm most interested in learning. Pipelines provide two main things: build pipelines and release pipelines. Along with Pipelines, there is Azure Boards which is a Kanban board. Azure Artifacts hosts software artifacts such as NPM packages or Nuget Packages. Azure Repos lets you host your source code. Finally, there is Azure Test Plans which does what it describes — create, manage, and execute test plans.

## Creating an Organization

To get started with Azure DevOps, I needed to create an organization. Going through the setup process was simple, I gave my organization a unique name and a region I wanted to host my projects in. After that, my organization was created. That was quick and easy, but I would love to be able to script the creation of an organization. From what research I did, that does not seem like it is possible yet. That isn't a huge issue, but I very much prefer to have all my infrastructure setup and configuration done through automation and not by clicking through a portal.

![](../../../../../static/images/posts/create-devops-organization.png)

## My First Project

With my organization created, I was able to get started on my project.

![create-devops-project](../../../../../static/images/posts/create-devops-project.png)

Creating a project was as simple as picking a name and hitting create. From there the project was created and all the services enabled. I went into the settings and decided I only wanted to use pipelines, each service is a checkbox. Easy.

## The Build Pipeline

Next step, I created my first build pipeline. After clicking on Pipelines and then the New pipeline button I'm faced with a problem.

![](../../../../../static/images/posts/devops-build-pipeline.png)

I was planning on hosting the function code in GitLab since that is where I host the code to the Pomodoro app. I want to keep that code private for now and I didn't want to spend time making GitLab work, I gave Azure Repos a try. Now, I realize I could have hooked up the pipeline to GitLab, but Azure Repos is working well for me. Enough so, that I might consider moving my Pomodoro app repo over as well.

I selected the newly created repository and then I was presented with a list of templates to start my build pipeline. Scrolling through the templates I noticed Microsoft has built steps for many common types of applications. From .NET, .NET Core, C++, Python, Ruby, Node, Docker to Xamarin or Xcode projects. It is clear that Azure DevOps will work with any project.

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

The Release Pipeline doesn't seem to be versioned the same way as the build pipeline. That is somewhat understandable, but also felt strange when I realized that.

How do I get my build application into the release pipeline?

## Deploying my Function App

Turns out, you need to Zip the application up.

## Impressions of Azure DevOps

I am quite pleased by what I've used in Azure DevOps. Rebranding VSTS to Azure DevOps was a smart move, VSTS had baggage that it was only for Microsoft applications. With the new name, I was interested enough to give it a try. The pipeline YAML file is a great way to manage the build process. I'm glad to see that Microsoft recognized what Travis CI, Appveyor and others have been doing and followed that process. Defining my release process was extremely easy, and from what I can tell, extremely powerful. I do find it strange my release process isn't versioned the same way as the build process though. I would be curious to see what that file would look like.

This was a great experience and I plan on still using Azure DevOps. I also plan on bringing this to my coworkers and investigating if it makes sense for us to start trying out Azure DevOps at work as well.


## Notes

Tasks around "web" .net core projects don't work with Azure functions even though you do end up doing a `dotnet publish` on the Function App.

The Azure function deployment step seems to default to a zip file deployment.

## Questions

- [ ] Are there ways to automate creating a DevOps Pipeline?
  - Not 100% sure you can create the projects and pipelines but there is the
    [VSTS Command Line
    Tool](https://docs.microsoft.com/en-us/cli/vsts/install?view=vsts-cli-latest)
- [x] How much does Azure DevOps cost?
- [x] what exactly are tasks and where can I see a list of preexisting tasks
  - [Docs](https://docs.microsoft.com/en-us/azure/devops/pipelines/tasks/?view=vsts)

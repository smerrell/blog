---
title: "Azure Web App for Containers Using Terraform"
date: 2018-09-28T16:17:32-06:00
tags: ["Azure", "Terraform", "DevOps"]
categories:
  - DevOps
  - Software
---

Recently at work I have been tasked with helping our organization transition
from our traditional on-premises infrastructure to Azure. To do that, I've been
learning how to automate our infrastructure by using HashiCorp's
[Terraform](terraform.io). Terraform was introduced to me by a few members of
our infrastructure team and I've found it quite fun to work with.

As I've been working on what direction we'd like to head, I've focused on new
apps using Platform as a Service, specifically Azure Web Apps. A few months back
I noticed that Web Apps had a new option for using Docker containers, so about a
week ago I decided to see if I could create an Azure Web App for Containers
using Terraform.

It turns out, this is already possible but it took some fiddling to figure out
what I needed to set up in Terraform. I assume this isn't very well documented
yet because Azure Web App for Containers only recently went
[GA](https://azure.microsoft.com/en-us/blog/general-availability-of-app-service-on-linux-and-web-app-for-containers/).
So to make sure I remember how to do this, and if anyone else could use this,
I'm writing this down here.

## Creating the Container Registry

You first have to have the container registry created before you create the App
Service. Creating the container registry is no different than what is described
in the [azurem provider
documentation](https://www.terraform.io/docs/providers/azurerm/r/container_registry.html).
The main thing to note is that from the tests I was running, I needed to have
the container registry created well before I created the App Service Plan and
App Service. Otherwise it seemed that the Azure Web App didn't recognize the
container registry.

The example documentation does use the `Classic` SKU, I went ahead and changed
that to use `Basic`. If you do that, you do not need to create a separate
Storage Account. I chose to do this because the Azure Portal suggested upgrading
from Classic to Basic.

## Creating the App Service Plan

The App Service plan is close to the same as the
[documentation](https://www.terraform.io/docs/providers/azurerm/r/app_service_plan.html).
The main thing to make sure you set is the fact that it is a Linux plan.

```swift
resource "azurerm_app_service_plan" "containertest" {
  name                = "container-test-plan"
  location            = "eastus2"
  resource_group_name = "test-resource-group"
  kind                = "Linux"

  properties {
    reserved = true
  }
}
```

I also put this as a reserved instance, but I'm not 100% sure that is needed.

## Creating the App Service

This was the trickiest part. Not only do you have to set some `site_config`
properties. You also have to set a few app settings as well.

Here is what the Terraform config looks like to get this set up right.

```swift
resource "azurerm_app_service" "containertest" {
  name                = "someuniquename01"
  location            = "eastus2"
  resource_group_name = "test-resource-group"
  app_service_plan_id = "${azurerm_app_service_plan.containertest.id}"

  site_config {
    always_on        = true
    linux_fx_version = "DOCKER|${data.azurerm_container_registry.containertest.login_server}/testdocker-alpine:v1"
  }

  app_settings {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    "DOCKER_REGISTRY_SERVER_URL"          = "https://${data.azurerm_container_registry.containertest.login_server}"
    "DOCKER_REGISTRY_SERVER_USERNAME"     = "${data.azurerm_container_registry.containertest.admin_username}"
    "DOCKER_REGISTRY_SERVER_PASSWORD"     = "${data.azurerm_container_registry.containertest.admin_password}"
  }
}
```

The big part here to notice is the `linux_fx_version` under `site_config`. The
documentation in the azurerm provider isn't super clear how this works. The
example uses `DOCKER|(golang:latest)`. What it doesn't show or explain is that
string uses Dockerhub. If you want to use a different registry the format looks
like this `DOCKER|<registryurl>/<container>:<tag>`.

Under `app_settings` I had to create an app service from the Azure portal and
poke around the settings to reverse engineer what I needed in my terraform
config. Not only do you need the `linux_fx_version` property that has the
registry URL, you also have to set that as an app setting. Once that happens,
you need a username and password to access the registry. Fortunately Terraform
exposes all of this information so you can reference the properties as data.

This should get you up and running with a Web App for Container. This took a few
hours of my weekend to get running. Hopefully this can help others get up and
running more quickly. I'll eventually come back to this and try getting this
down to the smallest set possible as there are a few items I'm not 100% sure I
actually need. If I get a smaller setup, I'll update the post with that
information.

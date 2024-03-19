# Understanding EDITO resources

This documentation provides detail on how the EDITO cloud infrastructure resources work.
It focuses on the behavior, current configuration and quotas for the use of both internal computing cluster and storage.

## Computing cluster

### Elastic cluster

EDITO hosts its own cloud computing cluster, allowing users to run services and processes without having to think too much about the underlying infrastructure (virtual machine, CPU, GPU, etc.).
The cluster is configured in a way to optimized computational resource usage at any time, by automatically scaling up and down computation nodes.
For example, when a user start a service, it will by default run on one of this node. The system automatically choose a node that have enough resources (CPU, RAM, disk storage) to host the new service. If not active node has enough resources, a new node will be automatically provisioned to host the service.
In case of dynamic provisioning, users can experience some latency before their brand new service is up and running.

### Virtual CPUs, milli CPUs

The computational resource a service need to run on the cluster is expressed as mCPU (milli CPU). The mCPU is used in cloud resources to express the amount of CPU usage time requested by a service to run.
While 1000 mCPU correspond to 1 vCPU (virtual CPU, users can consider a vCPU is a CPU), requesting 500 mCPU means the service will request 50% of the time of a CPU to run.
This means all the CPU's cores can be exploited at any time, allowing computation parallelization/multi-threading.
Specifically, it's not because you request less than 1000 mCPU that you can't run a multi-threaded service.

### CPU nodes and GPU nodes

Currently there are two types of computational nodes available in EDITO cloud computing cluster, CPU nodes and GPU nodes.
GPUs have a specific resources, such as VideoRAM.
To use GPU a user need to start a service or a process that is configured for GPUs.

### Current node configurations

The following table summarize the current cloud computing cluster configuration:

| Node type | vCores | RAM (GB) | Web Disk Storage SSD (GB) | VideoRAM | min. node count | max. node count |
| --------- | ------ | -------- | ------------------------- | -------- | --------------- | --------------- |
| CPU       | 8      | 32       | 128                       |          | 1               | 10              |
| GPU       | 4      | 28       | 80                        | 12       | 1               | 4               |

This configuration is arbitrary and does not reflect the capacity of the platform once fully operational.
Please contact the [support](mailto:edito-infra-dev@mercator-ocean.eu) if you need nodes with higher capabilities.

### Distributed computing frameworks

EDITO architecture supports distributed computing frameworks, such as Dask or Spark, that services or processes can rely on.
Please contact the [support](mailto:edito-infra-dev@mercator-ocean.eu) if you need access to a particular framework.

### Quotas

EDITO is public and share resources funded by the European Commission. To avoid abuses, users have usage quotas.
The follwing table summarize the current quotas for personal and [group projects](https://gitlab.mercator-ocean.fr/pub/edito-infra/edito-tutorials-content/-/blob/master/articles/group-projects.md):

| Project type | CPU vCores | RAM (GB) | Web Disk Storage SSD (GB) | GPU vCores | max. pod count |
| ------------ | ---------- | -------- | ------------------------- | ---------- | -------------- |
| Personal     | 8          | 32       | 50                        | 1          | 10             |
| Group        | 16         | 64       | 100                       | 4          | 20             |

Note: "pods" are entities in which services and processes run. For simplicity, one can consider a service or process needs one pod to run.

If your services or processes never launch, face performance issues, or are stopped without an explicit action of yours, the root cause might be due to these restrictions.
Please contact the [support](mailto:edito-infra-dev@mercator-ocean.eu) if you need bumped quotas.

## Data storage

EDITO provides elastic cloud object storages allowing users to personal, group and public data.
While not running on Amazon Web Service, the object storages are compatible with AWS S3 API.

### Quotas

EDITO is public and share resources funded by the European Commission. To avoid abuses, users have usage quotas.
The follwing table summarize the current quotas for personal and [group projects](https://gitlab.mercator-ocean.fr/pub/edito-infra/edito-tutorials-content/-/blob/master/articles/group-projects.md), as well of for the public storage.

| Storage visibility | Volume amount (GB) |
| ------------------ | ------------------ |
| Personal project   | 20                 |
| Group project      | 20                 |
| Public             | N/A                |

Please contact the [support](mailto:edito-infra-dev@mercator-ocean.eu) if you need bumped quotas.

## Localisation

Currently, main EDITO cloud resources are provided by CloudFerro in Warsaw region WAW3-1.

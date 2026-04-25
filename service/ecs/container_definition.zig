const aws = @import("aws");

const ContainerDependency = @import("container_dependency.zig").ContainerDependency;
const KeyValuePair = @import("key_value_pair.zig").KeyValuePair;
const EnvironmentFile = @import("environment_file.zig").EnvironmentFile;
const HostEntry = @import("host_entry.zig").HostEntry;
const FirelensConfiguration = @import("firelens_configuration.zig").FirelensConfiguration;
const HealthCheck = @import("health_check.zig").HealthCheck;
const LinuxParameters = @import("linux_parameters.zig").LinuxParameters;
const LogConfiguration = @import("log_configuration.zig").LogConfiguration;
const MountPoint = @import("mount_point.zig").MountPoint;
const PortMapping = @import("port_mapping.zig").PortMapping;
const RepositoryCredentials = @import("repository_credentials.zig").RepositoryCredentials;
const ResourceRequirement = @import("resource_requirement.zig").ResourceRequirement;
const ContainerRestartPolicy = @import("container_restart_policy.zig").ContainerRestartPolicy;
const Secret = @import("secret.zig").Secret;
const SystemControl = @import("system_control.zig").SystemControl;
const Ulimit = @import("ulimit.zig").Ulimit;
const VersionConsistency = @import("version_consistency.zig").VersionConsistency;
const VolumeFrom = @import("volume_from.zig").VolumeFrom;

/// Container definitions are used in task definitions to describe the different
/// containers that are launched as part of a task.
pub const ContainerDefinition = struct {
    /// The command that's passed to the container. This parameter maps to `Cmd` in
    /// the docker container create command and the `COMMAND` parameter to docker
    /// run. If there are multiple arguments, each argument is a separated string in
    /// the array.
    command: ?[]const []const u8 = null,

    /// The number of `cpu` units reserved for the container. This parameter maps to
    /// `CpuShares` in the docker container create command and the `--cpu-shares`
    /// option to docker run.
    ///
    /// This field is optional for tasks using the Fargate launch type, and the only
    /// requirement is that the total amount of CPU reserved for all containers
    /// within a task be lower than the task-level `cpu` value.
    ///
    /// You can determine the number of CPU units that are available per EC2
    /// instance type by multiplying the vCPUs listed for that instance type on the
    /// [Amazon EC2 Instances](http://aws.amazon.com/ec2/instance-types/) detail
    /// page by 1,024.
    ///
    /// Linux containers share unallocated CPU units with other containers on the
    /// container instance with the same ratio as their allocated amount. For
    /// example, if you run a single-container task on a single-core instance type
    /// with 512 CPU units specified for that container, and that's the only task
    /// running on the container instance, that container could use the full 1,024
    /// CPU unit share at any given time. However, if you launched another copy of
    /// the same task on that container instance, each task is guaranteed a minimum
    /// of 512 CPU units when needed. Moreover, each container could float to higher
    /// CPU usage if the other container was not using it. If both tasks were 100%
    /// active all of the time, they would be limited to 512 CPU units.
    ///
    /// On Linux container instances, the Docker daemon on the container instance
    /// uses the CPU value to calculate the relative CPU share ratios for running
    /// containers. The minimum valid CPU share value that the Linux kernel allows
    /// is 2, and the maximum valid CPU share value that the Linux kernel allows is
    /// 262144. However, the CPU parameter isn't required, and you can use CPU
    /// values below 2 or above 262144 in your container definitions. For CPU values
    /// below 2 (including null) or above 262144, the behavior varies based on your
    /// Amazon ECS container agent version:
    ///
    /// * **Agent versions less than or equal to 1.1.0:** Null and zero CPU values
    ///   are passed to Docker as 0, which Docker then converts to 1,024 CPU shares.
    ///   CPU values of 1 are passed to Docker as 1, which the Linux kernel converts
    ///   to two CPU shares.
    /// * **Agent versions greater than or equal to 1.2.0:** Null, zero, and CPU
    ///   values of 1 are passed to Docker as 2.
    /// * **Agent versions greater than or equal to 1.84.0:** CPU values greater
    ///   than 256 vCPU are passed to Docker as 256, which is equivalent to 262144
    ///   CPU shares.
    ///
    /// On Windows container instances, the CPU limit is enforced as an absolute
    /// limit, or a quota. Windows containers only have access to the specified
    /// amount of CPU that's described in the task definition. A null or zero CPU
    /// value is passed to Docker as `0`, which Windows interprets as 1% of one CPU.
    cpu: i32 = 0,

    /// A list of ARNs in SSM or Amazon S3 to a credential spec (`CredSpec`) file
    /// that configures the container for Active Directory authentication. We
    /// recommend that you use this parameter instead of the
    /// `dockerSecurityOptions`. The maximum number of ARNs is 1.
    ///
    /// There are two formats for each ARN.
    ///
    /// **credentialspecdomainless:MyARN**
    ///
    /// You use `credentialspecdomainless:MyARN` to provide a `CredSpec` with an
    /// additional section for a secret in Secrets Manager. You provide the login
    /// credentials to the domain in the secret.
    ///
    /// Each task that runs on any container instance can join different domains.
    ///
    /// You can use this format without joining the container instance to a domain.
    ///
    /// **credentialspec:MyARN**
    ///
    /// You use `credentialspec:MyARN` to provide a `CredSpec` for a single domain.
    ///
    /// You must join the container instance to the domain before you start any
    /// tasks that use this task definition.
    ///
    /// In both formats, replace `MyARN` with the ARN in SSM or Amazon S3.
    ///
    /// If you provide a `credentialspecdomainless:MyARN`, the `credspec` must
    /// provide a ARN in Secrets Manager for a secret containing the username,
    /// password, and the domain to connect to. For better security, the instance
    /// isn't joined to the domain for domainless authentication. Other applications
    /// on the instance can't use the domainless credentials. You can use this
    /// parameter to run tasks on the same instance, even it the tasks need to join
    /// different domains. For more information, see [Using gMSAs for Windows
    /// Containers](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/windows-gmsa.html) and [Using gMSAs for Linux Containers](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/linux-gmsa.html).
    credential_specs: ?[]const []const u8 = null,

    /// The dependencies defined for container startup and shutdown. A container can
    /// contain multiple dependencies on other containers in a task definition. When
    /// a dependency is defined for container startup, for container shutdown it is
    /// reversed.
    ///
    /// For tasks using the EC2 launch type, the container instances require at
    /// least version 1.26.0 of the container agent to turn on container
    /// dependencies. However, we recommend using the latest container agent
    /// version. For information about checking your agent version and updating to
    /// the latest version, see [Updating the Amazon ECS Container
    /// Agent](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-agent-update.html) in the *Amazon Elastic Container Service Developer Guide*. If you're using an Amazon ECS-optimized Linux AMI, your instance needs at least version 1.26.0-1 of the `ecs-init` package. If your container instances are launched from version `20190301` or later, then they contain the required versions of the container agent and `ecs-init`. For more information, see [Amazon ECS-optimized Linux AMI](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html) in the *Amazon Elastic Container Service Developer Guide*.
    ///
    /// For tasks using the Fargate launch type, the task or service requires the
    /// following platforms:
    ///
    /// * Linux platform version `1.3.0` or later.
    /// * Windows platform version `1.0.0` or later.
    depends_on: ?[]const ContainerDependency = null,

    /// When this parameter is true, networking is off within the container. This
    /// parameter maps to `NetworkDisabled` in the docker container create command.
    ///
    /// This parameter is not supported for Windows containers.
    disable_networking: ?bool = null,

    /// A list of DNS search domains that are presented to the container. This
    /// parameter maps to `DnsSearch` in the docker container create command and the
    /// `--dns-search` option to docker run.
    ///
    /// This parameter is not supported for Windows containers.
    dns_search_domains: ?[]const []const u8 = null,

    /// A list of DNS servers that are presented to the container. This parameter
    /// maps to `Dns` in the docker container create command and the `--dns` option
    /// to docker run.
    ///
    /// This parameter is not supported for Windows containers.
    dns_servers: ?[]const []const u8 = null,

    /// A key/value map of labels to add to the container. This parameter maps to
    /// `Labels` in the docker container create command and the `--label` option to
    /// docker run. This parameter requires version 1.18 of the Docker Remote API or
    /// greater on your container instance. To check the Docker Remote API version
    /// on your container instance, log in to your container instance and run the
    /// following command: `sudo docker version --format '{{.Server.APIVersion}}'`
    docker_labels: ?[]const aws.map.StringMapEntry = null,

    /// A list of strings to provide custom configuration for multiple security
    /// systems. This field isn't valid for containers in tasks using the Fargate
    /// launch type.
    ///
    /// For Linux tasks on EC2, this parameter can be used to reference custom
    /// labels for SELinux and AppArmor multi-level security systems.
    ///
    /// For any tasks on EC2, this parameter can be used to reference a credential
    /// spec file that configures a container for Active Directory authentication.
    /// For more information, see [Using gMSAs for Windows
    /// Containers](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/windows-gmsa.html) and [Using gMSAs for Linux Containers](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/linux-gmsa.html) in the *Amazon Elastic Container Service Developer Guide*.
    ///
    /// This parameter maps to `SecurityOpt` in the docker container create command
    /// and the `--security-opt` option to docker run.
    ///
    /// The Amazon ECS container agent running on a container instance must register
    /// with the `ECS_SELINUX_CAPABLE=true` or `ECS_APPARMOR_CAPABLE=true`
    /// environment variables before containers placed on that instance can use
    /// these security options. For more information, see [Amazon ECS Container
    /// Agent
    /// Configuration](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-agent-config.html) in the *Amazon Elastic Container Service Developer Guide*.
    ///
    /// Valid values: "no-new-privileges" | "apparmor:PROFILE" | "label:value" |
    /// "credentialspec:CredentialSpecFilePath"
    docker_security_options: ?[]const []const u8 = null,

    /// Early versions of the Amazon ECS container agent don't properly handle
    /// `entryPoint` parameters. If you have problems using `entryPoint`, update
    /// your container agent or enter your commands and arguments as `command` array
    /// items instead.
    ///
    /// The entry point that's passed to the container. This parameter maps to
    /// `Entrypoint` in the docker container create command and the `--entrypoint`
    /// option to docker run.
    entry_point: ?[]const []const u8 = null,

    /// The environment variables to pass to a container. This parameter maps to
    /// `Env` in the docker container create command and the `--env` option to
    /// docker run.
    ///
    /// We don't recommend that you use plaintext environment variables for
    /// sensitive information, such as credential data.
    environment: ?[]const KeyValuePair = null,

    /// A list of files containing the environment variables to pass to a container.
    /// This parameter maps to the `--env-file` option to docker run.
    ///
    /// You can specify up to ten environment files. The file must have a `.env`
    /// file extension. Each line in an environment file contains an environment
    /// variable in `VARIABLE=VALUE` format. Lines beginning with `#` are treated as
    /// comments and are ignored.
    ///
    /// If there are environment variables specified using the `environment`
    /// parameter in a container definition, they take precedence over the variables
    /// contained within an environment file. If multiple environment files are
    /// specified that contain the same variable, they're processed from the top
    /// down. We recommend that you use unique variable names. For more information,
    /// see [Specifying Environment
    /// Variables](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/taskdef-envfiles.html) in the *Amazon Elastic Container Service Developer Guide*.
    environment_files: ?[]const EnvironmentFile = null,

    /// If the `essential` parameter of a container is marked as `true`, and that
    /// container fails or stops for any reason, all other containers that are part
    /// of the task are stopped. If the `essential` parameter of a container is
    /// marked as `false`, its failure doesn't affect the rest of the containers in
    /// a task. If this parameter is omitted, a container is assumed to be
    /// essential.
    ///
    /// All tasks must have at least one essential container. If you have an
    /// application that's composed of multiple containers, group containers that
    /// are used for a common purpose into components, and separate the different
    /// components into multiple task definitions. For more information, see
    /// [Application
    /// Architecture](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/application_architecture.html) in the *Amazon Elastic Container Service Developer Guide*.
    essential: ?bool = null,

    /// A list of hostnames and IP address mappings to append to the `/etc/hosts`
    /// file on the container. This parameter maps to `ExtraHosts` in the docker
    /// container create command and the `--add-host` option to docker run.
    ///
    /// This parameter isn't supported for Windows containers or tasks that use the
    /// `awsvpc` network mode.
    extra_hosts: ?[]const HostEntry = null,

    /// The FireLens configuration for the container. This is used to specify and
    /// configure a log router for container logs. For more information, see [Custom
    /// Log
    /// Routing](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/using_firelens.html) in the *Amazon Elastic Container Service Developer Guide*.
    firelens_configuration: ?FirelensConfiguration = null,

    /// The container health check command and associated configuration parameters
    /// for the container. This parameter maps to `HealthCheck` in the docker
    /// container create command and the `HEALTHCHECK` parameter of docker run.
    health_check: ?HealthCheck = null,

    /// The hostname to use for your container. This parameter maps to `Hostname` in
    /// the docker container create command and the `--hostname` option to docker
    /// run.
    ///
    /// The `hostname` parameter is not supported if you're using the `awsvpc`
    /// network mode.
    hostname: ?[]const u8 = null,

    /// The image used to start a container. This string is passed directly to the
    /// Docker daemon. By default, images in the Docker Hub registry are available.
    /// Other repositories are specified with either `
    /// *repository-url*/*image*:*tag* ` or ` *repository-url*/*image*@*digest* `.
    /// For images using tags (repository-url/image:tag), up to 255 characters total
    /// are allowed, including letters (uppercase and lowercase), numbers, hyphens,
    /// underscores, colons, periods, forward slashes, and number signs (#). For
    /// images using digests (repository-url/image@digest), the 255 character limit
    /// applies only to the repository URL and image name (everything before the @
    /// sign). The only supported hash function is sha256, and the hash value after
    /// sha256: must be exactly 64 characters (only letters A-F, a-f, and numbers
    /// 0-9 are allowed). This parameter maps to `Image` in the docker container
    /// create command and the `IMAGE` parameter of docker run.
    ///
    /// * When a new task starts, the Amazon ECS container agent pulls the latest
    ///   version of the specified image and tag for the container to use. However,
    ///   subsequent updates to a repository image aren't propagated to already
    ///   running tasks.
    /// * Images in Amazon ECR repositories can be specified by either using the
    ///   full `registry/repository:tag` or `registry/repository@digest`. For
    ///   example,
    ///   `012345678910.dkr.ecr.<region-name>.amazonaws.com/<repository-name>:latest` or `012345678910.dkr.ecr.<region-name>.amazonaws.com/<repository-name>@sha256:94afd1f2e64d908bc90dbca0035a5b567EXAMPLE`.
    /// * Images in official repositories on Docker Hub use a single name (for
    ///   example, `ubuntu` or `mongo`).
    /// * Images in other repositories on Docker Hub are qualified with an
    ///   organization name (for example, `amazon/amazon-ecs-agent`).
    /// * Images in other online repositories are qualified further by a domain name
    ///   (for example, `quay.io/assemblyline/ubuntu`).
    image: ?[]const u8 = null,

    /// When this parameter is `true`, you can deploy containerized applications
    /// that require `stdin` or a `tty` to be allocated. This parameter maps to
    /// `OpenStdin` in the docker container create command and the `--interactive`
    /// option to docker run.
    interactive: ?bool = null,

    /// The `links` parameter allows containers to communicate with each other
    /// without the need for port mappings. This parameter is only supported if the
    /// network mode of a task definition is `bridge`. The `name:internalName`
    /// construct is analogous to `name:alias` in Docker links. Up to 255 letters
    /// (uppercase and lowercase), numbers, underscores, and hyphens are allowed..
    /// This parameter maps to `Links` in the docker container create command and
    /// the `--link` option to docker run.
    ///
    /// This parameter is not supported for Windows containers.
    ///
    /// Containers that are collocated on a single container instance may be able to
    /// communicate with each other without requiring links or host port mappings.
    /// Network isolation is achieved on the container instance using security
    /// groups and VPC settings.
    links: ?[]const []const u8 = null,

    /// Linux-specific modifications that are applied to the default Docker
    /// container configuration, such as Linux kernel capabilities. For more
    /// information see
    /// [KernelCapabilities](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_KernelCapabilities.html).
    ///
    /// This parameter is not supported for Windows containers.
    linux_parameters: ?LinuxParameters = null,

    /// The log configuration specification for the container.
    ///
    /// This parameter maps to `LogConfig` in the docker container create command
    /// and the `--log-driver` option to docker run. By default, containers use the
    /// same logging driver that the Docker daemon uses. However the container can
    /// use a different logging driver than the Docker daemon by specifying a log
    /// driver with this parameter in the container definition. To use a different
    /// logging driver for a container, the log system must be configured properly
    /// on the container instance (or on a different log server for remote logging
    /// options).
    ///
    /// Amazon ECS currently supports a subset of the logging drivers available to
    /// the Docker daemon (shown in the
    /// [LogConfiguration](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_LogConfiguration.html) data type). Additional log drivers may be available in future releases of the Amazon ECS container agent.
    ///
    /// This parameter requires version 1.18 of the Docker Remote API or greater on
    /// your container instance. To check the Docker Remote API version on your
    /// container instance, log in to your container instance and run the following
    /// command: `sudo docker version --format '{{.Server.APIVersion}}'`
    ///
    /// The Amazon ECS container agent running on a container instance must register
    /// the logging drivers available on that instance with the
    /// `ECS_AVAILABLE_LOGGING_DRIVERS` environment variable before containers
    /// placed on that instance can use these log configuration options. For more
    /// information, see [Amazon ECS Container Agent
    /// Configuration](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-agent-config.html) in the *Amazon Elastic Container Service Developer Guide*.
    log_configuration: ?LogConfiguration = null,

    /// The amount (in MiB) of memory to present to the container. If your container
    /// attempts to exceed the memory specified here, the container is killed. The
    /// total amount of memory reserved for all containers within a task must be
    /// lower than the task `memory` value, if one is specified. This parameter maps
    /// to `Memory` in the docker container create command and the `--memory` option
    /// to docker run.
    ///
    /// If using the Fargate launch type, this parameter is optional.
    ///
    /// If using the EC2 launch type, you must specify either a task-level memory
    /// value or a container-level memory value. If you specify both a
    /// container-level `memory` and `memoryReservation` value, `memory` must be
    /// greater than `memoryReservation`. If you specify `memoryReservation`, then
    /// that value is subtracted from the available memory resources for the
    /// container instance where the container is placed. Otherwise, the value of
    /// `memory` is used.
    ///
    /// The Docker 20.10.0 or later daemon reserves a minimum of 6 MiB of memory for
    /// a container. So, don't specify less than 6 MiB of memory for your
    /// containers.
    ///
    /// The Docker 19.03.13-ce or earlier daemon reserves a minimum of 4 MiB of
    /// memory for a container. So, don't specify less than 4 MiB of memory for your
    /// containers.
    memory: ?i32 = null,

    /// The soft limit (in MiB) of memory to reserve for the container. When system
    /// memory is under heavy contention, Docker attempts to keep the container
    /// memory to this soft limit. However, your container can consume more memory
    /// when it needs to, up to either the hard limit specified with the `memory`
    /// parameter (if applicable), or all of the available memory on the container
    /// instance, whichever comes first. This parameter maps to `MemoryReservation`
    /// in the docker container create command and the `--memory-reservation` option
    /// to docker run.
    ///
    /// If a task-level memory value is not specified, you must specify a non-zero
    /// integer for one or both of `memory` or `memoryReservation` in a container
    /// definition. If you specify both, `memory` must be greater than
    /// `memoryReservation`. If you specify `memoryReservation`, then that value is
    /// subtracted from the available memory resources for the container instance
    /// where the container is placed. Otherwise, the value of `memory` is used.
    ///
    /// For example, if your container normally uses 128 MiB of memory, but
    /// occasionally bursts to 256 MiB of memory for short periods of time, you can
    /// set a `memoryReservation` of 128 MiB, and a `memory` hard limit of 300 MiB.
    /// This configuration would allow the container to only reserve 128 MiB of
    /// memory from the remaining resources on the container instance, but also
    /// allow the container to consume more memory resources when needed.
    ///
    /// The Docker 20.10.0 or later daemon reserves a minimum of 6 MiB of memory for
    /// a container. So, don't specify less than 6 MiB of memory for your
    /// containers.
    ///
    /// The Docker 19.03.13-ce or earlier daemon reserves a minimum of 4 MiB of
    /// memory for a container. So, don't specify less than 4 MiB of memory for your
    /// containers.
    memory_reservation: ?i32 = null,

    /// The mount points for data volumes in your container.
    ///
    /// This parameter maps to `Volumes` in the docker container create command and
    /// the `--volume` option to docker run.
    ///
    /// Windows containers can mount whole directories on the same drive as
    /// `$env:ProgramData`. Windows containers can't mount directories on a
    /// different drive, and mount point can't be across drives.
    mount_points: ?[]const MountPoint = null,

    /// The name of a container. If you're linking multiple containers together in a
    /// task definition, the `name` of one container can be entered in the `links`
    /// of another container to connect the containers. Up to 255 letters (uppercase
    /// and lowercase), numbers, underscores, and hyphens are allowed. This
    /// parameter maps to `name` in the docker container create command and the
    /// `--name` option to docker run.
    name: ?[]const u8 = null,

    /// The list of port mappings for the container. Port mappings allow containers
    /// to access ports on the host container instance to send or receive traffic.
    ///
    /// For task definitions that use the `awsvpc` network mode, only specify the
    /// `containerPort`. The `hostPort` can be left blank or it must be the same
    /// value as the `containerPort`.
    ///
    /// Port mappings on Windows use the `NetNAT` gateway address rather than
    /// `localhost`. There's no loopback for port mappings on Windows, so you can't
    /// access a container's mapped port from the host itself.
    ///
    /// This parameter maps to `PortBindings` in the docker container create command
    /// and the `--publish` option to docker run. If the network mode of a task
    /// definition is set to `none`, then you can't specify port mappings. If the
    /// network mode of a task definition is set to `host`, then host ports must
    /// either be undefined or they must match the container port in the port
    /// mapping.
    ///
    /// After a task reaches the `RUNNING` status, manual and automatic host and
    /// container port assignments are visible in the **Network Bindings** section
    /// of a container description for a selected task in the Amazon ECS console.
    /// The assignments are also visible in the `networkBindings` section
    /// [DescribeTasks](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_DescribeTasks.html) responses.
    port_mappings: ?[]const PortMapping = null,

    /// When this parameter is true, the container is given elevated privileges on
    /// the host container instance (similar to the `root` user). This parameter
    /// maps to `Privileged` in the docker container create command and the
    /// `--privileged` option to docker run
    ///
    /// This parameter is not supported for Windows containers or tasks run on
    /// Fargate.
    privileged: ?bool = null,

    /// When this parameter is `true`, a TTY is allocated. This parameter maps to
    /// `Tty` in the docker container create command and the `--tty` option to
    /// docker run.
    pseudo_terminal: ?bool = null,

    /// When this parameter is true, the container is given read-only access to its
    /// root file system. This parameter maps to `ReadonlyRootfs` in the docker
    /// container create command and the `--read-only` option to docker run.
    ///
    /// This parameter is not supported for Windows containers.
    readonly_root_filesystem: ?bool = null,

    /// The private repository authentication credentials to use.
    repository_credentials: ?RepositoryCredentials = null,

    /// The type and amount of a resource to assign to a container. The only
    /// supported resource is a GPU.
    resource_requirements: ?[]const ResourceRequirement = null,

    /// The restart policy for a container. When you set up a restart policy, Amazon
    /// ECS can restart the container without needing to replace the task. For more
    /// information, see [Restart individual containers in Amazon ECS tasks with
    /// container restart
    /// policies](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/container-restart-policy.html) in the *Amazon Elastic Container Service Developer Guide*.
    restart_policy: ?ContainerRestartPolicy = null,

    /// The secrets to pass to the container. For more information, see [Specifying
    /// Sensitive
    /// Data](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/specifying-sensitive-data.html) in the *Amazon Elastic Container Service Developer Guide*.
    secrets: ?[]const Secret = null,

    /// Time duration (in seconds) to wait before giving up on resolving
    /// dependencies for a container. For example, you specify two containers in a
    /// task definition with containerA having a dependency on containerB reaching a
    /// `COMPLETE`, `SUCCESS`, or `HEALTHY` status. If a `startTimeout` value is
    /// specified for containerB and it doesn't reach the desired status within that
    /// time then containerA gives up and not start. This results in the task
    /// transitioning to a `STOPPED` state.
    ///
    /// When the `ECS_CONTAINER_START_TIMEOUT` container agent configuration
    /// variable is used, it's enforced independently from this start timeout value.
    ///
    /// For tasks using the Fargate launch type, the task or service requires the
    /// following platforms:
    ///
    /// * Linux platform version `1.3.0` or later.
    /// * Windows platform version `1.0.0` or later.
    ///
    /// For tasks using the EC2 launch type, your container instances require at
    /// least version `1.26.0` of the container agent to use a container start
    /// timeout value. However, we recommend using the latest container agent
    /// version. For information about checking your agent version and updating to
    /// the latest version, see [Updating the Amazon ECS Container
    /// Agent](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-agent-update.html) in the *Amazon Elastic Container Service Developer Guide*. If you're using an Amazon ECS-optimized Linux AMI, your instance needs at least version `1.26.0-1` of the `ecs-init` package. If your container instances are launched from version `20190301` or later, then they contain the required versions of the container agent and `ecs-init`. For more information, see [Amazon ECS-optimized Linux AMI](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html) in the *Amazon Elastic Container Service Developer Guide*.
    ///
    /// The valid values for Fargate are 2-120 seconds.
    start_timeout: ?i32 = null,

    /// Time duration (in seconds) to wait before the container is forcefully killed
    /// if it doesn't exit normally on its own.
    ///
    /// For tasks using the Fargate launch type, the task or service requires the
    /// following platforms:
    ///
    /// * Linux platform version `1.3.0` or later.
    /// * Windows platform version `1.0.0` or later.
    ///
    /// For tasks that use the Fargate launch type, the max stop timeout value is
    /// 120 seconds and if the parameter is not specified, the default value of 30
    /// seconds is used.
    ///
    /// For tasks that use the EC2 launch type, if the `stopTimeout` parameter isn't
    /// specified, the value set for the Amazon ECS container agent configuration
    /// variable `ECS_CONTAINER_STOP_TIMEOUT` is used. If neither the `stopTimeout`
    /// parameter or the `ECS_CONTAINER_STOP_TIMEOUT` agent configuration variable
    /// are set, then the default values of 30 seconds for Linux containers and 30
    /// seconds on Windows containers are used. Your container instances require at
    /// least version 1.26.0 of the container agent to use a container stop timeout
    /// value. However, we recommend using the latest container agent version. For
    /// information about checking your agent version and updating to the latest
    /// version, see [Updating the Amazon ECS Container
    /// Agent](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-agent-update.html) in the *Amazon Elastic Container Service Developer Guide*. If you're using an Amazon ECS-optimized Linux AMI, your instance needs at least version 1.26.0-1 of the `ecs-init` package. If your container instances are launched from version `20190301` or later, then they contain the required versions of the container agent and `ecs-init`. For more information, see [Amazon ECS-optimized Linux AMI](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html) in the *Amazon Elastic Container Service Developer Guide*.
    ///
    /// The valid values for Fargate are 2-120 seconds.
    stop_timeout: ?i32 = null,

    /// A list of namespaced kernel parameters to set in the container. This
    /// parameter maps to `Sysctls` in the docker container create command and the
    /// `--sysctl` option to docker run. For example, you can configure
    /// `net.ipv4.tcp_keepalive_time` setting to maintain longer lived connections.
    system_controls: ?[]const SystemControl = null,

    /// A list of `ulimits` to set in the container. If a `ulimit` value is
    /// specified in a task definition, it overrides the default values set by
    /// Docker. This parameter maps to `Ulimits` in the docker container create
    /// command and the `--ulimit` option to docker run. Valid naming values are
    /// displayed in the
    /// [Ulimit](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_Ulimit.html) data type.
    ///
    /// Amazon ECS tasks hosted on Fargate use the default resource limit values set
    /// by the operating system with the exception of the `nofile` resource limit
    /// parameter which Fargate overrides. The `nofile` resource limit sets a
    /// restriction on the number of open files that a container can use. The
    /// default `nofile` soft limit is ` 65535` and the default hard limit is
    /// `65535`.
    ///
    /// This parameter requires version 1.18 of the Docker Remote API or greater on
    /// your container instance. To check the Docker Remote API version on your
    /// container instance, log in to your container instance and run the following
    /// command: `sudo docker version --format '{{.Server.APIVersion}}'`
    ///
    /// This parameter is not supported for Windows containers.
    ulimits: ?[]const Ulimit = null,

    /// The user to use inside the container. This parameter maps to `User` in the
    /// docker container create command and the `--user` option to docker run.
    ///
    /// When running tasks using the `host` network mode, don't run containers using
    /// the root user (UID 0). We recommend using a non-root user for better
    /// security.
    ///
    /// You can specify the `user` using the following formats. If specifying a UID
    /// or GID, you must specify it as a positive integer.
    ///
    /// * `user`
    /// * `user:group`
    /// * `uid`
    /// * `uid:gid`
    /// * `user:gid`
    /// * `uid:group`
    ///
    /// This parameter is not supported for Windows containers.
    user: ?[]const u8 = null,

    /// Specifies whether Amazon ECS will resolve the container image tag provided
    /// in the container definition to an image digest. By default, the value is
    /// `enabled`. If you set the value for a container as `disabled`, Amazon ECS
    /// will not resolve the provided container image tag to a digest and will use
    /// the original image URI specified in the container definition for deployment.
    /// For more information about container image resolution, see [Container image
    /// resolution](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/deployment-type-ecs.html#deployment-container-image-stability) in the *Amazon ECS Developer Guide*.
    version_consistency: ?VersionConsistency = null,

    /// Data volumes to mount from another container. This parameter maps to
    /// `VolumesFrom` in the docker container create command and the
    /// `--volumes-from` option to docker run.
    volumes_from: ?[]const VolumeFrom = null,

    /// The working directory to run commands inside the container in. This
    /// parameter maps to `WorkingDir` in the docker container create command and
    /// the `--workdir` option to docker run.
    working_directory: ?[]const u8 = null,

    pub const json_field_names = .{
        .command = "command",
        .cpu = "cpu",
        .credential_specs = "credentialSpecs",
        .depends_on = "dependsOn",
        .disable_networking = "disableNetworking",
        .dns_search_domains = "dnsSearchDomains",
        .dns_servers = "dnsServers",
        .docker_labels = "dockerLabels",
        .docker_security_options = "dockerSecurityOptions",
        .entry_point = "entryPoint",
        .environment = "environment",
        .environment_files = "environmentFiles",
        .essential = "essential",
        .extra_hosts = "extraHosts",
        .firelens_configuration = "firelensConfiguration",
        .health_check = "healthCheck",
        .hostname = "hostname",
        .image = "image",
        .interactive = "interactive",
        .links = "links",
        .linux_parameters = "linuxParameters",
        .log_configuration = "logConfiguration",
        .memory = "memory",
        .memory_reservation = "memoryReservation",
        .mount_points = "mountPoints",
        .name = "name",
        .port_mappings = "portMappings",
        .privileged = "privileged",
        .pseudo_terminal = "pseudoTerminal",
        .readonly_root_filesystem = "readonlyRootFilesystem",
        .repository_credentials = "repositoryCredentials",
        .resource_requirements = "resourceRequirements",
        .restart_policy = "restartPolicy",
        .secrets = "secrets",
        .start_timeout = "startTimeout",
        .stop_timeout = "stopTimeout",
        .system_controls = "systemControls",
        .ulimits = "ulimits",
        .user = "user",
        .version_consistency = "versionConsistency",
        .volumes_from = "volumesFrom",
        .working_directory = "workingDirectory",
    };
};

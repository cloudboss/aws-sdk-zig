const aws = @import("aws");

const AwsEcsTaskDefinitionContainerDefinitionsDependsOnDetails = @import("aws_ecs_task_definition_container_definitions_depends_on_details.zig").AwsEcsTaskDefinitionContainerDefinitionsDependsOnDetails;
const AwsEcsTaskDefinitionContainerDefinitionsEnvironmentDetails = @import("aws_ecs_task_definition_container_definitions_environment_details.zig").AwsEcsTaskDefinitionContainerDefinitionsEnvironmentDetails;
const AwsEcsTaskDefinitionContainerDefinitionsEnvironmentFilesDetails = @import("aws_ecs_task_definition_container_definitions_environment_files_details.zig").AwsEcsTaskDefinitionContainerDefinitionsEnvironmentFilesDetails;
const AwsEcsTaskDefinitionContainerDefinitionsExtraHostsDetails = @import("aws_ecs_task_definition_container_definitions_extra_hosts_details.zig").AwsEcsTaskDefinitionContainerDefinitionsExtraHostsDetails;
const AwsEcsTaskDefinitionContainerDefinitionsFirelensConfigurationDetails = @import("aws_ecs_task_definition_container_definitions_firelens_configuration_details.zig").AwsEcsTaskDefinitionContainerDefinitionsFirelensConfigurationDetails;
const AwsEcsTaskDefinitionContainerDefinitionsHealthCheckDetails = @import("aws_ecs_task_definition_container_definitions_health_check_details.zig").AwsEcsTaskDefinitionContainerDefinitionsHealthCheckDetails;
const AwsEcsTaskDefinitionContainerDefinitionsLinuxParametersDetails = @import("aws_ecs_task_definition_container_definitions_linux_parameters_details.zig").AwsEcsTaskDefinitionContainerDefinitionsLinuxParametersDetails;
const AwsEcsTaskDefinitionContainerDefinitionsLogConfigurationDetails = @import("aws_ecs_task_definition_container_definitions_log_configuration_details.zig").AwsEcsTaskDefinitionContainerDefinitionsLogConfigurationDetails;
const AwsEcsTaskDefinitionContainerDefinitionsMountPointsDetails = @import("aws_ecs_task_definition_container_definitions_mount_points_details.zig").AwsEcsTaskDefinitionContainerDefinitionsMountPointsDetails;
const AwsEcsTaskDefinitionContainerDefinitionsPortMappingsDetails = @import("aws_ecs_task_definition_container_definitions_port_mappings_details.zig").AwsEcsTaskDefinitionContainerDefinitionsPortMappingsDetails;
const AwsEcsTaskDefinitionContainerDefinitionsRepositoryCredentialsDetails = @import("aws_ecs_task_definition_container_definitions_repository_credentials_details.zig").AwsEcsTaskDefinitionContainerDefinitionsRepositoryCredentialsDetails;
const AwsEcsTaskDefinitionContainerDefinitionsResourceRequirementsDetails = @import("aws_ecs_task_definition_container_definitions_resource_requirements_details.zig").AwsEcsTaskDefinitionContainerDefinitionsResourceRequirementsDetails;
const AwsEcsTaskDefinitionContainerDefinitionsSecretsDetails = @import("aws_ecs_task_definition_container_definitions_secrets_details.zig").AwsEcsTaskDefinitionContainerDefinitionsSecretsDetails;
const AwsEcsTaskDefinitionContainerDefinitionsSystemControlsDetails = @import("aws_ecs_task_definition_container_definitions_system_controls_details.zig").AwsEcsTaskDefinitionContainerDefinitionsSystemControlsDetails;
const AwsEcsTaskDefinitionContainerDefinitionsUlimitsDetails = @import("aws_ecs_task_definition_container_definitions_ulimits_details.zig").AwsEcsTaskDefinitionContainerDefinitionsUlimitsDetails;
const AwsEcsTaskDefinitionContainerDefinitionsVolumesFromDetails = @import("aws_ecs_task_definition_container_definitions_volumes_from_details.zig").AwsEcsTaskDefinitionContainerDefinitionsVolumesFromDetails;

/// A container definition that describes a container in the task.
pub const AwsEcsTaskDefinitionContainerDefinitionsDetails = struct {
    /// The command that is passed to the container.
    command: ?[]const []const u8 = null,

    /// The number of CPU units reserved for the container.
    cpu: ?i32 = null,

    /// The dependencies that are defined for container startup and shutdown.
    depends_on: ?[]const AwsEcsTaskDefinitionContainerDefinitionsDependsOnDetails = null,

    /// Whether to disable networking within the container.
    disable_networking: ?bool = null,

    /// A list of DNS search domains that are presented to the container.
    dns_search_domains: ?[]const []const u8 = null,

    /// A list of DNS servers that are presented to the container.
    dns_servers: ?[]const []const u8 = null,

    /// A key-value map of labels to add to the container.
    docker_labels: ?[]const aws.map.StringMapEntry = null,

    /// A list of strings to provide custom labels for SELinux and AppArmor
    /// multi-level security systems.
    docker_security_options: ?[]const []const u8 = null,

    /// The entry point that is passed to the container.
    entry_point: ?[]const []const u8 = null,

    /// The environment variables to pass to a container.
    environment: ?[]const AwsEcsTaskDefinitionContainerDefinitionsEnvironmentDetails = null,

    /// A list of files containing the environment variables to pass to a container.
    environment_files: ?[]const AwsEcsTaskDefinitionContainerDefinitionsEnvironmentFilesDetails = null,

    /// Whether the container is essential. All tasks must have at least one
    /// essential container.
    essential: ?bool = null,

    /// A list of hostnames and IP address mappings to append to the **/etc/hosts**
    /// file on the container.
    extra_hosts: ?[]const AwsEcsTaskDefinitionContainerDefinitionsExtraHostsDetails = null,

    /// The FireLens configuration for the container. Specifies and configures a log
    /// router for container logs.
    firelens_configuration: ?AwsEcsTaskDefinitionContainerDefinitionsFirelensConfigurationDetails = null,

    /// The container health check command and associated configuration parameters
    /// for the container.
    health_check: ?AwsEcsTaskDefinitionContainerDefinitionsHealthCheckDetails = null,

    /// The hostname to use for the container.
    hostname: ?[]const u8 = null,

    /// The image used to start the container.
    image: ?[]const u8 = null,

    /// If set to true, then containerized applications can be deployed that require
    /// `stdin` or a `tty` to be allocated.
    interactive: ?bool = null,

    /// A list of links for the container in the form `
    /// *container_name*:*alias*
    /// `. Allows containers to communicate with each other without the need for
    /// port mappings.
    links: ?[]const []const u8 = null,

    /// Linux-specific modifications that are applied to the container, such as
    /// Linux kernel capabilities.
    linux_parameters: ?AwsEcsTaskDefinitionContainerDefinitionsLinuxParametersDetails = null,

    /// The log configuration specification for the container.
    log_configuration: ?AwsEcsTaskDefinitionContainerDefinitionsLogConfigurationDetails = null,

    /// The amount (in MiB) of memory to present to the container. If the container
    /// attempts to exceed the memory specified here, the container is shut down.
    /// The total amount of memory reserved for all containers within a task must be
    /// lower than the task memory value, if one is specified.
    memory: ?i32 = null,

    /// The soft limit (in MiB) of memory to reserve for the container.
    memory_reservation: ?i32 = null,

    /// The mount points for the data volumes in the container.
    mount_points: ?[]const AwsEcsTaskDefinitionContainerDefinitionsMountPointsDetails = null,

    /// The name of the container.
    name: ?[]const u8 = null,

    /// The list of port mappings for the container.
    port_mappings: ?[]const AwsEcsTaskDefinitionContainerDefinitionsPortMappingsDetails = null,

    /// Whether the container is given elevated privileges on the host container
    /// instance. The elevated privileges are similar to the root user.
    privileged: ?bool = null,

    /// Whether to allocate a TTY to the container.
    pseudo_terminal: ?bool = null,

    /// Whether the container is given read-only access to its root file system.
    readonly_root_filesystem: ?bool = null,

    /// The private repository authentication credentials to use.
    repository_credentials: ?AwsEcsTaskDefinitionContainerDefinitionsRepositoryCredentialsDetails = null,

    /// The type and amount of a resource to assign to a container. The only
    /// supported resource is a GPU.
    resource_requirements: ?[]const AwsEcsTaskDefinitionContainerDefinitionsResourceRequirementsDetails = null,

    /// The secrets to pass to the container.
    secrets: ?[]const AwsEcsTaskDefinitionContainerDefinitionsSecretsDetails = null,

    /// The number of seconds to wait before giving up on resolving dependencies for
    /// a container.
    start_timeout: ?i32 = null,

    /// The number of seconds to wait before the container is stopped if it doesn't
    /// shut down normally on its own.
    stop_timeout: ?i32 = null,

    /// A list of namespaced kernel parameters to set in the container.
    system_controls: ?[]const AwsEcsTaskDefinitionContainerDefinitionsSystemControlsDetails = null,

    /// A list of ulimits to set in the container.
    ulimits: ?[]const AwsEcsTaskDefinitionContainerDefinitionsUlimitsDetails = null,

    /// The user to use inside the container.
    ///
    /// The value can use one of the following formats.
    ///
    /// * `
    /// *user*
    /// `
    ///
    /// * `
    /// *user*
    /// `:`
    /// *group*
    /// `
    ///
    /// * `
    /// *uid*
    /// `
    ///
    /// * `
    /// *uid*
    /// `:`
    /// *gid*
    /// `
    ///
    /// * `
    /// *user*
    /// `:`
    /// *gid*
    /// `
    ///
    /// * `
    /// *uid*
    /// `:`
    /// *group*
    /// `
    user: ?[]const u8 = null,

    /// Data volumes to mount from another container.
    volumes_from: ?[]const AwsEcsTaskDefinitionContainerDefinitionsVolumesFromDetails = null,

    /// The working directory in which to run commands inside the container.
    working_directory: ?[]const u8 = null,

    pub const json_field_names = .{
        .command = "Command",
        .cpu = "Cpu",
        .depends_on = "DependsOn",
        .disable_networking = "DisableNetworking",
        .dns_search_domains = "DnsSearchDomains",
        .dns_servers = "DnsServers",
        .docker_labels = "DockerLabels",
        .docker_security_options = "DockerSecurityOptions",
        .entry_point = "EntryPoint",
        .environment = "Environment",
        .environment_files = "EnvironmentFiles",
        .essential = "Essential",
        .extra_hosts = "ExtraHosts",
        .firelens_configuration = "FirelensConfiguration",
        .health_check = "HealthCheck",
        .hostname = "Hostname",
        .image = "Image",
        .interactive = "Interactive",
        .links = "Links",
        .linux_parameters = "LinuxParameters",
        .log_configuration = "LogConfiguration",
        .memory = "Memory",
        .memory_reservation = "MemoryReservation",
        .mount_points = "MountPoints",
        .name = "Name",
        .port_mappings = "PortMappings",
        .privileged = "Privileged",
        .pseudo_terminal = "PseudoTerminal",
        .readonly_root_filesystem = "ReadonlyRootFilesystem",
        .repository_credentials = "RepositoryCredentials",
        .resource_requirements = "ResourceRequirements",
        .secrets = "Secrets",
        .start_timeout = "StartTimeout",
        .stop_timeout = "StopTimeout",
        .system_controls = "SystemControls",
        .ulimits = "Ulimits",
        .user = "User",
        .volumes_from = "VolumesFrom",
        .working_directory = "WorkingDirectory",
    };
};

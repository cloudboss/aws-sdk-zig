const AwsEcsTaskDefinitionContainerDefinitionsLinuxParametersCapabilitiesDetails = @import("aws_ecs_task_definition_container_definitions_linux_parameters_capabilities_details.zig").AwsEcsTaskDefinitionContainerDefinitionsLinuxParametersCapabilitiesDetails;
const AwsEcsTaskDefinitionContainerDefinitionsLinuxParametersDevicesDetails = @import("aws_ecs_task_definition_container_definitions_linux_parameters_devices_details.zig").AwsEcsTaskDefinitionContainerDefinitionsLinuxParametersDevicesDetails;
const AwsEcsTaskDefinitionContainerDefinitionsLinuxParametersTmpfsDetails = @import("aws_ecs_task_definition_container_definitions_linux_parameters_tmpfs_details.zig").AwsEcsTaskDefinitionContainerDefinitionsLinuxParametersTmpfsDetails;

/// >Linux-specific modifications that are applied to the container, such as
/// Linux kernel capabilities.
pub const AwsEcsTaskDefinitionContainerDefinitionsLinuxParametersDetails = struct {
    /// The Linux capabilities for the container that are added to or dropped from
    /// the default configuration provided by Docker.
    capabilities: ?AwsEcsTaskDefinitionContainerDefinitionsLinuxParametersCapabilitiesDetails,

    /// The host devices to expose to the container.
    devices: ?[]const AwsEcsTaskDefinitionContainerDefinitionsLinuxParametersDevicesDetails,

    /// Whether to run an `init` process inside the container that forwards signals
    /// and reaps processes.
    init_process_enabled: ?bool,

    /// The total amount of swap memory (in MiB) that a container can use.
    max_swap: ?i32,

    /// The value for the size (in MiB) of the **/dev/shm** volume.
    shared_memory_size: ?i32,

    /// Configures the container's memory swappiness behavior. Determines how
    /// aggressively pages are swapped. The higher the value, the more aggressive
    /// the swappiness. The default is 60.
    swappiness: ?i32,

    /// The container path, mount options, and size (in MiB) of the tmpfs mount.
    tmpfs: ?[]const AwsEcsTaskDefinitionContainerDefinitionsLinuxParametersTmpfsDetails,

    pub const json_field_names = .{
        .capabilities = "Capabilities",
        .devices = "Devices",
        .init_process_enabled = "InitProcessEnabled",
        .max_swap = "MaxSwap",
        .shared_memory_size = "SharedMemorySize",
        .swappiness = "Swappiness",
        .tmpfs = "Tmpfs",
    };
};

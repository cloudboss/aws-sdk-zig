const ContainerPortMapping = @import("container_port_mapping.zig").ContainerPortMapping;

/// Describes the port mappings for a single container in a container group.
/// Each mapping
/// shows how a container port maps to a connection port on the fleet instance.
///
/// **Returned by:**
/// [DescribeContainerGroupPortMappings](https://docs.aws.amazon.com/gamelift/latest/apireference/API_DescribeContainerGroupPortMappings.html)
pub const ContainerGroupPortMapping = struct {
    /// The name of the container, as defined in the container group definition.
    container_name: ?[]const u8 = null,

    /// A list of `ContainerPortMapping` objects that describe the port mappings
    /// for this container.
    container_port_mappings: ?[]const ContainerPortMapping = null,

    /// The runtime ID for the container that's running in a compute. This value is
    /// unique
    /// within the compute.
    container_runtime_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .container_name = "ContainerName",
        .container_port_mappings = "ContainerPortMappings",
        .container_runtime_id = "ContainerRuntimeId",
    };
};

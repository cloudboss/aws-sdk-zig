/// A unique identifier for a container in a compute on a managed container
/// fleet instance.
/// This information makes it possible to remotely connect to a specific
/// container on a fleet
/// instance.
///
/// **Related to:**
/// [ContainerAttribute](https://docs.aws.amazon.com/gamelift/latest/apireference/API_ContainerAttribute.html)
///
/// **Use with: **
/// [GetComputeAccess](https://docs.aws.amazon.com/gamelift/latest/apireference/API_GetComputeAccess.html)
pub const ContainerIdentifier = struct {
    /// The identifier for a container that's running in a compute.
    container_name: ?[]const u8 = null,

    /// The runtime ID for the container that's running in a compute. This value is
    /// unique within
    /// the compute. It is returned as a `ContainerAttribute` value in a
    /// `Compute` object.
    container_runtime_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .container_name = "ContainerName",
        .container_runtime_id = "ContainerRuntimeId",
    };
};

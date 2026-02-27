/// A unique identifier for a container in a container fleet compute.
///
/// **Returned by:**
/// [DescribeCompute](https://docs.aws.amazon.com/gamelift/latest/apireference/API_DescribeCompute.html)
pub const ContainerAttribute = struct {
    /// The identifier for a container that's running in a compute.
    container_name: ?[]const u8,

    /// The runtime ID for the container that's running in a compute. This value is
    /// unique within
    /// the compute.
    container_runtime_id: ?[]const u8,

    pub const json_field_names = .{
        .container_name = "ContainerName",
        .container_runtime_id = "ContainerRuntimeId",
    };
};

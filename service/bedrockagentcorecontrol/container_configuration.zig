/// Representation of a container configuration.
pub const ContainerConfiguration = struct {
    /// The ECR URI of the container.
    container_uri: []const u8,

    pub const json_field_names = .{
        .container_uri = "containerUri",
    };
};

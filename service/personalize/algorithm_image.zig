/// Describes an algorithm image.
pub const AlgorithmImage = struct {
    /// The URI of the Docker container for the algorithm image.
    docker_uri: []const u8,

    /// The name of the algorithm image.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .docker_uri = "dockerURI",
        .name = "name",
    };
};

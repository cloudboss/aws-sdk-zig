/// Information about a Docker image that is managed by CodeBuild.
pub const EnvironmentImage = struct {
    /// The description of the Docker image.
    description: ?[]const u8,

    /// The name of the Docker image.
    name: ?[]const u8,

    /// A list of environment image versions.
    versions: ?[]const []const u8,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
        .versions = "versions",
    };
};

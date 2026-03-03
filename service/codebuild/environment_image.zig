/// Information about a Docker image that is managed by CodeBuild.
pub const EnvironmentImage = struct {
    /// The description of the Docker image.
    description: ?[]const u8 = null,

    /// The name of the Docker image.
    name: ?[]const u8 = null,

    /// A list of environment image versions.
    versions: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
        .versions = "versions",
    };
};

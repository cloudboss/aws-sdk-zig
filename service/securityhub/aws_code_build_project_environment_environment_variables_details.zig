/// Information about an environment variable that is available to builds for
/// the build project.
pub const AwsCodeBuildProjectEnvironmentEnvironmentVariablesDetails = struct {
    /// The name of the environment variable.
    name: ?[]const u8 = null,

    /// The type of environment variable.
    @"type": ?[]const u8 = null,

    /// The value of the environment variable.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .@"type" = "Type",
        .value = "Value",
    };
};

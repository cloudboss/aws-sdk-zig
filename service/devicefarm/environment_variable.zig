/// Information about an environment variable for a project or a run.
pub const EnvironmentVariable = struct {
    /// The name of the environment variable.
    name: []const u8,

    /// The value of the environment variable.
    value: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};

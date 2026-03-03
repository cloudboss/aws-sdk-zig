/// An environment variable.
pub const EksContainerEnvironmentVariable = struct {
    /// The name of the environment variable.
    name: []const u8,

    /// The value of the environment variable.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};

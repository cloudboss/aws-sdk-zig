/// The parameter details of an evironment profile.
pub const EnvironmentParameter = struct {
    /// The name of an environment profile parameter.
    name: ?[]const u8,

    /// The value of an environment profile parameter.
    value: ?[]const u8,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};

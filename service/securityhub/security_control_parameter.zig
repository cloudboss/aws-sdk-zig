/// A parameter that a security control accepts.
pub const SecurityControlParameter = struct {
    /// The name of a
    name: ?[]const u8 = null,

    /// The current value of a control parameter.
    value: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};

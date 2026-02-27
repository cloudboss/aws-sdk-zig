/// A parameter for the API request or function.
pub const Parameter = struct {
    /// The name of the parameter.
    name: ?[]const u8,

    /// The type of the parameter.
    type: ?[]const u8,

    /// The value of the parameter.
    value: ?[]const u8,

    pub const json_field_names = .{
        .name = "name",
        .type = "type",
        .value = "value",
    };
};

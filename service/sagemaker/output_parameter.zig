/// An output parameter of a pipeline step.
pub const OutputParameter = struct {
    /// The name of the output parameter.
    name: []const u8,

    /// The value of the output parameter.
    value: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};

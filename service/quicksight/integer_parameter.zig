/// An integer parameter.
pub const IntegerParameter = struct {
    /// The name of the integer parameter.
    name: []const u8,

    /// The values for the integer parameter.
    values: []const i64,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};

/// A conflict exception error argument.
pub const ConflictExceptionErrorArgument = struct {
    /// The error argument's name.
    name: []const u8,

    /// The error argument's value.
    value: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};

/// A validation exception error argument.
pub const ValidationExceptionErrorArgument = struct {
    /// The argument's name.
    name: []const u8,

    /// The argument's value.
    value: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};

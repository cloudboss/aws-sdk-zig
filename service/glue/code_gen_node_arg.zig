/// An argument or property of a node.
pub const CodeGenNodeArg = struct {
    /// The name of the argument or property.
    name: []const u8,

    /// True if the value is used as a parameter.
    param: bool = false,

    /// The value of the argument or property.
    value: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .param = "Param",
        .value = "Value",
    };
};

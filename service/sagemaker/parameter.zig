/// Assigns a value to a named Pipeline parameter.
pub const Parameter = struct {
    /// The name of the parameter to assign a value to. This parameter name must
    /// match a named parameter in the pipeline definition.
    name: []const u8,

    /// The literal value for the parameter.
    value: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};

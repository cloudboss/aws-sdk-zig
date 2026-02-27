/// Parameter value of the application.
pub const ParameterValue = struct {
    /// The key associated with the parameter. If you don't specify a key and value
    /// for a particular parameter, AWS CloudFormation
    /// uses the default value that is specified in your template.
    name: []const u8,

    /// The input value associated with the parameter.
    value: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};

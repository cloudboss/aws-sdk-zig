/// An individual DAX parameter.
pub const ParameterNameValue = struct {
    /// The name of the parameter.
    parameter_name: ?[]const u8 = null,

    /// The value of the parameter.
    parameter_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .parameter_name = "ParameterName",
        .parameter_value = "ParameterValue",
    };
};

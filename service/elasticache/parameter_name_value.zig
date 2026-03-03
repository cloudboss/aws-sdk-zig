/// Describes a name-value pair that is used to update the value of a parameter.
pub const ParameterNameValue = struct {
    /// The name of the parameter.
    parameter_name: ?[]const u8 = null,

    /// The value of the parameter.
    parameter_value: ?[]const u8 = null,
};

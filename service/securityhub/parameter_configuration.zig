const ParameterValue = @import("parameter_value.zig").ParameterValue;
const ParameterValueType = @import("parameter_value_type.zig").ParameterValueType;

/// An object that provides the current value of a security control parameter
/// and identifies whether it has been customized.
pub const ParameterConfiguration = struct {
    /// The current value of a control parameter.
    value: ?ParameterValue = null,

    /// Identifies whether a control parameter uses a custom user-defined value or
    /// subscribes to the default
    /// Security Hub CSPM behavior.
    ///
    /// When `ValueType` is set equal to `DEFAULT`, the default
    /// behavior can be a specific Security Hub CSPM default value, or the default
    /// behavior can be to ignore a specific parameter.
    /// When `ValueType` is set equal to `DEFAULT`, Security Hub CSPM ignores
    /// user-provided input for
    /// the `Value` field.
    ///
    /// When `ValueType` is set equal to `CUSTOM`, the `Value` field can't be empty.
    value_type: ParameterValueType,

    pub const json_field_names = .{
        .value = "Value",
        .value_type = "ValueType",
    };
};

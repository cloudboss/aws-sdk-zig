const DecimalDefaultValues = @import("decimal_default_values.zig").DecimalDefaultValues;
const MappedDataSetParameter = @import("mapped_data_set_parameter.zig").MappedDataSetParameter;
const ParameterValueType = @import("parameter_value_type.zig").ParameterValueType;
const DecimalValueWhenUnsetConfiguration = @import("decimal_value_when_unset_configuration.zig").DecimalValueWhenUnsetConfiguration;

/// A parameter declaration for the `Decimal` data type.
pub const DecimalParameterDeclaration = struct {
    /// The default values of a parameter. If the parameter is a single-value
    /// parameter, a maximum of one default value can be provided.
    default_values: ?DecimalDefaultValues = null,

    mapped_data_set_parameters: ?[]const MappedDataSetParameter = null,

    /// The name of the parameter that is being declared.
    name: []const u8,

    /// The value type determines whether the parameter is a single-value or
    /// multi-value parameter.
    parameter_value_type: ParameterValueType,

    /// The configuration that defines the default value of a `Decimal` parameter
    /// when a value has not been set.
    value_when_unset: ?DecimalValueWhenUnsetConfiguration = null,

    pub const json_field_names = .{
        .default_values = "DefaultValues",
        .mapped_data_set_parameters = "MappedDataSetParameters",
        .name = "Name",
        .parameter_value_type = "ParameterValueType",
        .value_when_unset = "ValueWhenUnset",
    };
};

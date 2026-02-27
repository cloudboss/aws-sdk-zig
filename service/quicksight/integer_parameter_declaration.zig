const IntegerDefaultValues = @import("integer_default_values.zig").IntegerDefaultValues;
const MappedDataSetParameter = @import("mapped_data_set_parameter.zig").MappedDataSetParameter;
const ParameterValueType = @import("parameter_value_type.zig").ParameterValueType;
const IntegerValueWhenUnsetConfiguration = @import("integer_value_when_unset_configuration.zig").IntegerValueWhenUnsetConfiguration;

/// A parameter declaration for the `Integer` data type.
pub const IntegerParameterDeclaration = struct {
    /// The default values of a parameter. If the parameter is a single-value
    /// parameter, a maximum of one default value can be provided.
    default_values: ?IntegerDefaultValues,

    mapped_data_set_parameters: ?[]const MappedDataSetParameter,

    /// The name of the parameter that is being declared.
    name: []const u8,

    /// The value type determines whether the parameter is a single-value or
    /// multi-value parameter.
    parameter_value_type: ParameterValueType,

    /// A parameter declaration for the `Integer` data type.
    value_when_unset: ?IntegerValueWhenUnsetConfiguration,

    pub const json_field_names = .{
        .default_values = "DefaultValues",
        .mapped_data_set_parameters = "MappedDataSetParameters",
        .name = "Name",
        .parameter_value_type = "ParameterValueType",
        .value_when_unset = "ValueWhenUnset",
    };
};

const DateTimeDefaultValues = @import("date_time_default_values.zig").DateTimeDefaultValues;
const MappedDataSetParameter = @import("mapped_data_set_parameter.zig").MappedDataSetParameter;
const TimeGranularity = @import("time_granularity.zig").TimeGranularity;
const DateTimeValueWhenUnsetConfiguration = @import("date_time_value_when_unset_configuration.zig").DateTimeValueWhenUnsetConfiguration;

/// A parameter declaration for the `DateTime` data type.
pub const DateTimeParameterDeclaration = struct {
    /// The default values of a parameter. If the parameter is a single-value
    /// parameter, a maximum of one default value can be provided.
    default_values: ?DateTimeDefaultValues = null,

    mapped_data_set_parameters: ?[]const MappedDataSetParameter = null,

    /// The name of the parameter that is being declared.
    name: []const u8,

    /// The level of time precision that is used to aggregate `DateTime` values.
    time_granularity: ?TimeGranularity = null,

    /// The configuration that defines the default value of a `DateTime` parameter
    /// when a value has not been set.
    value_when_unset: ?DateTimeValueWhenUnsetConfiguration = null,

    pub const json_field_names = .{
        .default_values = "DefaultValues",
        .mapped_data_set_parameters = "MappedDataSetParameters",
        .name = "Name",
        .time_granularity = "TimeGranularity",
        .value_when_unset = "ValueWhenUnset",
    };
};

const DateTimeDatasetParameterDefaultValues = @import("date_time_dataset_parameter_default_values.zig").DateTimeDatasetParameterDefaultValues;
const TimeGranularity = @import("time_granularity.zig").TimeGranularity;
const DatasetParameterValueType = @import("dataset_parameter_value_type.zig").DatasetParameterValueType;

/// A date time parameter for a dataset.
pub const DateTimeDatasetParameter = struct {
    /// A list of default values for a given date time parameter. This structure
    /// only accepts static values.
    default_values: ?DateTimeDatasetParameterDefaultValues = null,

    /// An identifier for the parameter that is created in the dataset.
    id: []const u8,

    /// The name of the date time parameter that is created in the dataset.
    name: []const u8,

    /// The time granularity of the date time parameter.
    time_granularity: ?TimeGranularity = null,

    /// The value type of the dataset parameter. Valid values are `single value` or
    /// `multi value`.
    value_type: DatasetParameterValueType,

    pub const json_field_names = .{
        .default_values = "DefaultValues",
        .id = "Id",
        .name = "Name",
        .time_granularity = "TimeGranularity",
        .value_type = "ValueType",
    };
};

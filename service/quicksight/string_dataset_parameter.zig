const StringDatasetParameterDefaultValues = @import("string_dataset_parameter_default_values.zig").StringDatasetParameterDefaultValues;
const DatasetParameterValueType = @import("dataset_parameter_value_type.zig").DatasetParameterValueType;

/// A string parameter for a dataset.
pub const StringDatasetParameter = struct {
    /// A list of default values for a given string dataset parameter type. This
    /// structure only accepts static values.
    default_values: ?StringDatasetParameterDefaultValues,

    /// An identifier for the string parameter that is created in the dataset.
    id: []const u8,

    /// The name of the string parameter that is created in the dataset.
    name: []const u8,

    /// The value type of the dataset parameter. Valid values are `single value` or
    /// `multi value`.
    value_type: DatasetParameterValueType,

    pub const json_field_names = .{
        .default_values = "DefaultValues",
        .id = "Id",
        .name = "Name",
        .value_type = "ValueType",
    };
};

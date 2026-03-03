const DecimalDatasetParameterDefaultValues = @import("decimal_dataset_parameter_default_values.zig").DecimalDatasetParameterDefaultValues;
const DatasetParameterValueType = @import("dataset_parameter_value_type.zig").DatasetParameterValueType;

/// A decimal parameter for a dataset.
pub const DecimalDatasetParameter = struct {
    /// A list of default values for a given decimal parameter. This structure only
    /// accepts static values.
    default_values: ?DecimalDatasetParameterDefaultValues = null,

    /// An identifier for the decimal parameter created in the dataset.
    id: []const u8,

    /// The name of the decimal parameter that is created in the dataset.
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

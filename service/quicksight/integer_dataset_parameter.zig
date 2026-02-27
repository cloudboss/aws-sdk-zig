const IntegerDatasetParameterDefaultValues = @import("integer_dataset_parameter_default_values.zig").IntegerDatasetParameterDefaultValues;
const DatasetParameterValueType = @import("dataset_parameter_value_type.zig").DatasetParameterValueType;

/// An integer parameter for a dataset.
pub const IntegerDatasetParameter = struct {
    /// A list of default values for a given integer parameter. This structure only
    /// accepts static values.
    default_values: ?IntegerDatasetParameterDefaultValues,

    /// An identifier for the integer parameter created in the dataset.
    id: []const u8,

    /// The name of the integer parameter that is created in the dataset.
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

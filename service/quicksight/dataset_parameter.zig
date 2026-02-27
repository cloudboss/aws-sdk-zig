const DateTimeDatasetParameter = @import("date_time_dataset_parameter.zig").DateTimeDatasetParameter;
const DecimalDatasetParameter = @import("decimal_dataset_parameter.zig").DecimalDatasetParameter;
const IntegerDatasetParameter = @import("integer_dataset_parameter.zig").IntegerDatasetParameter;
const StringDatasetParameter = @import("string_dataset_parameter.zig").StringDatasetParameter;

/// A parameter that is created in a dataset. The parameter can be a string,
/// integer, decimal, or datetime data type.
pub const DatasetParameter = struct {
    /// A date time parameter that is created in the dataset.
    date_time_dataset_parameter: ?DateTimeDatasetParameter,

    /// A decimal parameter that is created in the dataset.
    decimal_dataset_parameter: ?DecimalDatasetParameter,

    /// An integer parameter that is created in the dataset.
    integer_dataset_parameter: ?IntegerDatasetParameter,

    /// A string parameter that is created in the dataset.
    string_dataset_parameter: ?StringDatasetParameter,

    pub const json_field_names = .{
        .date_time_dataset_parameter = "DateTimeDatasetParameter",
        .decimal_dataset_parameter = "DecimalDatasetParameter",
        .integer_dataset_parameter = "IntegerDatasetParameter",
        .string_dataset_parameter = "StringDatasetParameter",
    };
};

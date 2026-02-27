const DatetimeOptions = @import("datetime_options.zig").DatetimeOptions;
const FilterExpression = @import("filter_expression.zig").FilterExpression;
const ParameterType = @import("parameter_type.zig").ParameterType;

/// Represents a dataset parameter that defines type and conditions for a
/// parameter in the
/// Amazon S3 path of the dataset.
pub const DatasetParameter = struct {
    /// Optional boolean value that defines whether the captured value of this
    /// parameter
    /// should be used to create a new column in a dataset.
    create_column: bool = false,

    /// Additional parameter options such as a format and a timezone. Required for
    /// datetime parameters.
    datetime_options: ?DatetimeOptions,

    /// The optional filter expression structure to apply additional matching
    /// criteria to the parameter.
    filter: ?FilterExpression,

    /// The name of the parameter that is used in the dataset's Amazon S3 path.
    name: []const u8,

    /// The type of the dataset parameter, can be one of a 'String', 'Number' or
    /// 'Datetime'.
    type: ParameterType,

    pub const json_field_names = .{
        .create_column = "CreateColumn",
        .datetime_options = "DatetimeOptions",
        .filter = "Filter",
        .name = "Name",
        .type = "Type",
    };
};

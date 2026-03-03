const DateTimeParameter = @import("date_time_parameter.zig").DateTimeParameter;
const DecimalParameter = @import("decimal_parameter.zig").DecimalParameter;
const IntegerParameter = @import("integer_parameter.zig").IntegerParameter;
const StringParameter = @import("string_parameter.zig").StringParameter;

/// A list of Quick Sight parameters and the list's override values.
pub const Parameters = struct {
    /// The parameters that have a data type of date-time.
    date_time_parameters: ?[]const DateTimeParameter = null,

    /// The parameters that have a data type of decimal.
    decimal_parameters: ?[]const DecimalParameter = null,

    /// The parameters that have a data type of integer.
    integer_parameters: ?[]const IntegerParameter = null,

    /// The parameters that have a data type of string.
    string_parameters: ?[]const StringParameter = null,

    pub const json_field_names = .{
        .date_time_parameters = "DateTimeParameters",
        .decimal_parameters = "DecimalParameters",
        .integer_parameters = "IntegerParameters",
        .string_parameters = "StringParameters",
    };
};

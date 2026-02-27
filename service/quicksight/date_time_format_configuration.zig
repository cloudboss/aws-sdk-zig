const NullValueFormatConfiguration = @import("null_value_format_configuration.zig").NullValueFormatConfiguration;
const NumericFormatConfiguration = @import("numeric_format_configuration.zig").NumericFormatConfiguration;

/// Formatting configuration for `DateTime` fields.
pub const DateTimeFormatConfiguration = struct {
    /// Determines the `DateTime` format.
    date_time_format: ?[]const u8,

    /// The options that determine the null value format configuration.
    null_value_format_configuration: ?NullValueFormatConfiguration,

    /// The formatting configuration for numeric `DateTime` fields.
    numeric_format_configuration: ?NumericFormatConfiguration,

    pub const json_field_names = .{
        .date_time_format = "DateTimeFormat",
        .null_value_format_configuration = "NullValueFormatConfiguration",
        .numeric_format_configuration = "NumericFormatConfiguration",
    };
};

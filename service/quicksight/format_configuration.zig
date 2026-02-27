const DateTimeFormatConfiguration = @import("date_time_format_configuration.zig").DateTimeFormatConfiguration;
const NumberFormatConfiguration = @import("number_format_configuration.zig").NumberFormatConfiguration;
const StringFormatConfiguration = @import("string_format_configuration.zig").StringFormatConfiguration;

/// The formatting configuration for all types of field.
pub const FormatConfiguration = struct {
    /// Formatting configuration for `DateTime` fields.
    date_time_format_configuration: ?DateTimeFormatConfiguration,

    /// Formatting configuration for number fields.
    number_format_configuration: ?NumberFormatConfiguration,

    /// Formatting configuration for string fields.
    string_format_configuration: ?StringFormatConfiguration,

    pub const json_field_names = .{
        .date_time_format_configuration = "DateTimeFormatConfiguration",
        .number_format_configuration = "NumberFormatConfiguration",
        .string_format_configuration = "StringFormatConfiguration",
    };
};

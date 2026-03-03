const NullValueFormatConfiguration = @import("null_value_format_configuration.zig").NullValueFormatConfiguration;
const NumericFormatConfiguration = @import("numeric_format_configuration.zig").NumericFormatConfiguration;

/// Formatting configuration for string fields.
pub const StringFormatConfiguration = struct {
    /// The options that determine the null value format configuration.
    null_value_format_configuration: ?NullValueFormatConfiguration = null,

    /// The formatting configuration for numeric strings.
    numeric_format_configuration: ?NumericFormatConfiguration = null,

    pub const json_field_names = .{
        .null_value_format_configuration = "NullValueFormatConfiguration",
        .numeric_format_configuration = "NumericFormatConfiguration",
    };
};

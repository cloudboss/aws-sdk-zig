const NumericFormatConfiguration = @import("numeric_format_configuration.zig").NumericFormatConfiguration;

/// Formatting configuration for number fields.
pub const NumberFormatConfiguration = struct {
    /// The options that determine the numeric format configuration.
    format_configuration: ?NumericFormatConfiguration,

    pub const json_field_names = .{
        .format_configuration = "FormatConfiguration",
    };
};

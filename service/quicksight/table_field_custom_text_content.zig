const FontConfiguration = @import("font_configuration.zig").FontConfiguration;

/// The custom text content (value, font configuration) for the table link
/// content configuration.
pub const TableFieldCustomTextContent = struct {
    /// The font configuration of the custom text content for the table URL link
    /// content.
    font_configuration: FontConfiguration,

    /// The string value of the custom text content for the table URL link content.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .font_configuration = "FontConfiguration",
        .value = "Value",
    };
};

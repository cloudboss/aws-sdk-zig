const TableFieldCustomIconContent = @import("table_field_custom_icon_content.zig").TableFieldCustomIconContent;
const TableFieldCustomTextContent = @import("table_field_custom_text_content.zig").TableFieldCustomTextContent;

/// The URL content (text, icon) for the table link configuration.
pub const TableFieldLinkContentConfiguration = struct {
    /// The custom icon content for the table link content configuration.
    custom_icon_content: ?TableFieldCustomIconContent,

    /// The custom text content (value, font configuration) for the table link
    /// content configuration.
    custom_text_content: ?TableFieldCustomTextContent,

    pub const json_field_names = .{
        .custom_icon_content = "CustomIconContent",
        .custom_text_content = "CustomTextContent",
    };
};

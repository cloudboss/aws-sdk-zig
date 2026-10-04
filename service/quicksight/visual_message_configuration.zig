const Visibility = @import("visibility.zig").Visibility;

/// The configuration for a customizable message displayed on a visual. Supports
/// parameter substitution in text fields.
pub const VisualMessageConfiguration = struct {
    /// The description text of the message that is displayed on the visual.
    description: ?[]const u8 = null,

    /// Specifies whether the description of the message is displayed.
    description_visibility: ?Visibility = null,

    /// Specifies whether the custom message is displayed on the visual. When set to
    /// `true`, the custom message appears in place of the default message. When set
    /// to `false` or omitted, the default message is displayed.
    enabled: bool = false,

    /// The display text of the hyperlink that is shown in the message.
    link_text: ?[]const u8 = null,

    /// The destination URL of the hyperlink that is shown in the message. Only
    /// valid `http`, `https`, and `mailto` URLs are supported.
    link_url: ?[]const u8 = null,

    /// Specifies whether the hyperlink in the message is displayed.
    link_visibility: ?Visibility = null,

    /// The title text of the message that is displayed on the visual.
    title: ?[]const u8 = null,

    /// Specifies whether the title of the message is displayed.
    title_visibility: ?Visibility = null,

    pub const json_field_names = .{
        .description = "Description",
        .description_visibility = "DescriptionVisibility",
        .enabled = "Enabled",
        .link_text = "LinkText",
        .link_url = "LinkUrl",
        .link_visibility = "LinkVisibility",
        .title = "Title",
        .title_visibility = "TitleVisibility",
    };
};

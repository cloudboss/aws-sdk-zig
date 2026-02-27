const Button = @import("button.zig").Button;

/// Represents an option rendered to the user when a prompt is shown. It
/// could be an image, a button, a link, or text.
pub const GenericAttachment = struct {
    /// The URL of an attachment to the response card.
    attachment_link_url: ?[]const u8,

    /// The list of options to show to the user.
    buttons: ?[]const Button,

    /// The URL of an image that is displayed to the user.
    image_url: ?[]const u8,

    /// The subtitle shown below the title.
    sub_title: ?[]const u8,

    /// The title of the option.
    title: ?[]const u8,

    pub const json_field_names = .{
        .attachment_link_url = "attachmentLinkUrl",
        .buttons = "buttons",
        .image_url = "imageUrl",
        .sub_title = "subTitle",
        .title = "title",
    };
};

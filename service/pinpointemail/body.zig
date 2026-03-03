const Content = @import("content.zig").Content;

/// Represents the body of the email message.
pub const Body = struct {
    /// An object that represents the version of the message that is displayed in
    /// email
    /// clients that support HTML. HTML messages can include formatted text,
    /// hyperlinks, images,
    /// and more.
    html: ?Content = null,

    /// An object that represents the version of the message that is displayed in
    /// email
    /// clients that don't support HTML, or clients where the recipient has disabled
    /// HTML
    /// rendering.
    text: ?Content = null,

    pub const json_field_names = .{
        .html = "Html",
        .text = "Text",
    };
};

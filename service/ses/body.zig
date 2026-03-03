const Content = @import("content.zig").Content;

/// Represents the body of the message. You can specify text, HTML, or both. If
/// you use
/// both, then the message should display correctly in the widest variety of
/// email
/// clients.
pub const Body = struct {
    /// The content of the message, in HTML format. Use this for email clients that
    /// can
    /// process HTML. You can include clickable links, formatted text, and much more
    /// in an HTML
    /// message.
    html: ?Content = null,

    /// The content of the message, in text format. Use this for text-based email
    /// clients, or
    /// clients on high-latency networks (such as mobile devices).
    text: ?Content = null,
};

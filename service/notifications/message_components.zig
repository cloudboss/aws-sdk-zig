const Dimension = @import("dimension.zig").Dimension;

/// Describes the components of a notification message.
pub const MessageComponents = struct {
    /// A complete summary with all possible relevant information.
    complete_description: ?[]const u8 = null,

    /// A list of properties in key-value pairs. Pairs are shown in order of
    /// importance from most important to least important. Channels may limit the
    /// number of dimensions shown to the notification viewer.
    ///
    /// Included dimensions, keys, and values are subject to change.
    dimensions: ?[]const Dimension = null,

    /// A sentence long summary. For example, titles or an email subject line.
    headline: ?[]const u8 = null,

    /// A rich description in Portable Text format, which you can convert to markup
    /// formats such as HTML, Markdown, or plain text. Channels that don't support
    /// rich rendering ignore this field and use the plain text components instead.
    markup_description: ?[]const u8 = null,

    /// A paragraph long or multiple sentence summary. For example, Amazon Q
    /// Developer in chat applications notifications.
    paragraph_summary: ?[]const u8 = null,

    pub const json_field_names = .{
        .complete_description = "completeDescription",
        .dimensions = "dimensions",
        .headline = "headline",
        .markup_description = "markupDescription",
        .paragraph_summary = "paragraphSummary",
    };
};

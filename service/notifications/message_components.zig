const Dimension = @import("dimension.zig").Dimension;

/// Describes the components of a notification message.
pub const MessageComponents = struct {
    /// A complete summary with all possible relevant information.
    complete_description: ?[]const u8,

    /// A list of properties in key-value pairs. Pairs are shown in order of
    /// importance from most important to least important. Channels may limit the
    /// number of dimensions shown to the notification viewer.
    ///
    /// Included dimensions, keys, and values are subject to change.
    dimensions: ?[]const Dimension,

    /// A sentence long summary. For example, titles or an email subject line.
    headline: ?[]const u8,

    /// A paragraph long or multiple sentence summary. For example, Amazon Q
    /// Developer in chat applications notifications.
    paragraph_summary: ?[]const u8,

    pub const json_field_names = .{
        .complete_description = "completeDescription",
        .dimensions = "dimensions",
        .headline = "headline",
        .paragraph_summary = "paragraphSummary",
    };
};

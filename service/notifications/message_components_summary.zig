/// Contains the headline message component.
pub const MessageComponentsSummary = struct {
    /// A sentence long summary. For example, titles or an email subject line.
    headline: []const u8,

    pub const json_field_names = .{
        .headline = "headline",
    };
};

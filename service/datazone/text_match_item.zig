const MatchOffset = @import("match_offset.zig").MatchOffset;

/// A structure indicating matched terms for an attribute.
pub const TextMatchItem = struct {
    /// The name of the attribute.
    attribute: ?[]const u8,

    /// List of offsets indicating matching terms in the TextMatchItem text.
    match_offsets: ?[]const MatchOffset,

    /// Snippet of attribute text containing highlighted content.
    text: ?[]const u8,

    pub const json_field_names = .{
        .attribute = "attribute",
        .match_offsets = "matchOffsets",
        .text = "text",
    };
};

const TextMatchItem = @import("text_match_item.zig").TextMatchItem;

/// A rationale indicating why this item was matched by search.
pub const MatchRationaleItem = union(enum) {
    /// A list of TextMatchItems.
    text_matches: ?[]const TextMatchItem,

    pub const json_field_names = .{
        .text_matches = "textMatches",
    };
};

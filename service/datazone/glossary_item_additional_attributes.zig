const MatchRationaleItem = @import("match_rationale_item.zig").MatchRationaleItem;

/// The additional attributes of an Amazon DataZone glossary.
pub const GlossaryItemAdditionalAttributes = struct {
    /// List of rationales indicating why this item was matched by search.
    match_rationale: ?[]const MatchRationaleItem,

    pub const json_field_names = .{
        .match_rationale = "matchRationale",
    };
};

const MatchRationaleItem = @import("match_rationale_item.zig").MatchRationaleItem;

/// The additional attributes of an Amazon DataZone data product.
pub const DataProductItemAdditionalAttributes = struct {
    /// List of rationales indicating why this item was matched by search.
    match_rationale: ?[]const MatchRationaleItem = null,

    pub const json_field_names = .{
        .match_rationale = "matchRationale",
    };
};

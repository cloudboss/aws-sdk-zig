const MatchRationaleItem = @import("match_rationale_item.zig").MatchRationaleItem;

/// The additional attributes of the asset of the data product.
pub const DataProductListingItemAdditionalAttributes = struct {
    /// The metadata forms of the asset of the data product.
    forms: ?[]const u8 = null,

    /// List of rationales indicating why this item was matched by search.
    match_rationale: ?[]const MatchRationaleItem = null,

    pub const json_field_names = .{
        .forms = "forms",
        .match_rationale = "matchRationale",
    };
};

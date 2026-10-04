const OfferCreatedBySourceString = @import("offer_created_by_source_string.zig").OfferCreatedBySourceString;

/// Allows filtering on the `CreatedBySource` of an offer.
pub const OfferCreatedBySourceFilter = struct {
    /// Allows filtering on the `CreatedBySource` of an offer with list input.
    value_list: ?[]const OfferCreatedBySourceString = null,

    pub const json_field_names = .{
        .value_list = "ValueList",
    };
};

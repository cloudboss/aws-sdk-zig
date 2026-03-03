/// Allows filtering on the `OfferSetId` of an offer.
pub const OfferSetIdFilter = struct {
    /// Allows filtering on the `OfferSetId` of an offer.
    value_list: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .value_list = "ValueList",
    };
};

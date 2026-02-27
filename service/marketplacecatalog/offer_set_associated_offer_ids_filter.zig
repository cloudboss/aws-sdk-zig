/// Allows filtering on the `AssociatedOfferIds` of an offer set.
pub const OfferSetAssociatedOfferIdsFilter = struct {
    /// Allows filtering on the `AssociatedOfferIds` of an offer set with list
    /// input.
    value_list: ?[]const []const u8,

    pub const json_field_names = .{
        .value_list = "ValueList",
    };
};

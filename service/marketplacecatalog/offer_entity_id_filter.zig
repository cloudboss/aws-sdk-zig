/// Allows filtering on the entity id of an offer.
pub const OfferEntityIdFilter = struct {
    /// Allows filtering on entity id of an offer with list input.
    value_list: ?[]const []const u8,

    pub const json_field_names = .{
        .value_list = "ValueList",
    };
};

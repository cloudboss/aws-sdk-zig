/// Allows filtering on the entity id of an offer set.
pub const OfferSetEntityIdFilter = struct {
    /// Allows filtering on entity id of an offer set with list input.
    value_list: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .value_list = "ValueList",
    };
};

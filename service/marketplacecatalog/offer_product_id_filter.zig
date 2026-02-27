/// Allows filtering on the `ProductId` of an offer.
pub const OfferProductIdFilter = struct {
    /// Allows filtering on the `ProductId` of an offer with list input.
    value_list: ?[]const []const u8,

    pub const json_field_names = .{
        .value_list = "ValueList",
    };
};

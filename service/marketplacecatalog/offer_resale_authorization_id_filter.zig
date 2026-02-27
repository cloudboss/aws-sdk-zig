/// Allows filtering on the `ResaleAuthorizationId` of an offer.
///
/// Not all offers have a `ResaleAuthorizationId`. The response will only
/// include offers for which you have permissions.
pub const OfferResaleAuthorizationIdFilter = struct {
    /// Allows filtering on the `ResaleAuthorizationId` of an offer with list input.
    value_list: ?[]const []const u8,

    pub const json_field_names = .{
        .value_list = "ValueList",
    };
};

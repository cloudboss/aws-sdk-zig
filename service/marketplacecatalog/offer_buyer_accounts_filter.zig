/// Allows filtering on the `BuyerAccounts` of an offer.
pub const OfferBuyerAccountsFilter = struct {
    /// Allows filtering on the `BuyerAccounts` of an offer with wild card input.
    wild_card_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .wild_card_value = "WildCardValue",
    };
};

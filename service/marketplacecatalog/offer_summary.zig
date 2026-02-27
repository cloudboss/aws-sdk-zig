const OfferStateString = @import("offer_state_string.zig").OfferStateString;
const OfferTargetingString = @import("offer_targeting_string.zig").OfferTargetingString;

/// Summarized information about an offer.
pub const OfferSummary = struct {
    /// The availability end date of the offer.
    availability_end_date: ?[]const u8,

    /// The buyer accounts in the offer.
    buyer_accounts: ?[]const []const u8,

    /// The name of the offer.
    name: ?[]const u8,

    /// The offer set ID of the offer.
    offer_set_id: ?[]const u8,

    /// The product ID of the offer.
    product_id: ?[]const u8,

    /// The release date of the offer.
    release_date: ?[]const u8,

    /// The ResaleAuthorizationId of the offer.
    resale_authorization_id: ?[]const u8,

    /// The status of the offer.
    state: ?OfferStateString,

    /// The targeting in the offer.
    targeting: ?[]const OfferTargetingString,

    pub const json_field_names = .{
        .availability_end_date = "AvailabilityEndDate",
        .buyer_accounts = "BuyerAccounts",
        .name = "Name",
        .offer_set_id = "OfferSetId",
        .product_id = "ProductId",
        .release_date = "ReleaseDate",
        .resale_authorization_id = "ResaleAuthorizationId",
        .state = "State",
        .targeting = "Targeting",
    };
};

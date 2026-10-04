const OfferCreatedBySourceString = @import("offer_created_by_source_string.zig").OfferCreatedBySourceString;
const OfferStateString = @import("offer_state_string.zig").OfferStateString;
const OfferTargetAgreementIntentString = @import("offer_target_agreement_intent_string.zig").OfferTargetAgreementIntentString;
const OfferTargetingString = @import("offer_targeting_string.zig").OfferTargetingString;

/// Summarized information about an offer.
pub const OfferSummary = struct {
    /// The availability end date of the offer.
    availability_end_date: ?[]const u8 = null,

    /// The buyer accounts in the offer.
    buyer_accounts: ?[]const []const u8 = null,

    /// The creation source of the offer.
    created_by_source: ?OfferCreatedBySourceString = null,

    /// The name of the offer.
    name: ?[]const u8 = null,

    /// The offer set ID of the offer.
    offer_set_id: ?[]const u8 = null,

    /// The product ID of the offer.
    product_id: ?[]const u8 = null,

    /// The release date of the offer.
    release_date: ?[]const u8 = null,

    /// The ResaleAuthorizationId of the offer.
    resale_authorization_id: ?[]const u8 = null,

    /// The status of the offer.
    state: ?OfferStateString = null,

    /// The target agreement ID of the offer.
    target_agreement_id: ?[]const u8 = null,

    /// The target agreement intent of the offer.
    target_agreement_intent: ?OfferTargetAgreementIntentString = null,

    /// The targeting in the offer.
    targeting: ?[]const OfferTargetingString = null,

    pub const json_field_names = .{
        .availability_end_date = "AvailabilityEndDate",
        .buyer_accounts = "BuyerAccounts",
        .created_by_source = "CreatedBySource",
        .name = "Name",
        .offer_set_id = "OfferSetId",
        .product_id = "ProductId",
        .release_date = "ReleaseDate",
        .resale_authorization_id = "ResaleAuthorizationId",
        .state = "State",
        .target_agreement_id = "TargetAgreementId",
        .target_agreement_intent = "TargetAgreementIntent",
        .targeting = "Targeting",
    };
};

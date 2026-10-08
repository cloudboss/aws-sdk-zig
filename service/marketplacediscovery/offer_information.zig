const SellerInformation = @import("seller_information.zig").SellerInformation;

/// Summary information about an offer, including the offer identifier, name,
/// and seller of record.
pub const OfferInformation = struct {
    /// The unique identifier of the offer.
    offer_id: []const u8,

    /// The display name of the offer.
    offer_name: ?[]const u8 = null,

    /// The entity responsible for selling the product under this offer.
    seller_of_record: SellerInformation,

    pub const json_field_names = .{
        .offer_id = "offerId",
        .offer_name = "offerName",
        .seller_of_record = "sellerOfRecord",
    };
};

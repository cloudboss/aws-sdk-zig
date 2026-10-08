const SellerInformation = @import("seller_information.zig").SellerInformation;

/// Summary information about an offer set, including the identifier and seller
/// of record.
pub const OfferSetInformation = struct {
    /// The unique identifier of the offer set.
    offer_set_id: []const u8,

    /// The entity responsible for selling the products under this offer set.
    seller_of_record: SellerInformation,

    pub const json_field_names = .{
        .offer_set_id = "offerSetId",
        .seller_of_record = "sellerOfRecord",
    };
};

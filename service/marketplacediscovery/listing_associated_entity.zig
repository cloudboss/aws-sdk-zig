const OfferInformation = @import("offer_information.zig").OfferInformation;
const ProductInformation = @import("product_information.zig").ProductInformation;

/// A product and offer associated with a listing.
pub const ListingAssociatedEntity = struct {
    /// Information about the default offer associated with the listing.
    offer: ?OfferInformation = null,

    /// Information about the product associated with the listing.
    product: ?ProductInformation = null,

    pub const json_field_names = .{
        .offer = "offer",
        .product = "product",
    };
};

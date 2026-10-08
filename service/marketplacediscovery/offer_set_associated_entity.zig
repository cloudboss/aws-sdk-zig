const OfferInformation = @import("offer_information.zig").OfferInformation;
const ProductInformation = @import("product_information.zig").ProductInformation;

/// A product and offer associated with an offer set.
pub const OfferSetAssociatedEntity = struct {
    /// Information about the offer associated with the offer set.
    offer: OfferInformation,

    /// Information about the product associated with the offer set.
    product: ProductInformation,

    pub const json_field_names = .{
        .offer = "offer",
        .product = "product",
    };
};

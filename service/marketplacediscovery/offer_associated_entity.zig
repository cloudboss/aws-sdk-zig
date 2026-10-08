const OfferSetInformation = @import("offer_set_information.zig").OfferSetInformation;
const ProductInformation = @import("product_information.zig").ProductInformation;

/// A product and optional offer set associated with an offer.
pub const OfferAssociatedEntity = struct {
    /// Information about the offer set, if the offer is part of a bundled offer
    /// set.
    offer_set: ?OfferSetInformation = null,

    /// Information about the product associated with the offer.
    product: ProductInformation,

    pub const json_field_names = .{
        .offer_set = "offerSet",
        .product = "product",
    };
};

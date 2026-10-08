const OfferInformation = @import("offer_information.zig").OfferInformation;
const OfferSetInformation = @import("offer_set_information.zig").OfferSetInformation;
const ProductInformation = @import("product_information.zig").ProductInformation;

/// A product, offer, and optional offer set associated with a purchase option.
pub const PurchaseOptionAssociatedEntity = struct {
    /// Information about the offer associated with the purchase option.
    offer: OfferInformation,

    /// Information about the offer set, if the purchase option is part of a bundled
    /// offer set.
    offer_set: ?OfferSetInformation = null,

    /// Information about the product associated with the purchase option.
    product: ProductInformation,

    pub const json_field_names = .{
        .offer = "offer",
        .offer_set = "offerSet",
        .product = "product",
    };
};

const SubscribedAssetListing = @import("subscribed_asset_listing.zig").SubscribedAssetListing;
const SubscribedProductListing = @import("subscribed_product_listing.zig").SubscribedProductListing;

/// The published asset for which the subscription grant is created.
pub const SubscribedListingItem = union(enum) {
    /// The asset for which the subscription grant is created.
    asset_listing: ?SubscribedAssetListing,
    /// The data product listing.
    product_listing: ?SubscribedProductListing,

    pub const json_field_names = .{
        .asset_listing = "assetListing",
        .product_listing = "productListing",
    };
};

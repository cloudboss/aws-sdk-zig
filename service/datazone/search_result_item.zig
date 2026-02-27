const AssetListingItem = @import("asset_listing_item.zig").AssetListingItem;
const DataProductListingItem = @import("data_product_listing_item.zig").DataProductListingItem;

/// The details of the results of the `SearchListings` action.
pub const SearchResultItem = union(enum) {
    /// The asset listing included in the results of the `SearchListings` action.
    asset_listing: ?AssetListingItem,
    /// The data product listing.
    data_product_listing: ?DataProductListingItem,

    pub const json_field_names = .{
        .asset_listing = "assetListing",
        .data_product_listing = "dataProductListing",
    };
};

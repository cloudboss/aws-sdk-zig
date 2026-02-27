const AssetListing = @import("asset_listing.zig").AssetListing;
const DataProductListing = @import("data_product_listing.zig").DataProductListing;

/// The details of a listing (aka asset published in a Amazon DataZone catalog).
pub const ListingItem = union(enum) {
    /// An asset published in an Amazon DataZone catalog.
    asset_listing: ?AssetListing,
    /// The data product listing.
    data_product_listing: ?DataProductListing,

    pub const json_field_names = .{
        .asset_listing = "assetListing",
        .data_product_listing = "dataProductListing",
    };
};

const AssetInDataProductListingItem = @import("asset_in_data_product_listing_item.zig").AssetInDataProductListingItem;
const DetailedGlossaryTerm = @import("detailed_glossary_term.zig").DetailedGlossaryTerm;

/// The data product listing.
pub const SubscribedProductListing = struct {
    /// The data assets of the data product listing.
    asset_listings: ?[]const AssetInDataProductListingItem = null,

    /// The description of the data product listing.
    description: ?[]const u8 = null,

    /// The ID of the data product listing.
    entity_id: ?[]const u8 = null,

    /// The revision of the data product listing.
    entity_revision: ?[]const u8 = null,

    /// The glossary terms of the data product listing.
    glossary_terms: ?[]const DetailedGlossaryTerm = null,

    /// The name of the data product listing.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .asset_listings = "assetListings",
        .description = "description",
        .entity_id = "entityId",
        .entity_revision = "entityRevision",
        .glossary_terms = "glossaryTerms",
        .name = "name",
    };
};

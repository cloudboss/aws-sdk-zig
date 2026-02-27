/// The identifiers of the provider service, from Data Exchange.
pub const ProviderMarketplaceConfiguration = struct {
    /// The asset ID on Data Exchange.
    asset_id: []const u8,

    /// The dataset ID on Data Exchange.
    data_set_id: []const u8,

    /// The listing ID on Data Exchange.
    listing_id: []const u8,

    /// The revision ID on Data Exchange.
    revision_id: []const u8,

    pub const json_field_names = .{
        .asset_id = "assetId",
        .data_set_id = "dataSetId",
        .listing_id = "listingId",
        .revision_id = "revisionId",
    };
};

pub const DeleteAssetRequest = struct {
    /// The unique identifier for an asset.
    asset_id: []const u8,

    /// The unique identifier for a data set.
    data_set_id: []const u8,

    /// The unique identifier for a revision.
    revision_id: []const u8,

    pub const json_field_names = .{
        .asset_id = "AssetId",
        .data_set_id = "DataSetId",
        .revision_id = "RevisionId",
    };
};

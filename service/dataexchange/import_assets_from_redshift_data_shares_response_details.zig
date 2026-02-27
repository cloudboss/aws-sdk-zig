const RedshiftDataShareAssetSourceEntry = @import("redshift_data_share_asset_source_entry.zig").RedshiftDataShareAssetSourceEntry;

/// Details from an import from Amazon Redshift datashare response.
pub const ImportAssetsFromRedshiftDataSharesResponseDetails = struct {
    /// A list of Amazon Redshift datashare asset sources.
    asset_sources: []const RedshiftDataShareAssetSourceEntry,

    /// The unique identifier for the data set associated with this import job.
    data_set_id: []const u8,

    /// The unique identifier for the revision associated with this import job.
    revision_id: []const u8,

    pub const json_field_names = .{
        .asset_sources = "AssetSources",
        .data_set_id = "DataSetId",
        .revision_id = "RevisionId",
    };
};

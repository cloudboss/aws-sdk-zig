const AssetSourceEntry = @import("asset_source_entry.zig").AssetSourceEntry;

/// Details of the operation to be performed by the job.
pub const ImportAssetsFromS3RequestDetails = struct {
    /// Is a list of Amazon S3 bucket and object key pairs.
    asset_sources: []const AssetSourceEntry,

    /// The unique identifier for the data set associated with this import job.
    data_set_id: []const u8,

    /// The unique identifier for the revision associated with this import request.
    revision_id: []const u8,

    pub const json_field_names = .{
        .asset_sources = "AssetSources",
        .data_set_id = "DataSetId",
        .revision_id = "RevisionId",
    };
};

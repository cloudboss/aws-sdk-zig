const S3DataAccessAssetSourceEntry = @import("s3_data_access_asset_source_entry.zig").S3DataAccessAssetSourceEntry;

/// Details about the response of the operation to create an S3 data access from
/// an S3
/// bucket.
pub const CreateS3DataAccessFromS3BucketResponseDetails = struct {
    /// Details about the asset source from an Amazon S3 bucket.
    asset_source: S3DataAccessAssetSourceEntry,

    /// The unique identifier for this data set.
    data_set_id: []const u8,

    /// The unique identifier for the revision.
    revision_id: []const u8,

    pub const json_field_names = .{
        .asset_source = "AssetSource",
        .data_set_id = "DataSetId",
        .revision_id = "RevisionId",
    };
};

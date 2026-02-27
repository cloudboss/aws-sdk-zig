const S3DataAccessAssetSourceEntry = @import("s3_data_access_asset_source_entry.zig").S3DataAccessAssetSourceEntry;

/// Details of the operation to create an Amazon S3 data access from an S3
/// bucket.
pub const CreateS3DataAccessFromS3BucketRequestDetails = struct {
    /// Details about the S3 data access source asset.
    asset_source: S3DataAccessAssetSourceEntry,

    /// The unique identifier for the data set associated with the creation of this
    /// Amazon S3
    /// data access.
    data_set_id: []const u8,

    /// The unique identifier for a revision.
    revision_id: []const u8,

    pub const json_field_names = .{
        .asset_source = "AssetSource",
        .data_set_id = "DataSetId",
        .revision_id = "RevisionId",
    };
};

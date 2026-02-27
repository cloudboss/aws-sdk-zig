/// Details of the operation to be performed by the job.
pub const ImportAssetFromSignedUrlRequestDetails = struct {
    /// The name of the asset. When importing from Amazon S3, the Amazon S3 object
    /// key is used
    /// as the asset name.
    asset_name: []const u8,

    /// The unique identifier for the data set associated with this import job.
    data_set_id: []const u8,

    /// The Base64-encoded Md5 hash for the asset, used to ensure the integrity of
    /// the file at
    /// that location.
    md_5_hash: []const u8,

    /// The unique identifier for the revision associated with this import request.
    revision_id: []const u8,

    pub const json_field_names = .{
        .asset_name = "AssetName",
        .data_set_id = "DataSetId",
        .md_5_hash = "Md5Hash",
        .revision_id = "RevisionId",
    };
};

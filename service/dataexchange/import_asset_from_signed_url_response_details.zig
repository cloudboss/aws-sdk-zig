/// The details in the response for an import request, including the signed URL
/// and other
/// information.
pub const ImportAssetFromSignedUrlResponseDetails = struct {
    /// The name for the asset associated with this import job.
    asset_name: []const u8,

    /// The unique identifier for the data set associated with this import job.
    data_set_id: []const u8,

    /// The Base64-encoded Md5 hash for the asset, used to ensure the integrity of
    /// the file at
    /// that location.
    md_5_hash: ?[]const u8,

    /// The unique identifier for the revision associated with this import response.
    revision_id: []const u8,

    /// The signed URL.
    signed_url: ?[]const u8,

    /// The time and date at which the signed URL expires, in ISO 8601 format.
    signed_url_expires_at: ?i64,

    pub const json_field_names = .{
        .asset_name = "AssetName",
        .data_set_id = "DataSetId",
        .md_5_hash = "Md5Hash",
        .revision_id = "RevisionId",
        .signed_url = "SignedUrl",
        .signed_url_expires_at = "SignedUrlExpiresAt",
    };
};

/// The details of the export to signed URL response.
pub const ExportAssetToSignedUrlResponseDetails = struct {
    /// The unique identifier for the asset associated with this export job.
    asset_id: []const u8,

    /// The unique identifier for the data set associated with this export job.
    data_set_id: []const u8,

    /// The unique identifier for the revision associated with this export response.
    revision_id: []const u8,

    /// The signed URL for the export request.
    signed_url: ?[]const u8 = null,

    /// The date and time that the signed URL expires, in ISO 8601 format.
    signed_url_expires_at: ?i64 = null,

    pub const json_field_names = .{
        .asset_id = "AssetId",
        .data_set_id = "DataSetId",
        .revision_id = "RevisionId",
        .signed_url = "SignedUrl",
        .signed_url_expires_at = "SignedUrlExpiresAt",
    };
};

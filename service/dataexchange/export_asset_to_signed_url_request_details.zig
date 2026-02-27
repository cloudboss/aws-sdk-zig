/// Details of the operation to be performed by the job.
pub const ExportAssetToSignedUrlRequestDetails = struct {
    /// The unique identifier for the asset that is exported to a signed URL.
    asset_id: []const u8,

    /// The unique identifier for the data set associated with this export job.
    data_set_id: []const u8,

    /// The unique identifier for the revision associated with this export request.
    revision_id: []const u8,

    pub const json_field_names = .{
        .asset_id = "AssetId",
        .data_set_id = "DataSetId",
        .revision_id = "RevisionId",
    };
};

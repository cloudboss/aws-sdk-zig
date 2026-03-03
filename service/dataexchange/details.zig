const ImportAssetFromSignedUrlJobErrorDetails = @import("import_asset_from_signed_url_job_error_details.zig").ImportAssetFromSignedUrlJobErrorDetails;
const AssetSourceEntry = @import("asset_source_entry.zig").AssetSourceEntry;

/// Information about the job error.
pub const Details = struct {
    /// Information about the job error.
    import_asset_from_signed_url_job_error_details: ?ImportAssetFromSignedUrlJobErrorDetails = null,

    /// Details about the job error.
    import_assets_from_s3_job_error_details: ?[]const AssetSourceEntry = null,

    pub const json_field_names = .{
        .import_asset_from_signed_url_job_error_details = "ImportAssetFromSignedUrlJobErrorDetails",
        .import_assets_from_s3_job_error_details = "ImportAssetsFromS3JobErrorDetails",
    };
};

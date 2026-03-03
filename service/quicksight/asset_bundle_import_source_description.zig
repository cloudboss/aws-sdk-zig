/// A description of the import source that you provide at the start of an
/// import job. This
/// value is set to either `Body` or `S3Uri`, depending on how the
/// `StartAssetBundleImportJobRequest` is configured.
pub const AssetBundleImportSourceDescription = struct {
    /// An HTTPS download URL for the provided asset bundle that you optionally
    /// provided at the
    /// start of the import job. This URL is valid for five minutes after issuance.
    /// Call
    /// `DescribeAssetBundleExportJob` again for a fresh URL if needed. The
    /// downloaded asset bundle is a `.qs` zip file.
    body: ?[]const u8 = null,

    /// The Amazon S3 URI that you provided at the start of the import job.
    s3_uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .body = "Body",
        .s3_uri = "S3Uri",
    };
};

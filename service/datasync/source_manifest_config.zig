const S3ManifestConfig = @import("s3_manifest_config.zig").S3ManifestConfig;

/// Specifies the manifest that you want DataSync to use and where it's hosted.
/// For more information and configuration examples, see [Specifying what
/// DataSync transfers by using a
/// manifest](https://docs.aws.amazon.com/datasync/latest/userguide/transferring-with-manifest.html).
pub const SourceManifestConfig = struct {
    /// Specifies the S3 bucket where you're hosting your manifest.
    s3: S3ManifestConfig,

    pub const json_field_names = .{
        .s3 = "S3",
    };
};

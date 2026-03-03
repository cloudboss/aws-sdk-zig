const ManifestAction = @import("manifest_action.zig").ManifestAction;
const ManifestFormat = @import("manifest_format.zig").ManifestFormat;
const SourceManifestConfig = @import("source_manifest_config.zig").SourceManifestConfig;

/// Configures a manifest, which is a list of files or objects that you want
/// DataSync to transfer. For more information and configuration examples, see
/// [Specifying what DataSync transfers by using a
/// manifest](https://docs.aws.amazon.com/datasync/latest/userguide/transferring-with-manifest.html).
pub const ManifestConfig = struct {
    /// Specifies what DataSync uses the manifest for.
    action: ?ManifestAction = null,

    /// Specifies the file format of your manifest. For more information, see
    /// [Creating a
    /// manifest](https://docs.aws.amazon.com/datasync/latest/userguide/transferring-with-manifest.html#transferring-with-manifest-create).
    format: ?ManifestFormat = null,

    /// Specifies the manifest that you want DataSync to use and where it's
    /// hosted.
    ///
    /// You must specify this parameter if you're configuring a new manifest on or
    /// after
    /// February 7, 2024.
    ///
    /// If you don't, you'll get a 400 status code and `ValidationException` error
    /// stating that you're missing the IAM role for DataSync to access the
    /// S3 bucket where you're hosting your manifest. For more information, see
    /// [Providing DataSync access to your
    /// manifest](https://docs.aws.amazon.com/datasync/latest/userguide/transferring-with-manifest.html#transferring-with-manifest-access).
    source: ?SourceManifestConfig = null,

    pub const json_field_names = .{
        .action = "Action",
        .format = "Format",
        .source = "Source",
    };
};

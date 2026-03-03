const BundleType = @import("bundle_type.zig").BundleType;

/// Information about the location of application artifacts stored in Amazon S3.
pub const S3Location = struct {
    /// The name of the Amazon S3 bucket where the application revision is
    /// stored.
    bucket: ?[]const u8 = null,

    /// The file type of the application revision. Must be one of the following:
    ///
    /// * `tar`: A tar archive file.
    ///
    /// * `tgz`: A compressed tar archive file.
    ///
    /// * `zip`: A zip archive file.
    ///
    /// * `YAML`: A YAML-formatted file.
    ///
    /// * `JSON`: A JSON-formatted file.
    bundle_type: ?BundleType = null,

    /// The ETag of the Amazon S3 object that represents the bundled artifacts for
    /// the
    /// application revision.
    ///
    /// If the ETag is not specified as an input parameter, ETag validation of the
    /// object is
    /// skipped.
    e_tag: ?[]const u8 = null,

    /// The name of the Amazon S3 object that represents the bundled artifacts for
    /// the
    /// application revision.
    key: ?[]const u8 = null,

    /// A specific version of the Amazon S3 object that represents the bundled
    /// artifacts for the application revision.
    ///
    /// If the version is not specified, the system uses the most recent version by
    /// default.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .bucket = "bucket",
        .bundle_type = "bundleType",
        .e_tag = "eTag",
        .key = "key",
        .version = "version",
    };
};

const ReportPackagingType = @import("report_packaging_type.zig").ReportPackagingType;

/// Information about the S3 bucket where the raw data of a report are exported.
pub const S3ReportExportConfig = struct {
    /// The name of the S3 bucket where the raw data of a report are exported.
    bucket: ?[]const u8,

    /// The Amazon Web Services account identifier of the owner of the Amazon S3
    /// bucket. This allows report data to be exported to an Amazon S3 bucket
    /// that is owned by an account other than the account running the build.
    bucket_owner: ?[]const u8,

    /// A boolean value that specifies if the results of a report are encrypted.
    encryption_disabled: ?bool,

    /// The encryption key for the report's encrypted raw data.
    encryption_key: ?[]const u8,

    /// The type of build output artifact to create. Valid values include:
    ///
    /// * `NONE`: CodeBuild creates the raw data in the output bucket. This
    /// is the default if packaging is not specified.
    ///
    /// * `ZIP`: CodeBuild creates a ZIP file with the raw data in the
    /// output bucket.
    packaging: ?ReportPackagingType,

    /// The path to the exported report's raw data results.
    path: ?[]const u8,

    pub const json_field_names = .{
        .bucket = "bucket",
        .bucket_owner = "bucketOwner",
        .encryption_disabled = "encryptionDisabled",
        .encryption_key = "encryptionKey",
        .packaging = "packaging",
        .path = "path",
    };
};

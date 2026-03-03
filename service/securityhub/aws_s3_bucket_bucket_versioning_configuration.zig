/// Describes the versioning state of an S3 bucket.
pub const AwsS3BucketBucketVersioningConfiguration = struct {
    /// Specifies whether MFA delete is currently enabled in the S3 bucket
    /// versioning configuration. If the S3 bucket was never configured with MFA
    /// delete, then this attribute is not included.
    is_mfa_delete_enabled: ?bool = null,

    /// The versioning status of the S3 bucket. Valid values are `Enabled` or
    /// `Suspended`.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .is_mfa_delete_enabled = "IsMfaDeleteEnabled",
        .status = "Status",
    };
};

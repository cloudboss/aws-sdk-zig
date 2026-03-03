/// Describes the persistent application settings for users of a stack.
pub const ApplicationSettingsResponse = struct {
    /// Specifies whether persistent application settings are enabled for users
    /// during their streaming sessions.
    enabled: ?bool = null,

    /// The S3 bucket where users’ persistent application settings are stored. When
    /// persistent application settings are enabled for the first time for an
    /// account in an AWS Region, an S3 bucket is created. The bucket is unique to
    /// the AWS account and the Region.
    s3_bucket_name: ?[]const u8 = null,

    /// The path prefix for the S3 bucket where users’ persistent application
    /// settings are stored.
    settings_group: ?[]const u8 = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .s3_bucket_name = "S3BucketName",
        .settings_group = "SettingsGroup",
    };
};

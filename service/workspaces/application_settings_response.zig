const ApplicationSettingsStatusEnum = @import("application_settings_status_enum.zig").ApplicationSettingsStatusEnum;

/// Describes the persistent application settings for WorkSpaces Pools users.
pub const ApplicationSettingsResponse = struct {
    /// The S3 bucket where users’ persistent application settings are stored. When
    /// persistent
    /// application settings are enabled for the first time for an account in an
    /// Amazon Web Services Region,
    /// an S3 bucket is created. The bucket is unique to the Amazon Web Services
    /// account and the Region.
    s3_bucket_name: ?[]const u8 = null,

    /// The path prefix for the S3 bucket where users’ persistent application
    /// settings are stored.
    settings_group: ?[]const u8 = null,

    /// Specifies whether persistent application settings are enabled for users
    /// during their pool sessions.
    status: ApplicationSettingsStatusEnum,

    pub const json_field_names = .{
        .s3_bucket_name = "S3BucketName",
        .settings_group = "SettingsGroup",
        .status = "Status",
    };
};

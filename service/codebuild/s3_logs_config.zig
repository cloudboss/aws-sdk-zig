const BucketOwnerAccess = @import("bucket_owner_access.zig").BucketOwnerAccess;
const LogsConfigStatusType = @import("logs_config_status_type.zig").LogsConfigStatusType;

/// Information about S3 logs for a build project.
pub const S3LogsConfig = struct {
    bucket_owner_access: ?BucketOwnerAccess = null,

    /// Set to true if you do not want your S3 build log output encrypted. By
    /// default S3
    /// build logs are encrypted.
    encryption_disabled: ?bool = null,

    /// The ARN of an S3 bucket and the path prefix for S3 logs. If your Amazon S3
    /// bucket
    /// name is `my-bucket`, and your path prefix is `build-log`, then
    /// acceptable formats are `my-bucket/build-log` or
    /// `arn:aws:s3:::my-bucket/build-log`.
    location: ?[]const u8 = null,

    /// The current status of the S3 build logs. Valid values are:
    ///
    /// * `ENABLED`: S3 build logs are enabled for this build project.
    ///
    /// * `DISABLED`: S3 build logs are not enabled for this build
    /// project.
    status: LogsConfigStatusType,

    pub const json_field_names = .{
        .bucket_owner_access = "bucketOwnerAccess",
        .encryption_disabled = "encryptionDisabled",
        .location = "location",
        .status = "status",
    };
};

const CloudWatchEncryption = @import("cloud_watch_encryption.zig").CloudWatchEncryption;
const DataQualityEncryption = @import("data_quality_encryption.zig").DataQualityEncryption;
const JobBookmarksEncryption = @import("job_bookmarks_encryption.zig").JobBookmarksEncryption;
const S3Encryption = @import("s3_encryption.zig").S3Encryption;

/// Specifies an encryption configuration.
pub const EncryptionConfiguration = struct {
    /// The encryption configuration for Amazon CloudWatch.
    cloud_watch_encryption: ?CloudWatchEncryption = null,

    /// The encryption configuration for Glue Data Quality assets.
    data_quality_encryption: ?DataQualityEncryption = null,

    /// The encryption configuration for job bookmarks.
    job_bookmarks_encryption: ?JobBookmarksEncryption = null,

    /// The encryption configuration for Amazon Simple Storage Service (Amazon S3)
    /// data.
    s3_encryption: ?[]const S3Encryption = null,

    pub const json_field_names = .{
        .cloud_watch_encryption = "CloudWatchEncryption",
        .data_quality_encryption = "DataQualityEncryption",
        .job_bookmarks_encryption = "JobBookmarksEncryption",
        .s3_encryption = "S3Encryption",
    };
};

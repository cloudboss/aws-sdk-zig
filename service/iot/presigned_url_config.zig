/// Configuration for pre-signed S3 URLs.
pub const PresignedUrlConfig = struct {
    /// How long (in seconds) pre-signed URLs are valid. Valid values are 60 - 3600,
    /// the
    /// default value is 3600 seconds. Pre-signed URLs are generated when Jobs
    /// receives an MQTT
    /// request for the job document.
    expires_in_sec: ?i64 = null,

    /// The ARN of an IAM role that grants permission to download files from the S3
    /// bucket
    /// where the job data/updates are stored. The role must also grant permission
    /// for IoT to
    /// download the files.
    ///
    /// For information about addressing the confused deputy problem, see
    /// [cross-service confused deputy
    /// prevention](https://docs.aws.amazon.com/iot/latest/developerguide/cross-service-confused-deputy-prevention.html) in the *Amazon Web Services IoT Core
    /// developer guide*.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .expires_in_sec = "expiresInSec",
        .role_arn = "roleArn",
    };
};

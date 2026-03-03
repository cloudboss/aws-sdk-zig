const Destination = @import("destination.zig").Destination;
const LogType = @import("log_type.zig").LogType;

/// The settings for conversation logs.
pub const LogSettingsResponse = struct {
    /// The destination where logs are delivered.
    destination: ?Destination = null,

    /// The Amazon Resource Name (ARN) of the key used to encrypt audio logs
    /// in an S3 bucket.
    kms_key_arn: ?[]const u8 = null,

    /// The type of logging that is enabled.
    log_type: ?LogType = null,

    /// The Amazon Resource Name (ARN) of the CloudWatch Logs log group or S3
    /// bucket where the logs are delivered.
    resource_arn: ?[]const u8 = null,

    /// The resource prefix is the first part of the S3 object key within the
    /// S3 bucket that you specified to contain audio logs. For CloudWatch Logs it
    /// is the prefix of the log stream name within the log group that you
    /// specified.
    resource_prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .destination = "destination",
        .kms_key_arn = "kmsKeyArn",
        .log_type = "logType",
        .resource_arn = "resourceArn",
        .resource_prefix = "resourcePrefix",
    };
};

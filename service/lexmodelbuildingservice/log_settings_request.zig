const Destination = @import("destination.zig").Destination;
const LogType = @import("log_type.zig").LogType;

/// Settings used to configure delivery mode and destination for
/// conversation logs.
pub const LogSettingsRequest = struct {
    /// Where the logs will be delivered. Text logs are delivered to a
    /// CloudWatch Logs log group. Audio logs are delivered to an S3
    /// bucket.
    destination: Destination,

    /// The Amazon Resource Name (ARN) of the AWS KMS customer managed key for
    /// encrypting audio logs delivered to an S3 bucket. The key does not apply to
    /// CloudWatch Logs and is optional for S3 buckets.
    kms_key_arn: ?[]const u8 = null,

    /// The type of logging to enable. Text logs are delivered to a CloudWatch
    /// Logs log group. Audio logs are delivered to an S3 bucket.
    log_type: LogType,

    /// The Amazon Resource Name (ARN) of the CloudWatch Logs log group or S3
    /// bucket where the logs should be delivered.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .destination = "destination",
        .kms_key_arn = "kmsKeyArn",
        .log_type = "logType",
        .resource_arn = "resourceArn",
    };
};

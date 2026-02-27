const LogDestination = @import("log_destination.zig").LogDestination;

/// A method for collecting container logs for the fleet. Amazon GameLift
/// Servers saves all standard
/// output for each container in logs, including game session logs. You can
/// select from the
/// following methods:
pub const LogConfiguration = struct {
    /// The type of log collection to use for a fleet.
    ///
    /// * `CLOUDWATCH` -- (default value) Send logs to an Amazon CloudWatch log
    ///   group that you define. Each container emits a log stream, which is
    ///   organized in the log group.
    ///
    /// * `S3` -- Store logs in an Amazon S3 bucket that you define. This bucket
    ///   must reside in the fleet's home Amazon Web Services Region.
    ///
    /// * `NONE` -- Don't collect container logs.
    log_destination: ?LogDestination,

    /// If log destination is `CLOUDWATCH`, logs are sent to the specified log group
    /// in Amazon CloudWatch.
    log_group_arn: ?[]const u8,

    /// If log destination is `S3`, logs are sent to the specified Amazon S3 bucket
    /// name.
    s3_bucket_name: ?[]const u8,

    pub const json_field_names = .{
        .log_destination = "LogDestination",
        .log_group_arn = "LogGroupArn",
        .s3_bucket_name = "S3BucketName",
    };
};

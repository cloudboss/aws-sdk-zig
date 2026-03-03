const HttpEndpointBufferingHints = @import("http_endpoint_buffering_hints.zig").HttpEndpointBufferingHints;
const CloudWatchLoggingOptions = @import("cloud_watch_logging_options.zig").CloudWatchLoggingOptions;
const HttpEndpointConfiguration = @import("http_endpoint_configuration.zig").HttpEndpointConfiguration;
const ProcessingConfiguration = @import("processing_configuration.zig").ProcessingConfiguration;
const HttpEndpointRequestConfiguration = @import("http_endpoint_request_configuration.zig").HttpEndpointRequestConfiguration;
const HttpEndpointRetryOptions = @import("http_endpoint_retry_options.zig").HttpEndpointRetryOptions;
const HttpEndpointS3BackupMode = @import("http_endpoint_s3_backup_mode.zig").HttpEndpointS3BackupMode;
const S3DestinationUpdate = @import("s3_destination_update.zig").S3DestinationUpdate;
const SecretsManagerConfiguration = @import("secrets_manager_configuration.zig").SecretsManagerConfiguration;

/// Updates the specified HTTP endpoint destination.
pub const HttpEndpointDestinationUpdate = struct {
    /// Describes buffering options that can be applied to the data before it is
    /// delivered to
    /// the HTTPS endpoint destination. Firehose teats these options as hints, and
    /// it
    /// might choose to use more optimal values. The `SizeInMBs` and
    /// `IntervalInSeconds` parameters are optional. However, if specify a value for
    /// one of them, you must also provide a value for the other.
    buffering_hints: ?HttpEndpointBufferingHints = null,

    cloud_watch_logging_options: ?CloudWatchLoggingOptions = null,

    /// Describes the configuration of the HTTP endpoint destination.
    endpoint_configuration: ?HttpEndpointConfiguration = null,

    processing_configuration: ?ProcessingConfiguration = null,

    /// The configuration of the request sent to the HTTP endpoint specified as the
    /// destination.
    request_configuration: ?HttpEndpointRequestConfiguration = null,

    /// Describes the retry behavior in case Firehose is unable to deliver data to
    /// the specified HTTP endpoint destination, or if it doesn't receive a valid
    /// acknowledgment of
    /// receipt from the specified HTTP endpoint destination.
    retry_options: ?HttpEndpointRetryOptions = null,

    /// Firehose uses this IAM role for all the permissions that the delivery
    /// stream needs.
    role_arn: ?[]const u8 = null,

    /// Describes the S3 bucket backup options for the data that Kinesis Firehose
    /// delivers to
    /// the HTTP endpoint destination. You can back up all documents (`AllData`) or
    /// only
    /// the documents that Firehose could not deliver to the specified HTTP endpoint
    /// destination (`FailedDataOnly`).
    s3_backup_mode: ?HttpEndpointS3BackupMode = null,

    s3_update: ?S3DestinationUpdate = null,

    /// The configuration that defines how you access secrets for HTTP Endpoint
    /// destination.
    secrets_manager_configuration: ?SecretsManagerConfiguration = null,

    pub const json_field_names = .{
        .buffering_hints = "BufferingHints",
        .cloud_watch_logging_options = "CloudWatchLoggingOptions",
        .endpoint_configuration = "EndpointConfiguration",
        .processing_configuration = "ProcessingConfiguration",
        .request_configuration = "RequestConfiguration",
        .retry_options = "RetryOptions",
        .role_arn = "RoleARN",
        .s3_backup_mode = "S3BackupMode",
        .s3_update = "S3Update",
        .secrets_manager_configuration = "SecretsManagerConfiguration",
    };
};

const HttpEndpointBufferingHints = @import("http_endpoint_buffering_hints.zig").HttpEndpointBufferingHints;
const CloudWatchLoggingOptions = @import("cloud_watch_logging_options.zig").CloudWatchLoggingOptions;
const HttpEndpointConfiguration = @import("http_endpoint_configuration.zig").HttpEndpointConfiguration;
const ProcessingConfiguration = @import("processing_configuration.zig").ProcessingConfiguration;
const HttpEndpointRequestConfiguration = @import("http_endpoint_request_configuration.zig").HttpEndpointRequestConfiguration;
const HttpEndpointRetryOptions = @import("http_endpoint_retry_options.zig").HttpEndpointRetryOptions;
const HttpEndpointS3BackupMode = @import("http_endpoint_s3_backup_mode.zig").HttpEndpointS3BackupMode;
const S3DestinationConfiguration = @import("s3_destination_configuration.zig").S3DestinationConfiguration;
const SecretsManagerConfiguration = @import("secrets_manager_configuration.zig").SecretsManagerConfiguration;

/// Describes the configuration of the HTTP endpoint destination.
pub const HttpEndpointDestinationConfiguration = struct {
    /// The buffering options that can be used before data is delivered to the
    /// specified
    /// destination. Firehose treats these options as hints, and it might choose to
    /// use more optimal values. The `SizeInMBs` and `IntervalInSeconds`
    /// parameters are optional. However, if you specify a value for one of them,
    /// you must also
    /// provide a value for the other.
    buffering_hints: ?HttpEndpointBufferingHints = null,

    cloud_watch_logging_options: ?CloudWatchLoggingOptions = null,

    /// The configuration of the HTTP endpoint selected as the destination.
    endpoint_configuration: HttpEndpointConfiguration,

    processing_configuration: ?ProcessingConfiguration = null,

    /// The configuration of the request sent to the HTTP endpoint that is specified
    /// as the
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

    /// Describes the S3 bucket backup options for the data that Firehose delivers
    /// to the HTTP endpoint destination. You can back up all documents (`AllData`)
    /// or
    /// only the documents that Firehose could not deliver to the specified HTTP
    /// endpoint destination (`FailedDataOnly`).
    s3_backup_mode: ?HttpEndpointS3BackupMode = null,

    s3_configuration: S3DestinationConfiguration,

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
        .s3_configuration = "S3Configuration",
        .secrets_manager_configuration = "SecretsManagerConfiguration",
    };
};

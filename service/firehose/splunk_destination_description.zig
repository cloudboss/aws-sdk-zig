const SplunkBufferingHints = @import("splunk_buffering_hints.zig").SplunkBufferingHints;
const CloudWatchLoggingOptions = @import("cloud_watch_logging_options.zig").CloudWatchLoggingOptions;
const HECEndpointType = @import("hec_endpoint_type.zig").HECEndpointType;
const ProcessingConfiguration = @import("processing_configuration.zig").ProcessingConfiguration;
const SplunkRetryOptions = @import("splunk_retry_options.zig").SplunkRetryOptions;
const SplunkS3BackupMode = @import("splunk_s3_backup_mode.zig").SplunkS3BackupMode;
const S3DestinationDescription = @import("s3_destination_description.zig").S3DestinationDescription;
const SecretsManagerConfiguration = @import("secrets_manager_configuration.zig").SecretsManagerConfiguration;

/// Describes a destination in Splunk.
pub const SplunkDestinationDescription = struct {
    /// The buffering options. If no value is specified, the default values for
    /// Splunk are used.
    buffering_hints: ?SplunkBufferingHints,

    /// The Amazon CloudWatch logging options for your Firehose stream.
    cloud_watch_logging_options: ?CloudWatchLoggingOptions,

    /// The amount of time that Firehose waits to receive an acknowledgment from
    /// Splunk after it sends it data. At the end of the timeout period, Firehose
    /// either tries to send the data again or considers it an error, based on your
    /// retry
    /// settings.
    hec_acknowledgment_timeout_in_seconds: ?i32,

    /// The HTTP Event Collector (HEC) endpoint to which Firehose sends your
    /// data.
    hec_endpoint: ?[]const u8,

    /// This type can be either "Raw" or "Event."
    hec_endpoint_type: ?HECEndpointType,

    /// A GUID you obtain from your Splunk cluster when you create a new HEC
    /// endpoint.
    hec_token: ?[]const u8,

    /// The data processing configuration.
    processing_configuration: ?ProcessingConfiguration,

    /// The retry behavior in case Firehose is unable to deliver data to Splunk
    /// or if it doesn't receive an acknowledgment of receipt from Splunk.
    retry_options: ?SplunkRetryOptions,

    /// Defines how documents should be delivered to Amazon S3. When set to
    /// `FailedDocumentsOnly`, Firehose writes any data that could not
    /// be indexed to the configured Amazon S3 destination. When set to
    /// `AllDocuments`,
    /// Firehose delivers all incoming records to Amazon S3, and also writes failed
    /// documents to Amazon S3. Default value is `FailedDocumentsOnly`.
    s3_backup_mode: ?SplunkS3BackupMode,

    /// The Amazon S3 destination.>
    s3_destination_description: ?S3DestinationDescription,

    /// The configuration that defines how you access secrets for Splunk.
    secrets_manager_configuration: ?SecretsManagerConfiguration,

    pub const json_field_names = .{
        .buffering_hints = "BufferingHints",
        .cloud_watch_logging_options = "CloudWatchLoggingOptions",
        .hec_acknowledgment_timeout_in_seconds = "HECAcknowledgmentTimeoutInSeconds",
        .hec_endpoint = "HECEndpoint",
        .hec_endpoint_type = "HECEndpointType",
        .hec_token = "HECToken",
        .processing_configuration = "ProcessingConfiguration",
        .retry_options = "RetryOptions",
        .s3_backup_mode = "S3BackupMode",
        .s3_destination_description = "S3DestinationDescription",
        .secrets_manager_configuration = "SecretsManagerConfiguration",
    };
};

const AmazonManagedKafkaEventSourceConfig = @import("amazon_managed_kafka_event_source_config.zig").AmazonManagedKafkaEventSourceConfig;
const DestinationConfig = @import("destination_config.zig").DestinationConfig;
const DocumentDBEventSourceConfig = @import("document_db_event_source_config.zig").DocumentDBEventSourceConfig;
const FilterCriteria = @import("filter_criteria.zig").FilterCriteria;
const FilterCriteriaError = @import("filter_criteria_error.zig").FilterCriteriaError;
const FunctionResponseType = @import("function_response_type.zig").FunctionResponseType;
const EventSourceMappingLoggingConfig = @import("event_source_mapping_logging_config.zig").EventSourceMappingLoggingConfig;
const EventSourceMappingMetricsConfig = @import("event_source_mapping_metrics_config.zig").EventSourceMappingMetricsConfig;
const ProvisionedPollerConfig = @import("provisioned_poller_config.zig").ProvisionedPollerConfig;
const ScalingConfig = @import("scaling_config.zig").ScalingConfig;
const SelfManagedEventSource = @import("self_managed_event_source.zig").SelfManagedEventSource;
const SelfManagedKafkaEventSourceConfig = @import("self_managed_kafka_event_source_config.zig").SelfManagedKafkaEventSourceConfig;
const SourceAccessConfiguration = @import("source_access_configuration.zig").SourceAccessConfiguration;
const EventSourcePosition = @import("event_source_position.zig").EventSourcePosition;

/// A mapping between an Amazon Web Services resource and a Lambda function. For
/// details, see CreateEventSourceMapping.
pub const EventSourceMappingConfiguration = struct {
    /// Specific configuration settings for an Amazon Managed Streaming for Apache
    /// Kafka (Amazon MSK) event source.
    amazon_managed_kafka_event_source_config: ?AmazonManagedKafkaEventSourceConfig = null,

    /// The maximum number of records in each batch that Lambda pulls from your
    /// stream or queue and sends to your function. Lambda passes all of the records
    /// in the batch to the function in a single call, up to the payload limit for
    /// synchronous invocation (6 MB).
    ///
    /// Default value: Varies by service. For Amazon SQS, the default is 10. For all
    /// other services, the default is 100.
    ///
    /// Related setting: When you set `BatchSize` to a value greater than 10, you
    /// must set `MaximumBatchingWindowInSeconds` to at least 1.
    batch_size: ?i32 = null,

    /// (Kinesis, DynamoDB Streams, Amazon MSK, and self-managed Apache Kafka) If
    /// the function returns an error, split the batch in two and retry. The default
    /// value is false.
    bisect_batch_on_function_error: ?bool = null,

    /// (Kinesis, DynamoDB Streams, Amazon MSK, and self-managed Apache Kafka) A
    /// configuration object that specifies the destination of an event after Lambda
    /// processes it.
    destination_config: ?DestinationConfig = null,

    /// Specific configuration settings for a DocumentDB event source.
    document_db_event_source_config: ?DocumentDBEventSourceConfig = null,

    /// The Amazon Resource Name (ARN) of the event source.
    event_source_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the event source mapping.
    event_source_mapping_arn: ?[]const u8 = null,

    /// An object that defines the filter criteria that determine whether Lambda
    /// should process an event. For more information, see [Lambda event
    /// filtering](https://docs.aws.amazon.com/lambda/latest/dg/invocation-eventfiltering.html).
    ///
    /// If filter criteria is encrypted, this field shows up as `null` in the
    /// response of ListEventSourceMapping API calls. You can view this field in
    /// plaintext in the response of GetEventSourceMapping and
    /// DeleteEventSourceMapping calls if you have `kms:Decrypt` permissions for the
    /// correct KMS key.
    filter_criteria: ?FilterCriteria = null,

    /// An object that contains details about an error related to filter criteria
    /// encryption.
    filter_criteria_error: ?FilterCriteriaError = null,

    /// The ARN of the Lambda function.
    function_arn: ?[]const u8 = null,

    /// (Kinesis, DynamoDB Streams, Amazon MSK, self-managed Apache Kafka, and
    /// Amazon SQS) A list of current response type enums applied to the event
    /// source mapping.
    function_response_types: ?[]const FunctionResponseType = null,

    /// The ARN of the Key Management Service (KMS) customer managed key that Lambda
    /// uses to encrypt your function's [filter
    /// criteria](https://docs.aws.amazon.com/lambda/latest/dg/invocation-eventfiltering.html#filtering-basics).
    kms_key_arn: ?[]const u8 = null,

    /// The date that the event source mapping was last updated or that its state
    /// changed.
    last_modified: ?i64 = null,

    /// The result of the event source mapping's last processing attempt.
    last_processing_result: ?[]const u8 = null,

    /// (Amazon MSK, and self-managed Apache Kafka only) The logging configuration
    /// for your event source. For more information, see [Event source mapping
    /// logging](https://docs.aws.amazon.com/lambda/latest/dg/esm-logging.html).
    logging_config: ?EventSourceMappingLoggingConfig = null,

    /// The maximum amount of time, in seconds, that Lambda spends gathering records
    /// before invoking the function. You can configure
    /// `MaximumBatchingWindowInSeconds` to any value from 0 seconds to 300 seconds
    /// in increments of seconds.
    ///
    /// For streams and Amazon SQS event sources, the default batching window is 0
    /// seconds. For Amazon MSK, Self-managed Apache Kafka, Amazon MQ, and
    /// DocumentDB event sources, the default batching window is 500 ms. Note that
    /// because you can only change `MaximumBatchingWindowInSeconds` in increments
    /// of seconds, you cannot revert back to the 500 ms default batching window
    /// after you have changed it. To restore the default batching window, you must
    /// create a new event source mapping.
    ///
    /// Related setting: For streams and Amazon SQS event sources, when you set
    /// `BatchSize` to a value greater than 10, you must set
    /// `MaximumBatchingWindowInSeconds` to at least 1.
    maximum_batching_window_in_seconds: ?i32 = null,

    /// (Kinesis, DynamoDB Streams, Amazon MSK, and self-managed Apache Kafka)
    /// Discard records older than the specified age. The default value is -1, which
    /// sets the maximum age to infinite. When the value is set to infinite, Lambda
    /// never discards old records.
    ///
    /// The minimum valid value for maximum record age is 60s. Although values less
    /// than 60 and greater than -1 fall within the parameter's absolute range, they
    /// are not allowed
    maximum_record_age_in_seconds: ?i32 = null,

    /// (Kinesis, DynamoDB Streams, Amazon MSK, and self-managed Apache Kafka)
    /// Discard records after the specified number of retries. The default value is
    /// -1, which sets the maximum number of retries to infinite. When
    /// MaximumRetryAttempts is infinite, Lambda retries failed records until the
    /// record expires in the event source.
    maximum_retry_attempts: ?i32 = null,

    /// The metrics configuration for your event source. For more information, see
    /// [Event source mapping
    /// metrics](https://docs.aws.amazon.com/lambda/latest/dg/monitoring-metrics-types.html#event-source-mapping-metrics).
    metrics_config: ?EventSourceMappingMetricsConfig = null,

    /// (Kinesis and DynamoDB Streams only) The number of batches to process
    /// concurrently from each shard. The default value is 1.
    parallelization_factor: ?i32 = null,

    /// (Amazon SQS, Amazon MSK, and self-managed Apache Kafka only) The provisioned
    /// mode configuration for the event source. For more information, see
    /// [provisioned
    /// mode](https://docs.aws.amazon.com/lambda/latest/dg/invocation-eventsourcemapping.html#invocation-eventsourcemapping-provisioned-mode).
    provisioned_poller_config: ?ProvisionedPollerConfig = null,

    /// (Amazon MQ) The name of the Amazon MQ broker destination queue to consume.
    queues: ?[]const []const u8 = null,

    /// (Amazon SQS only) The scaling configuration for the event source. For more
    /// information, see [Configuring maximum concurrency for Amazon SQS event
    /// sources](https://docs.aws.amazon.com/lambda/latest/dg/with-sqs.html#events-sqs-max-concurrency).
    scaling_config: ?ScalingConfig = null,

    /// The self-managed Apache Kafka cluster for your event source.
    self_managed_event_source: ?SelfManagedEventSource = null,

    /// Specific configuration settings for a self-managed Apache Kafka event
    /// source.
    self_managed_kafka_event_source_config: ?SelfManagedKafkaEventSourceConfig = null,

    /// An array of the authentication protocol, VPC components, or virtual host to
    /// secure and define your event source.
    source_access_configurations: ?[]const SourceAccessConfiguration = null,

    /// The position in a stream from which to start reading. Required for Amazon
    /// Kinesis and Amazon DynamoDB Stream event sources. `AT_TIMESTAMP` is
    /// supported only for Amazon Kinesis streams, Amazon DocumentDB, Amazon MSK,
    /// and self-managed Apache Kafka.
    starting_position: ?EventSourcePosition = null,

    /// With `StartingPosition` set to `AT_TIMESTAMP`, the time from which to start
    /// reading. `StartingPositionTimestamp` cannot be in the future.
    starting_position_timestamp: ?i64 = null,

    /// The state of the event source mapping. It can be one of the following:
    /// `Creating`, `Enabling`, `Enabled`, `Disabling`, `Disabled`, `Updating`, or
    /// `Deleting`.
    state: ?[]const u8 = null,

    /// Indicates whether a user or Lambda made the last change to the event source
    /// mapping.
    state_transition_reason: ?[]const u8 = null,

    /// The name of the Kafka topic.
    topics: ?[]const []const u8 = null,

    /// (Kinesis and DynamoDB Streams only) The duration in seconds of a processing
    /// window for DynamoDB and Kinesis Streams event sources. A value of 0 seconds
    /// indicates no tumbling window.
    tumbling_window_in_seconds: ?i32 = null,

    /// The identifier of the event source mapping.
    uuid: ?[]const u8 = null,

    pub const json_field_names = .{
        .amazon_managed_kafka_event_source_config = "AmazonManagedKafkaEventSourceConfig",
        .batch_size = "BatchSize",
        .bisect_batch_on_function_error = "BisectBatchOnFunctionError",
        .destination_config = "DestinationConfig",
        .document_db_event_source_config = "DocumentDBEventSourceConfig",
        .event_source_arn = "EventSourceArn",
        .event_source_mapping_arn = "EventSourceMappingArn",
        .filter_criteria = "FilterCriteria",
        .filter_criteria_error = "FilterCriteriaError",
        .function_arn = "FunctionArn",
        .function_response_types = "FunctionResponseTypes",
        .kms_key_arn = "KMSKeyArn",
        .last_modified = "LastModified",
        .last_processing_result = "LastProcessingResult",
        .logging_config = "LoggingConfig",
        .maximum_batching_window_in_seconds = "MaximumBatchingWindowInSeconds",
        .maximum_record_age_in_seconds = "MaximumRecordAgeInSeconds",
        .maximum_retry_attempts = "MaximumRetryAttempts",
        .metrics_config = "MetricsConfig",
        .parallelization_factor = "ParallelizationFactor",
        .provisioned_poller_config = "ProvisionedPollerConfig",
        .queues = "Queues",
        .scaling_config = "ScalingConfig",
        .self_managed_event_source = "SelfManagedEventSource",
        .self_managed_kafka_event_source_config = "SelfManagedKafkaEventSourceConfig",
        .source_access_configurations = "SourceAccessConfigurations",
        .starting_position = "StartingPosition",
        .starting_position_timestamp = "StartingPositionTimestamp",
        .state = "State",
        .state_transition_reason = "StateTransitionReason",
        .topics = "Topics",
        .tumbling_window_in_seconds = "TumblingWindowInSeconds",
        .uuid = "UUID",
    };
};

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AmazonManagedKafkaEventSourceConfig = @import("amazon_managed_kafka_event_source_config.zig").AmazonManagedKafkaEventSourceConfig;
const DestinationConfig = @import("destination_config.zig").DestinationConfig;
const DocumentDBEventSourceConfig = @import("document_db_event_source_config.zig").DocumentDBEventSourceConfig;
const FilterCriteria = @import("filter_criteria.zig").FilterCriteria;
const FunctionResponseType = @import("function_response_type.zig").FunctionResponseType;
const EventSourceMappingLoggingConfig = @import("event_source_mapping_logging_config.zig").EventSourceMappingLoggingConfig;
const EventSourceMappingMetricsConfig = @import("event_source_mapping_metrics_config.zig").EventSourceMappingMetricsConfig;
const ProvisionedPollerConfig = @import("provisioned_poller_config.zig").ProvisionedPollerConfig;
const ScalingConfig = @import("scaling_config.zig").ScalingConfig;
const SelfManagedEventSource = @import("self_managed_event_source.zig").SelfManagedEventSource;
const SelfManagedKafkaEventSourceConfig = @import("self_managed_kafka_event_source_config.zig").SelfManagedKafkaEventSourceConfig;
const SourceAccessConfiguration = @import("source_access_configuration.zig").SourceAccessConfiguration;
const EventSourcePosition = @import("event_source_position.zig").EventSourcePosition;
const FilterCriteriaError = @import("filter_criteria_error.zig").FilterCriteriaError;

/// Creates a mapping between an event source and an Lambda function. Lambda
/// reads items from the event source and invokes the function.
///
/// For details about how to configure different event sources, see the
/// following topics.
///
/// * [ Amazon DynamoDB
///   Streams](https://docs.aws.amazon.com/lambda/latest/dg/with-ddb.html#services-dynamodb-eventsourcemapping)
/// * [ Amazon
///   Kinesis](https://docs.aws.amazon.com/lambda/latest/dg/with-kinesis.html#services-kinesis-eventsourcemapping)
/// * [ Amazon
///   SQS](https://docs.aws.amazon.com/lambda/latest/dg/with-sqs.html#events-sqs-eventsource)
/// * [ Amazon MQ and
///   RabbitMQ](https://docs.aws.amazon.com/lambda/latest/dg/with-mq.html#services-mq-eventsourcemapping)
/// * [ Amazon MSK](https://docs.aws.amazon.com/lambda/latest/dg/with-msk.html)
/// * [ Apache
///   Kafka](https://docs.aws.amazon.com/lambda/latest/dg/kafka-smaa.html)
/// * [ Amazon
///   DocumentDB](https://docs.aws.amazon.com/lambda/latest/dg/with-documentdb.html)
///
/// The following error handling options are available for stream sources
/// (DynamoDB, Kinesis, Amazon MSK, and self-managed Apache Kafka):
///
/// * `BisectBatchOnFunctionError` – If the function returns an error, split the
///   batch in two and retry.
/// * `MaximumRecordAgeInSeconds` – Discard records older than the specified
///   age. The default value is infinite (-1). When set to infinite (-1), failed
///   records are retried until the record expires
/// * `MaximumRetryAttempts` – Discard records after the specified number of
///   retries. The default value is infinite (-1). When set to infinite (-1),
///   failed records are retried until the record expires.
/// * `OnFailure` – Send discarded records to an Amazon SQS queue, Amazon SNS
///   topic, Kafka topic, or Amazon S3 bucket. For more information, see [Adding
///   a
///   destination](https://docs.aws.amazon.com/lambda/latest/dg/invocation-async-retain-records.html#invocation-async-destinations).
///
/// The following option is available only for DynamoDB and Kinesis event
/// sources:
///
/// * `ParallelizationFactor` – Process multiple batches from each shard
///   concurrently.
///
/// For information about which configuration parameters apply to each event
/// source, see the following topics.
///
/// * [ Amazon DynamoDB
///   Streams](https://docs.aws.amazon.com/lambda/latest/dg/with-ddb.html#services-ddb-params)
/// * [ Amazon
///   Kinesis](https://docs.aws.amazon.com/lambda/latest/dg/with-kinesis.html#services-kinesis-params)
/// * [ Amazon
///   SQS](https://docs.aws.amazon.com/lambda/latest/dg/with-sqs.html#services-sqs-params)
/// * [ Amazon MQ and
///   RabbitMQ](https://docs.aws.amazon.com/lambda/latest/dg/with-mq.html#services-mq-params)
/// * [ Amazon
///   MSK](https://docs.aws.amazon.com/lambda/latest/dg/with-msk.html#services-msk-parms)
/// * [ Apache
///   Kafka](https://docs.aws.amazon.com/lambda/latest/dg/with-kafka.html#services-kafka-parms)
/// * [ Amazon
///   DocumentDB](https://docs.aws.amazon.com/lambda/latest/dg/with-documentdb.html#docdb-configuration)
pub const CreateEventSourceMappingInput = struct {
    /// Specific configuration settings for an Amazon Managed Streaming for Apache
    /// Kafka (Amazon MSK) event source.
    amazon_managed_kafka_event_source_config: ?AmazonManagedKafkaEventSourceConfig = null,

    /// The maximum number of records in each batch that Lambda pulls from your
    /// stream or queue and sends to your function. Lambda passes all of the records
    /// in the batch to the function in a single call, up to the payload limit for
    /// synchronous invocation (6 MB).
    ///
    /// * **Amazon Kinesis** – Default 100. Max 10,000.
    /// * **Amazon DynamoDB Streams** – Default 100. Max 10,000.
    /// * **Amazon Simple Queue Service** – Default 10. For standard queues the max
    ///   is 10,000. For FIFO queues the max is 10.
    /// * **Amazon Managed Streaming for Apache Kafka** – Default 100. Max 10,000.
    /// * **Self-managed Apache Kafka** – Default 100. Max 10,000.
    /// * **Amazon MQ (ActiveMQ and RabbitMQ)** – Default 100. Max 10,000.
    /// * **DocumentDB** – Default 100. Max 10,000.
    batch_size: ?i32 = null,

    /// (Kinesis, DynamoDB Streams, Amazon MSK, and self-managed Apache Kafka) If
    /// the function returns an error, split the batch in two and retry.
    bisect_batch_on_function_error: ?bool = null,

    /// (Kinesis, DynamoDB Streams, Amazon MSK, and self-managed Apache Kafka) A
    /// configuration object that specifies the destination of an event after Lambda
    /// processes it.
    destination_config: ?DestinationConfig = null,

    /// Specific configuration settings for a DocumentDB event source.
    document_db_event_source_config: ?DocumentDBEventSourceConfig = null,

    /// When true, the event source mapping is active. When false, Lambda pauses
    /// polling and invocation.
    ///
    /// Default: True
    enabled: ?bool = null,

    /// The Amazon Resource Name (ARN) of the event source.
    ///
    /// * **Amazon Kinesis** – The ARN of the data stream or a stream consumer.
    /// * **Amazon DynamoDB Streams** – The ARN of the stream.
    /// * **Amazon Simple Queue Service** – The ARN of the queue.
    /// * **Amazon Managed Streaming for Apache Kafka** – The ARN of the cluster or
    ///   the ARN of the VPC connection (for [cross-account event source
    ///   mappings](https://docs.aws.amazon.com/lambda/latest/dg/with-msk.html#msk-multi-vpc)).
    /// * **Amazon MQ** – The ARN of the broker.
    /// * **Amazon DocumentDB** – The ARN of the DocumentDB change stream.
    event_source_arn: ?[]const u8 = null,

    /// An object that defines the filter criteria that determine whether Lambda
    /// should process an event. For more information, see [Lambda event
    /// filtering](https://docs.aws.amazon.com/lambda/latest/dg/invocation-eventfiltering.html).
    filter_criteria: ?FilterCriteria = null,

    /// The name or ARN of the Lambda function. **Name formats**
    ///
    /// * **Function name** – `MyFunction`.
    /// * **Function ARN** –
    ///   `arn:aws:lambda:us-west-2:123456789012:function:MyFunction`.
    /// * **Version or Alias ARN** –
    ///   `arn:aws:lambda:us-west-2:123456789012:function:MyFunction:PROD`.
    /// * **Partial ARN** – `123456789012:function:MyFunction`.
    ///
    /// The length constraint applies only to the full ARN. If you specify only the
    /// function name, it's limited to 64 characters in length.
    function_name: []const u8,

    /// (Kinesis, DynamoDB Streams, Amazon MSK, self-managed Apache Kafka, and
    /// Amazon SQS) A list of current response type enums applied to the event
    /// source mapping.
    function_response_types: ?[]const FunctionResponseType = null,

    /// The ARN of the Key Management Service (KMS) customer managed key that Lambda
    /// uses to encrypt your function's [filter
    /// criteria](https://docs.aws.amazon.com/lambda/latest/dg/invocation-eventfiltering.html#filtering-basics). By default, Lambda does not encrypt your filter criteria object. Specify this property to encrypt data using your own customer managed key.
    kms_key_arn: ?[]const u8 = null,

    /// (Amazon MSK, and self-managed Apache Kafka only) The logging configuration
    /// for your event source. For more information, see [Event source mapping
    /// logging](https://docs.aws.amazon.com/lambda/latest/dg/esm-logging.html).
    logging_config: ?EventSourceMappingLoggingConfig = null,

    /// The maximum amount of time, in seconds, that Lambda spends gathering records
    /// before invoking the function. You can configure
    /// `MaximumBatchingWindowInSeconds` to any value from 0 seconds to 300 seconds
    /// in increments of seconds.
    ///
    /// For Kinesis, DynamoDB, and Amazon SQS event sources, the default batching
    /// window is 0 seconds. For Amazon MSK, Self-managed Apache Kafka, Amazon MQ,
    /// and DocumentDB event sources, the default batching window is 500 ms. Note
    /// that because you can only change `MaximumBatchingWindowInSeconds` in
    /// increments of seconds, you cannot revert back to the 500 ms default batching
    /// window after you have changed it. To restore the default batching window,
    /// you must create a new event source mapping.
    ///
    /// Related setting: For Kinesis, DynamoDB, and Amazon SQS event sources, when
    /// you set `BatchSize` to a value greater than 10, you must set
    /// `MaximumBatchingWindowInSeconds` to at least 1.
    maximum_batching_window_in_seconds: ?i32 = null,

    /// (Kinesis, DynamoDB Streams, Amazon MSK, and self-managed Apache Kafka)
    /// Discard records older than the specified age. The default value is infinite
    /// (-1).
    maximum_record_age_in_seconds: ?i32 = null,

    /// (Kinesis, DynamoDB Streams, Amazon MSK, and self-managed Apache Kafka)
    /// Discard records after the specified number of retries. The default value is
    /// infinite (-1). When set to infinite (-1), failed records are retried until
    /// the record expires.
    maximum_retry_attempts: ?i32 = null,

    /// The metrics configuration for your event source. For more information, see
    /// [Event source mapping
    /// metrics](https://docs.aws.amazon.com/lambda/latest/dg/monitoring-metrics-types.html#event-source-mapping-metrics).
    metrics_config: ?EventSourceMappingMetricsConfig = null,

    /// (Kinesis and DynamoDB Streams only) The number of batches to process from
    /// each shard concurrently.
    parallelization_factor: ?i32 = null,

    /// (Amazon SQS, Amazon MSK, and self-managed Apache Kafka only) The provisioned
    /// mode configuration for the event source. For more information, see
    /// [provisioned
    /// mode](https://docs.aws.amazon.com/lambda/latest/dg/invocation-eventsourcemapping.html#invocation-eventsourcemapping-provisioned-mode).
    provisioned_poller_config: ?ProvisionedPollerConfig = null,

    /// (MQ) The name of the Amazon MQ broker destination queue to consume.
    queues: ?[]const []const u8 = null,

    /// (Amazon SQS only) The scaling configuration for the event source. For more
    /// information, see [Configuring maximum concurrency for Amazon SQS event
    /// sources](https://docs.aws.amazon.com/lambda/latest/dg/with-sqs.html#events-sqs-max-concurrency).
    scaling_config: ?ScalingConfig = null,

    /// The self-managed Apache Kafka cluster to receive records from.
    self_managed_event_source: ?SelfManagedEventSource = null,

    /// Specific configuration settings for a self-managed Apache Kafka event
    /// source.
    self_managed_kafka_event_source_config: ?SelfManagedKafkaEventSourceConfig = null,

    /// An array of authentication protocols or VPC components required to secure
    /// your event source.
    source_access_configurations: ?[]const SourceAccessConfiguration = null,

    /// The position in a stream from which to start reading. Required for Amazon
    /// Kinesis and Amazon DynamoDB Stream event sources. `AT_TIMESTAMP` is
    /// supported only for Amazon Kinesis streams, Amazon DocumentDB, Amazon MSK,
    /// and self-managed Apache Kafka.
    starting_position: ?EventSourcePosition = null,

    /// With `StartingPosition` set to `AT_TIMESTAMP`, the time from which to start
    /// reading. `StartingPositionTimestamp` cannot be in the future.
    starting_position_timestamp: ?i64 = null,

    /// A list of tags to apply to the event source mapping.
    tags: ?[]const u8 = null,

    /// The name of the Kafka topic.
    topics: ?[]const []const u8 = null,

    /// (Kinesis and DynamoDB Streams only) The duration in seconds of a processing
    /// window for DynamoDB and Kinesis Streams event sources. A value of 0 seconds
    /// indicates no tumbling window.
    tumbling_window_in_seconds: ?i32 = null,
};

pub const CreateEventSourceMappingOutput = struct {
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
    /// **Note:**
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

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const CreateEventSourceMappingOutput) void {
        if (self.event_source_arn) |v| {
            self.allocator.free(v);
        }
        if (self.event_source_mapping_arn) |v| {
            self.allocator.free(v);
        }
        if (self.function_arn) |v| {
            self.allocator.free(v);
        }
        if (self.kms_key_arn) |v| {
            self.allocator.free(v);
        }
        if (self.last_processing_result) |v| {
            self.allocator.free(v);
        }
        if (self.state) |v| {
            self.allocator.free(v);
        }
        if (self.state_transition_reason) |v| {
            self.allocator.free(v);
        }
        if (self.uuid) |v| {
            self.allocator.free(v);
        }
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateEventSourceMappingInput, options: Options) !CreateEventSourceMappingOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "lambda");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status);
        }
        return error.ServiceError;
    }

    return try deserializeResponse(response.body, response.status, client.allocator);
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateEventSourceMappingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("lambda", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    const path = "/2015-03-31/event-source-mappings";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.batch_size) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"BatchSize\":");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try body_buf.appendSlice(alloc, num_str);
        }
        has_prev = true;
    }
    if (input.bisect_batch_on_function_error) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"BisectBatchOnFunctionError\":");
        try body_buf.appendSlice(alloc, if (v) "true" else "false");
        has_prev = true;
    }
    if (input.enabled) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Enabled\":");
        try body_buf.appendSlice(alloc, if (v) "true" else "false");
        has_prev = true;
    }
    if (input.event_source_arn) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"EventSourceArn\":\"");
        try appendJsonEscaped(alloc, &body_buf, v);
        try body_buf.appendSlice(alloc, "\"");
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"FunctionName\":\"");
    try appendJsonEscaped(alloc, &body_buf, input.function_name);
    try body_buf.appendSlice(alloc, "\"");
    has_prev = true;
    if (input.kms_key_arn) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"KMSKeyArn\":\"");
        try appendJsonEscaped(alloc, &body_buf, v);
        try body_buf.appendSlice(alloc, "\"");
        has_prev = true;
    }
    if (input.maximum_batching_window_in_seconds) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"MaximumBatchingWindowInSeconds\":");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try body_buf.appendSlice(alloc, num_str);
        }
        has_prev = true;
    }
    if (input.maximum_record_age_in_seconds) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"MaximumRecordAgeInSeconds\":");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try body_buf.appendSlice(alloc, num_str);
        }
        has_prev = true;
    }
    if (input.maximum_retry_attempts) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"MaximumRetryAttempts\":");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try body_buf.appendSlice(alloc, num_str);
        }
        has_prev = true;
    }
    if (input.parallelization_factor) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"ParallelizationFactor\":");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try body_buf.appendSlice(alloc, num_str);
        }
        has_prev = true;
    }
    if (input.starting_position) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"StartingPosition\":\"");
        try body_buf.appendSlice(alloc, @tagName(v));
        try body_buf.appendSlice(alloc, "\"");
        has_prev = true;
    }
    if (input.starting_position_timestamp) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"StartingPositionTimestamp\":");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try body_buf.appendSlice(alloc, num_str);
        }
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Tags\":\"");
        try appendJsonEscaped(alloc, &body_buf, v);
        try body_buf.appendSlice(alloc, "\"");
        has_prev = true;
    }
    if (input.tumbling_window_in_seconds) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"TumblingWindowInSeconds\":");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try body_buf.appendSlice(alloc, num_str);
        }
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !CreateEventSourceMappingOutput {
    var result: CreateEventSourceMappingOutput = .{ .allocator = alloc };
    _ = status;
    if (findJsonValue(body, "BatchSize")) |content| {
        result.batch_size = std.fmt.parseInt(i32, content, 10) catch null;
    }
    if (findJsonValue(body, "BisectBatchOnFunctionError")) |content| {
        result.bisect_batch_on_function_error = std.mem.eql(u8, content, "true");
    }
    if (findJsonValue(body, "EventSourceArn")) |content| {
        result.event_source_arn = try alloc.dupe(u8, content);
    }
    if (findJsonValue(body, "EventSourceMappingArn")) |content| {
        result.event_source_mapping_arn = try alloc.dupe(u8, content);
    }
    if (findJsonValue(body, "FunctionArn")) |content| {
        result.function_arn = try alloc.dupe(u8, content);
    }
    if (findJsonValue(body, "KMSKeyArn")) |content| {
        result.kms_key_arn = try alloc.dupe(u8, content);
    }
    if (findJsonValue(body, "LastModified")) |content| {
        result.last_modified = std.fmt.parseInt(i64, content, 10) catch null;
    }
    if (findJsonValue(body, "LastProcessingResult")) |content| {
        result.last_processing_result = try alloc.dupe(u8, content);
    }
    if (findJsonValue(body, "MaximumBatchingWindowInSeconds")) |content| {
        result.maximum_batching_window_in_seconds = std.fmt.parseInt(i32, content, 10) catch null;
    }
    if (findJsonValue(body, "MaximumRecordAgeInSeconds")) |content| {
        result.maximum_record_age_in_seconds = std.fmt.parseInt(i32, content, 10) catch null;
    }
    if (findJsonValue(body, "MaximumRetryAttempts")) |content| {
        result.maximum_retry_attempts = std.fmt.parseInt(i32, content, 10) catch null;
    }
    if (findJsonValue(body, "ParallelizationFactor")) |content| {
        result.parallelization_factor = std.fmt.parseInt(i32, content, 10) catch null;
    }
    if (findJsonValue(body, "StartingPositionTimestamp")) |content| {
        result.starting_position_timestamp = std.fmt.parseInt(i64, content, 10) catch null;
    }
    if (findJsonValue(body, "State")) |content| {
        result.state = try alloc.dupe(u8, content);
    }
    if (findJsonValue(body, "StateTransitionReason")) |content| {
        result.state_transition_reason = try alloc.dupe(u8, content);
    }
    if (findJsonValue(body, "TumblingWindowInSeconds")) |content| {
        result.tumbling_window_in_seconds = std.fmt.parseInt(i32, content, 10) catch null;
    }
    if (findJsonValue(body, "UUID")) |content| {
        result.uuid = try alloc.dupe(u8, content);
    }

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = blk: {
        const type_str = findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = findJsonValue(body, "message") orelse findJsonValue(body, "Message") orelse "";

    if (std.mem.eql(u8, error_code, "CallbackTimeoutException")) {
        return .{ .callback_timeout_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "CapacityProviderLimitExceededException")) {
        return .{ .capacity_provider_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "CodeSigningConfigNotFoundException")) {
        return .{ .code_signing_config_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "CodeStorageExceededException")) {
        return .{ .code_storage_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "CodeVerificationFailedException")) {
        return .{ .code_verification_failed_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "DurableExecutionAlreadyStartedException")) {
        return .{ .durable_execution_already_started_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "EC2AccessDeniedException")) {
        return .{ .ec2_access_denied_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "EC2ThrottledException")) {
        return .{ .ec2_throttled_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "EC2UnexpectedException")) {
        return .{ .ec2_unexpected_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "EFSMountConnectivityException")) {
        return .{ .efs_mount_connectivity_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "EFSMountFailureException")) {
        return .{ .efs_mount_failure_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "EFSMountTimeoutException")) {
        return .{ .efs_mount_timeout_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "EFSIOException")) {
        return .{ .efsio_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ENILimitReachedException")) {
        return .{ .eni_limit_reached_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "FunctionVersionsPerCapacityProviderLimitExceededException")) {
        return .{ .function_versions_per_capacity_provider_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidCodeSignatureException")) {
        return .{ .invalid_code_signature_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterValueException")) {
        return .{ .invalid_parameter_value_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestContentException")) {
        return .{ .invalid_request_content_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRuntimeException")) {
        return .{ .invalid_runtime_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSecurityGroupIDException")) {
        return .{ .invalid_security_group_id_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSubnetIDException")) {
        return .{ .invalid_subnet_id_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidZipFileException")) {
        return .{ .invalid_zip_file_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "KMSAccessDeniedException")) {
        return .{ .kms_access_denied_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "KMSDisabledException")) {
        return .{ .kms_disabled_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "KMSInvalidStateException")) {
        return .{ .kms_invalid_state_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "KMSNotFoundException")) {
        return .{ .kms_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "NoPublishedVersionException")) {
        return .{ .no_published_version_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "PolicyLengthExceededException")) {
        return .{ .policy_length_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "PreconditionFailedException")) {
        return .{ .precondition_failed_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ProvisionedConcurrencyConfigNotFoundException")) {
        return .{ .provisioned_concurrency_config_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "RecursiveInvocationException")) {
        return .{ .recursive_invocation_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "RequestTooLargeException")) {
        return .{ .request_too_large_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceConflictException")) {
        return .{ .resource_conflict_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .resource_in_use_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .resource_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotReadyException")) {
        return .{ .resource_not_ready_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "SerializedRequestEntityTooLargeException")) {
        return .{ .serialized_request_entity_too_large_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ServiceException")) {
        return .{ .service_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "SnapStartException")) {
        return .{ .snap_start_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "SnapStartNotReadyException")) {
        return .{ .snap_start_not_ready_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "SnapStartTimeoutException")) {
        return .{ .snap_start_timeout_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "SubnetIPAddressLimitReachedException")) {
        return .{ .subnet_ip_address_limit_reached_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .too_many_requests_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedMediaTypeException")) {
        return .{ .unsupported_media_type_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }

    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = "",
        .http_status = status,
    } };
}

fn findJsonValue(json: []const u8, key: []const u8) ?[]const u8 {
    var buf: [258]u8 = undefined;
    if (key.len + 2 > buf.len) return null;
    buf[0] = 0x22;
    @memcpy(buf[1..][0..key.len], key);
    buf[key.len + 1] = 0x22;
    const search = buf[0 .. key.len + 2];
    const key_start = std.mem.indexOf(u8, json, search) orelse return null;
    var pos = key_start + search.len;

    while (pos < json.len) : (pos += 1) {
        if (json[pos] != ' ' and json[pos] != ':') break;
    }
    if (pos >= json.len) return null;

    if (json[pos] == 0x22) {
        const start = pos + 1;
        const end = std.mem.indexOfScalarPos(u8, json, start, 0x22) orelse return null;
        return json[start..end];
    }

    const start = pos;
    while (pos < json.len) : (pos += 1) {
        if (json[pos] == ',' or json[pos] == '}' or json[pos] == ' ') break;
    }
    return json[start..pos];
}

fn appendJsonEscaped(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const u8) !void {
    for (value) |c| {
        switch (c) {
            0x22 => { try buf.append(alloc, 0x5C); try buf.append(alloc, 0x22); },
            0x5C => { try buf.append(alloc, 0x5C); try buf.append(alloc, 0x5C); },
            0x0A => { try buf.append(alloc, 0x5C); try buf.append(alloc, 'n'); },
            0x0D => { try buf.append(alloc, 0x5C); try buf.append(alloc, 'r'); },
            0x09 => { try buf.append(alloc, 0x5C); try buf.append(alloc, 't'); },
            else => {
                if (c < 0x20) {
                    const hex = "0123456789abcdef";
                    try buf.append(alloc, 0x5C);
                    try buf.append(alloc, 'u');
                    try buf.append(alloc, '0');
                    try buf.append(alloc, '0');
                    try buf.append(alloc, hex[c >> 4]);
                    try buf.append(alloc, hex[c & 0x0F]);
                } else {
                    try buf.append(alloc, c);
                }
            }
        }
    }
}

fn appendUrlEncoded(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const u8) !void {
    for (value) |c| {
        switch (c) {
            'A'...'Z', 'a'...'z', '0'...'9', '-', '_', '.', '~' => try buf.append(alloc, c),
            ' ' => try buf.append(alloc, '+'),
            else => {
                const hex = "0123456789ABCDEF";
                try buf.append(alloc, '%');
                try buf.append(alloc, hex[c >> 4]);
                try buf.append(alloc, hex[c & 0x0F]);
            }
        }
    }
}

fn parseHost(endpoint: []const u8) []const u8 {
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    const end = std.mem.indexOfAny(u8, after_scheme, ":/") orelse after_scheme.len;
    return after_scheme[0..end];
}

fn parsePort(endpoint: []const u8) ?u16 {
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    const colon = std.mem.indexOfScalar(u8, after_scheme, ':') orelse return null;
    const port_end = std.mem.indexOfScalarPos(u8, after_scheme, colon + 1, '/') orelse after_scheme.len;
    return std.fmt.parseInt(u16, after_scheme[colon + 1 .. port_end], 10) catch null;
}

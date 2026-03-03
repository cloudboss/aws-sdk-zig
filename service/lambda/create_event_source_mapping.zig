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
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The name of the Kafka topic.
    topics: ?[]const []const u8 = null,

    /// (Kinesis and DynamoDB Streams only) The duration in seconds of a processing
    /// window for DynamoDB and Kinesis Streams event sources. A value of 0 seconds
    /// indicates no tumbling window.
    tumbling_window_in_seconds: ?i32 = null,

    pub const json_field_names = .{
        .amazon_managed_kafka_event_source_config = "AmazonManagedKafkaEventSourceConfig",
        .batch_size = "BatchSize",
        .bisect_batch_on_function_error = "BisectBatchOnFunctionError",
        .destination_config = "DestinationConfig",
        .document_db_event_source_config = "DocumentDBEventSourceConfig",
        .enabled = "Enabled",
        .event_source_arn = "EventSourceArn",
        .filter_criteria = "FilterCriteria",
        .function_name = "FunctionName",
        .function_response_types = "FunctionResponseTypes",
        .kms_key_arn = "KMSKeyArn",
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
        .tags = "Tags",
        .topics = "Topics",
        .tumbling_window_in_seconds = "TumblingWindowInSeconds",
    };
};

const CreateEventSourceMappingOutput = @import("event_source_mapping_configuration.zig").EventSourceMappingConfiguration;

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEventSourceMappingInput, options: Options) !CreateEventSourceMappingOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEventSourceMappingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/2015-03-31/event-source-mappings";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.amazon_managed_kafka_event_source_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AmazonManagedKafkaEventSourceConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.batch_size) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"BatchSize\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.bisect_batch_on_function_error) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"BisectBatchOnFunctionError\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.destination_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DestinationConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.document_db_event_source_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DocumentDBEventSourceConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.enabled) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Enabled\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.event_source_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EventSourceArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.filter_criteria) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FilterCriteria\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"FunctionName\":");
    try aws.json.writeValue(@TypeOf(input.function_name), input.function_name, allocator, &body_buf);
    has_prev = true;
    if (input.function_response_types) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FunctionResponseTypes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kms_key_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"KMSKeyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.logging_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LoggingConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.maximum_batching_window_in_seconds) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaximumBatchingWindowInSeconds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.maximum_record_age_in_seconds) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaximumRecordAgeInSeconds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.maximum_retry_attempts) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaximumRetryAttempts\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.metrics_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MetricsConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.parallelization_factor) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ParallelizationFactor\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.provisioned_poller_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ProvisionedPollerConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.queues) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Queues\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.scaling_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ScalingConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.self_managed_event_source) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SelfManagedEventSource\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.self_managed_kafka_event_source_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SelfManagedKafkaEventSourceConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.source_access_configurations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SourceAccessConfigurations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.starting_position) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"StartingPosition\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.starting_position_timestamp) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"StartingPositionTimestamp\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.topics) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Topics\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tumbling_window_in_seconds) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TumblingWindowInSeconds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEventSourceMappingOutput {
    var result: CreateEventSourceMappingOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateEventSourceMappingOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "CallbackTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .callback_timeout_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CapacityProviderLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .capacity_provider_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CodeSigningConfigNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .code_signing_config_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CodeStorageExceededException")) {
        return .{ .arena = arena, .kind = .{ .code_storage_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CodeVerificationFailedException")) {
        return .{ .arena = arena, .kind = .{ .code_verification_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DurableExecutionAlreadyStartedException")) {
        return .{ .arena = arena, .kind = .{ .durable_execution_already_started_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EC2AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .ec2_access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EC2ThrottledException")) {
        return .{ .arena = arena, .kind = .{ .ec2_throttled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EC2UnexpectedException")) {
        return .{ .arena = arena, .kind = .{ .ec2_unexpected_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EFSMountConnectivityException")) {
        return .{ .arena = arena, .kind = .{ .efs_mount_connectivity_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EFSMountFailureException")) {
        return .{ .arena = arena, .kind = .{ .efs_mount_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EFSMountTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .efs_mount_timeout_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EFSIOException")) {
        return .{ .arena = arena, .kind = .{ .efsio_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ENILimitReachedException")) {
        return .{ .arena = arena, .kind = .{ .eni_limit_reached_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FunctionVersionsPerCapacityProviderLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .function_versions_per_capacity_provider_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidCodeSignatureException")) {
        return .{ .arena = arena, .kind = .{ .invalid_code_signature_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterValueException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_value_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestContentException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_content_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRuntimeException")) {
        return .{ .arena = arena, .kind = .{ .invalid_runtime_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSecurityGroupIDException")) {
        return .{ .arena = arena, .kind = .{ .invalid_security_group_id_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSubnetIDException")) {
        return .{ .arena = arena, .kind = .{ .invalid_subnet_id_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidZipFileException")) {
        return .{ .arena = arena, .kind = .{ .invalid_zip_file_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSAccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .kms_access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSDisabledException")) {
        return .{ .arena = arena, .kind = .{ .kms_disabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSInvalidStateException")) {
        return .{ .arena = arena, .kind = .{ .kms_invalid_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .kms_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoPublishedVersionException")) {
        return .{ .arena = arena, .kind = .{ .no_published_version_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PolicyLengthExceededException")) {
        return .{ .arena = arena, .kind = .{ .policy_length_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PreconditionFailedException")) {
        return .{ .arena = arena, .kind = .{ .precondition_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ProvisionedConcurrencyConfigNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .provisioned_concurrency_config_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RecursiveInvocationException")) {
        return .{ .arena = arena, .kind = .{ .recursive_invocation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RequestTooLargeException")) {
        return .{ .arena = arena, .kind = .{ .request_too_large_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceConflictException")) {
        return .{ .arena = arena, .kind = .{ .resource_conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotReadyException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_ready_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SerializedRequestEntityTooLargeException")) {
        return .{ .arena = arena, .kind = .{ .serialized_request_entity_too_large_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceException")) {
        return .{ .arena = arena, .kind = .{ .service_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SnapStartException")) {
        return .{ .arena = arena, .kind = .{ .snap_start_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SnapStartNotReadyException")) {
        return .{ .arena = arena, .kind = .{ .snap_start_not_ready_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SnapStartTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .snap_start_timeout_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubnetIPAddressLimitReachedException")) {
        return .{ .arena = arena, .kind = .{ .subnet_ip_address_limit_reached_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedMediaTypeException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_media_type_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}

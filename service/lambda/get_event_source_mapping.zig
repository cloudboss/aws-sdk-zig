const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
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

/// Returns details about an event source mapping. You can get the identifier of
/// a mapping from the output of ListEventSourceMappings.
pub const GetEventSourceMappingInput = struct {
    /// The identifier of the event source mapping.
    uuid: []const u8,

    pub const json_field_names = .{
        .uuid = "UUID",
    };
};

pub const GetEventSourceMappingOutput = struct {
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

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *GetEventSourceMappingOutput) void {
        self._arena.deinit();
    }

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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: GetEventSourceMappingInput, options: Options) !GetEventSourceMappingOutput {
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

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetEventSourceMappingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("lambda", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/2015-03-31/event-source-mappings/");
    try path_buf.appendSlice(alloc, input.uuid);
    const path = try path_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetEventSourceMappingOutput {
    var result: GetEventSourceMappingOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetEventSourceMappingOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";

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

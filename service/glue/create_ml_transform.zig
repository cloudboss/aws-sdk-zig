const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const GlueTable = @import("glue_table.zig").GlueTable;
const TransformParameters = @import("transform_parameters.zig").TransformParameters;
const TransformEncryption = @import("transform_encryption.zig").TransformEncryption;
const WorkerType = @import("worker_type.zig").WorkerType;

pub const CreateMLTransformInput = struct {
    /// A description of the machine learning transform that is being defined. The
    /// default is an
    /// empty string.
    description: ?[]const u8 = null,

    /// This value determines which version of Glue this machine learning transform
    /// is compatible with. Glue 1.0 is recommended for most customers. If the value
    /// is not set, the Glue compatibility defaults to Glue 0.9. For more
    /// information, see [Glue
    /// Versions](https://docs.aws.amazon.com/glue/latest/dg/release-notes.html#release-notes-versions) in the developer guide.
    glue_version: ?[]const u8 = null,

    /// A list of Glue table definitions used by the transform.
    input_record_tables: []const GlueTable,

    /// The number of Glue data processing units (DPUs) that are allocated to task
    /// runs for this transform. You can allocate from 2 to 100 DPUs; the default is
    /// 10. A DPU is a relative measure of
    /// processing power that consists of 4 vCPUs of compute capacity and 16 GB of
    /// memory. For more
    /// information, see the [Glue pricing
    /// page](https://aws.amazon.com/glue/pricing/).
    ///
    /// `MaxCapacity` is a mutually exclusive option with `NumberOfWorkers` and
    /// `WorkerType`.
    ///
    /// * If either `NumberOfWorkers` or `WorkerType` is set, then `MaxCapacity`
    ///   cannot be set.
    ///
    /// * If `MaxCapacity` is set then neither `NumberOfWorkers` or `WorkerType` can
    ///   be set.
    ///
    /// * If `WorkerType` is set, then `NumberOfWorkers` is required (and vice
    ///   versa).
    ///
    /// * `MaxCapacity` and `NumberOfWorkers` must both be at least 1.
    ///
    /// When the `WorkerType` field is set to a value other than `Standard`, the
    /// `MaxCapacity` field is set automatically and becomes read-only.
    ///
    /// When the `WorkerType` field is set to a value other than `Standard`, the
    /// `MaxCapacity` field is set automatically and becomes read-only.
    max_capacity: ?f64 = null,

    /// The maximum number of times to retry a task for this transform after a task
    /// run fails.
    max_retries: ?i32 = null,

    /// The unique name that you give the transform when you create it.
    name: []const u8,

    /// The number of workers of a defined `workerType` that are allocated when this
    /// task runs.
    ///
    /// If `WorkerType` is set, then `NumberOfWorkers` is required (and vice versa).
    number_of_workers: ?i32 = null,

    /// The algorithmic parameters that are specific to the transform type used.
    /// Conditionally
    /// dependent on the transform type.
    parameters: TransformParameters,

    /// The name or Amazon Resource Name (ARN) of the IAM role with the required
    /// permissions. The required permissions include both Glue service role
    /// permissions to Glue resources, and Amazon S3 permissions required by the
    /// transform.
    ///
    /// * This role needs Glue service role permissions to allow access to resources
    ///   in Glue. See [Attach a Policy to IAM Users That Access
    ///   Glue](https://docs.aws.amazon.com/glue/latest/dg/attach-policy-iam-user.html).
    ///
    /// * This role needs permission to your Amazon Simple Storage Service (Amazon
    ///   S3) sources, targets, temporary directory, scripts, and any libraries used
    ///   by the task run for this transform.
    role: []const u8,

    /// The tags to use with this machine learning transform. You may use tags to
    /// limit access to the machine learning transform. For more information about
    /// tags in Glue, see [Amazon Web Services Tags in
    /// Glue](https://docs.aws.amazon.com/glue/latest/dg/monitor-tags.html) in the
    /// developer guide.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The timeout of the task run for this transform in minutes. This is the
    /// maximum time that a task run for this transform can consume resources before
    /// it is terminated and enters `TIMEOUT` status. The default is 2,880 minutes
    /// (48 hours).
    timeout: ?i32 = null,

    /// The encryption-at-rest settings of the transform that apply to accessing
    /// user data. Machine learning transforms can access user data encrypted in
    /// Amazon S3 using KMS.
    transform_encryption: ?TransformEncryption = null,

    /// The type of predefined worker that is allocated when this task runs. Accepts
    /// a value of Standard, G.1X, or G.2X.
    ///
    /// * For the `Standard` worker type, each worker provides 4 vCPU, 16 GB of
    ///   memory and a 50GB disk, and 2 executors per worker.
    ///
    /// * For the `G.1X` worker type, each worker provides 4 vCPU, 16 GB of memory
    ///   and a 64GB disk, and 1 executor per worker.
    ///
    /// * For the `G.2X` worker type, each worker provides 8 vCPU, 32 GB of memory
    ///   and a 128GB disk, and 1 executor per worker.
    ///
    /// `MaxCapacity` is a mutually exclusive option with `NumberOfWorkers` and
    /// `WorkerType`.
    ///
    /// * If either `NumberOfWorkers` or `WorkerType` is set, then `MaxCapacity`
    ///   cannot be set.
    ///
    /// * If `MaxCapacity` is set then neither `NumberOfWorkers` or `WorkerType` can
    ///   be set.
    ///
    /// * If `WorkerType` is set, then `NumberOfWorkers` is required (and vice
    ///   versa).
    ///
    /// * `MaxCapacity` and `NumberOfWorkers` must both be at least 1.
    worker_type: ?WorkerType = null,

    pub const json_field_names = .{
        .description = "Description",
        .glue_version = "GlueVersion",
        .input_record_tables = "InputRecordTables",
        .max_capacity = "MaxCapacity",
        .max_retries = "MaxRetries",
        .name = "Name",
        .number_of_workers = "NumberOfWorkers",
        .parameters = "Parameters",
        .role = "Role",
        .tags = "Tags",
        .timeout = "Timeout",
        .transform_encryption = "TransformEncryption",
        .worker_type = "WorkerType",
    };
};

pub const CreateMLTransformOutput = struct {
    /// A unique identifier that is generated for the transform.
    transform_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .transform_id = "TransformId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateMLTransformInput, options: Options) !CreateMLTransformOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "glue");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateMLTransformInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "AWSGlue.CreateMLTransform");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateMLTransformOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateMLTransformOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ColumnStatisticsTaskNotRunningException")) {
        return .{ .arena = arena, .kind = .{ .column_statistics_task_not_running_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ColumnStatisticsTaskRunningException")) {
        return .{ .arena = arena, .kind = .{ .column_statistics_task_running_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ColumnStatisticsTaskStoppingException")) {
        return .{ .arena = arena, .kind = .{ .column_statistics_task_stopping_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConcurrentRunsExceededException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_runs_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConditionCheckFailureException")) {
        return .{ .arena = arena, .kind = .{ .condition_check_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CrawlerNotRunningException")) {
        return .{ .arena = arena, .kind = .{ .crawler_not_running_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CrawlerRunningException")) {
        return .{ .arena = arena, .kind = .{ .crawler_running_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CrawlerStoppingException")) {
        return .{ .arena = arena, .kind = .{ .crawler_stopping_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EntityNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .entity_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FederatedResourceAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .federated_resource_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FederationSourceException")) {
        return .{ .arena = arena, .kind = .{ .federation_source_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FederationSourceRetryableException")) {
        return .{ .arena = arena, .kind = .{ .federation_source_retryable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "GlueEncryptionException")) {
        return .{ .arena = arena, .kind = .{ .glue_encryption_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IdempotentParameterMismatchException")) {
        return .{ .arena = arena, .kind = .{ .idempotent_parameter_mismatch_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IllegalBlueprintStateException")) {
        return .{ .arena = arena, .kind = .{ .illegal_blueprint_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IllegalSessionStateException")) {
        return .{ .arena = arena, .kind = .{ .illegal_session_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IllegalWorkflowStateException")) {
        return .{ .arena = arena, .kind = .{ .illegal_workflow_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IntegrationConflictOperationFault")) {
        return .{ .arena = arena, .kind = .{ .integration_conflict_operation_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IntegrationNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .integration_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IntegrationQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .integration_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServiceException")) {
        return .{ .arena = arena, .kind = .{ .internal_service_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        return .{ .arena = arena, .kind = .{ .invalid_input_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidIntegrationStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_integration_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidStateException")) {
        return .{ .arena = arena, .kind = .{ .invalid_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSKeyNotAccessibleFault")) {
        return .{ .arena = arena, .kind = .{ .kms_key_not_accessible_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MaterializedViewRefreshTaskNotRunningException")) {
        return .{ .arena = arena, .kind = .{ .materialized_view_refresh_task_not_running_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MaterializedViewRefreshTaskRunningException")) {
        return .{ .arena = arena, .kind = .{ .materialized_view_refresh_task_running_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MaterializedViewRefreshTaskStoppingException")) {
        return .{ .arena = arena, .kind = .{ .materialized_view_refresh_task_stopping_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MLTransformNotReadyException")) {
        return .{ .arena = arena, .kind = .{ .ml_transform_not_ready_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoScheduleException")) {
        return .{ .arena = arena, .kind = .{ .no_schedule_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationNotSupportedException")) {
        return .{ .arena = arena, .kind = .{ .operation_not_supported_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .operation_timeout_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PermissionTypeMismatchException")) {
        return .{ .arena = arena, .kind = .{ .permission_type_mismatch_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceNumberLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .resource_number_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SchedulerNotRunningException")) {
        return .{ .arena = arena, .kind = .{ .scheduler_not_running_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SchedulerRunningException")) {
        return .{ .arena = arena, .kind = .{ .scheduler_running_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SchedulerTransitioningException")) {
        return .{ .arena = arena, .kind = .{ .scheduler_transitioning_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TargetResourceNotFound")) {
        return .{ .arena = arena, .kind = .{ .target_resource_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "VersionMismatchException")) {
        return .{ .arena = arena, .kind = .{ .version_mismatch_exception = .{
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

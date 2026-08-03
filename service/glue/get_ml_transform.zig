const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const EvaluationMetrics = @import("evaluation_metrics.zig").EvaluationMetrics;
const GlueTable = @import("glue_table.zig").GlueTable;
const TransformParameters = @import("transform_parameters.zig").TransformParameters;
const SchemaColumn = @import("schema_column.zig").SchemaColumn;
const TransformStatusType = @import("transform_status_type.zig").TransformStatusType;
const TransformEncryption = @import("transform_encryption.zig").TransformEncryption;
const WorkerType = @import("worker_type.zig").WorkerType;

pub const GetMLTransformInput = struct {
    /// The unique identifier of the transform, generated at the time that the
    /// transform was
    /// created.
    transform_id: []const u8,

    pub const json_field_names = .{
        .transform_id = "TransformId",
    };
};

pub const GetMLTransformOutput = struct {
    /// The date and time when the transform was created.
    created_on: ?i64 = null,

    /// A description of the transform.
    description: ?[]const u8 = null,

    /// The latest evaluation metrics.
    evaluation_metrics: ?EvaluationMetrics = null,

    /// This value determines which version of Glue this machine learning transform
    /// is compatible with. Glue 1.0 is recommended for most customers. If the value
    /// is not set, the Glue compatibility defaults to Glue 0.9. For more
    /// information, see [Glue
    /// Versions](https://docs.aws.amazon.com/glue/latest/dg/release-notes.html#release-notes-versions) in the developer guide.
    glue_version: ?[]const u8 = null,

    /// A list of Glue table definitions used by the transform.
    input_record_tables: ?[]const GlueTable = null,

    /// The number of labels available for this transform.
    label_count: ?i32 = null,

    /// The date and time when the transform was last modified.
    last_modified_on: ?i64 = null,

    /// The number of Glue data processing units (DPUs) that are allocated to task
    /// runs for this transform. You can allocate from 2 to 100 DPUs; the default is
    /// 10. A DPU is a relative measure of
    /// processing power that consists of 4 vCPUs of compute capacity and 16 GB of
    /// memory. For more
    /// information, see the [Glue pricing
    /// page](https://aws.amazon.com/glue/pricing/).
    ///
    /// When the `WorkerType` field is set to a value other than `Standard`, the
    /// `MaxCapacity` field is set automatically and becomes read-only.
    max_capacity: ?f64 = null,

    /// The maximum number of times to retry a task for this transform after a task
    /// run fails.
    max_retries: ?i32 = null,

    /// The unique name given to the transform when it was created.
    name: ?[]const u8 = null,

    /// The number of workers of a defined `workerType` that are allocated when this
    /// task runs.
    number_of_workers: ?i32 = null,

    /// The configuration parameters that are specific to the algorithm used.
    parameters: ?TransformParameters = null,

    /// The name or Amazon Resource Name (ARN) of the IAM role with the required
    /// permissions.
    role: ?[]const u8 = null,

    /// The `Map` object that represents the schema that this
    /// transform accepts. Has an upper bound of 100 columns.
    schema: ?[]const SchemaColumn = null,

    /// The last known status of the transform (to indicate whether it can be used
    /// or not). One of "NOT_READY", "READY", or "DELETING".
    status: ?TransformStatusType = null,

    /// The timeout for a task run for this transform in minutes. This is the
    /// maximum time that a task run for this transform can consume resources before
    /// it is terminated and enters `TIMEOUT` status. The default is 2,880 minutes
    /// (48 hours).
    timeout: ?i32 = null,

    /// The encryption-at-rest settings of the transform that apply to accessing
    /// user data. Machine learning transforms can access user data encrypted in
    /// Amazon S3 using KMS.
    transform_encryption: ?TransformEncryption = null,

    /// The unique identifier of the transform, generated at the time that the
    /// transform was
    /// created.
    transform_id: ?[]const u8 = null,

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
    worker_type: ?WorkerType = null,

    pub const json_field_names = .{
        .created_on = "CreatedOn",
        .description = "Description",
        .evaluation_metrics = "EvaluationMetrics",
        .glue_version = "GlueVersion",
        .input_record_tables = "InputRecordTables",
        .label_count = "LabelCount",
        .last_modified_on = "LastModifiedOn",
        .max_capacity = "MaxCapacity",
        .max_retries = "MaxRetries",
        .name = "Name",
        .number_of_workers = "NumberOfWorkers",
        .parameters = "Parameters",
        .role = "Role",
        .schema = "Schema",
        .status = "Status",
        .timeout = "Timeout",
        .transform_encryption = "TransformEncryption",
        .transform_id = "TransformId",
        .worker_type = "WorkerType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMLTransformInput, options: CallOptions) !GetMLTransformOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetMLTransformInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.GetMLTransform");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMLTransformOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetMLTransformOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        const parsed_error: ?errors.AccessDeniedException = aws.json.parseJsonObject(errors.AccessDeniedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .access_denied_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AlreadyExistsException")) {
        const parsed_error: ?errors.AlreadyExistsException = aws.json.parseJsonObject(errors.AlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ColumnStatisticsTaskNotRunningException")) {
        const parsed_error: ?errors.ColumnStatisticsTaskNotRunningException = aws.json.parseJsonObject(errors.ColumnStatisticsTaskNotRunningException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .column_statistics_task_not_running_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ColumnStatisticsTaskRunningException")) {
        const parsed_error: ?errors.ColumnStatisticsTaskRunningException = aws.json.parseJsonObject(errors.ColumnStatisticsTaskRunningException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .column_statistics_task_running_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ColumnStatisticsTaskStoppingException")) {
        const parsed_error: ?errors.ColumnStatisticsTaskStoppingException = aws.json.parseJsonObject(errors.ColumnStatisticsTaskStoppingException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .column_statistics_task_stopping_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        const parsed_error: ?errors.ConcurrentModificationException = aws.json.parseJsonObject(errors.ConcurrentModificationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ConcurrentRunsExceededException")) {
        const parsed_error: ?errors.ConcurrentRunsExceededException = aws.json.parseJsonObject(errors.ConcurrentRunsExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .concurrent_runs_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ConditionCheckFailureException")) {
        const parsed_error: ?errors.ConditionCheckFailureException = aws.json.parseJsonObject(errors.ConditionCheckFailureException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .condition_check_failure_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        const parsed_error: ?errors.ConflictException = aws.json.parseJsonObject(errors.ConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CrawlerNotRunningException")) {
        const parsed_error: ?errors.CrawlerNotRunningException = aws.json.parseJsonObject(errors.CrawlerNotRunningException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .crawler_not_running_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CrawlerRunningException")) {
        const parsed_error: ?errors.CrawlerRunningException = aws.json.parseJsonObject(errors.CrawlerRunningException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .crawler_running_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CrawlerStoppingException")) {
        const parsed_error: ?errors.CrawlerStoppingException = aws.json.parseJsonObject(errors.CrawlerStoppingException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .crawler_stopping_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "EntityNotFoundException")) {
        const parsed_error: ?errors.EntityNotFoundException = aws.json.parseJsonObject(errors.EntityNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .entity_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "FederatedResourceAlreadyExistsException")) {
        const parsed_error: ?errors.FederatedResourceAlreadyExistsException = aws.json.parseJsonObject(errors.FederatedResourceAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .federated_resource_already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "FederationSourceException")) {
        const parsed_error: ?errors.FederationSourceException = aws.json.parseJsonObject(errors.FederationSourceException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .federation_source_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "FederationSourceRetryableException")) {
        const parsed_error: ?errors.FederationSourceRetryableException = aws.json.parseJsonObject(errors.FederationSourceRetryableException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .federation_source_retryable_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "GlueEncryptionException")) {
        const parsed_error: ?errors.GlueEncryptionException = aws.json.parseJsonObject(errors.GlueEncryptionException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .glue_encryption_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IdempotentParameterMismatchException")) {
        const parsed_error: ?errors.IdempotentParameterMismatchException = aws.json.parseJsonObject(errors.IdempotentParameterMismatchException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .idempotent_parameter_mismatch_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IllegalBlueprintStateException")) {
        const parsed_error: ?errors.IllegalBlueprintStateException = aws.json.parseJsonObject(errors.IllegalBlueprintStateException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .illegal_blueprint_state_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IllegalSessionStateException")) {
        const parsed_error: ?errors.IllegalSessionStateException = aws.json.parseJsonObject(errors.IllegalSessionStateException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .illegal_session_state_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IllegalWorkflowStateException")) {
        const parsed_error: ?errors.IllegalWorkflowStateException = aws.json.parseJsonObject(errors.IllegalWorkflowStateException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .illegal_workflow_state_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IntegrationConflictOperationFault")) {
        const parsed_error: ?errors.IntegrationConflictOperationFault = aws.json.parseJsonObject(errors.IntegrationConflictOperationFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .integration_conflict_operation_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IntegrationNotFoundFault")) {
        const parsed_error: ?errors.IntegrationNotFoundFault = aws.json.parseJsonObject(errors.IntegrationNotFoundFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .integration_not_found_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IntegrationQuotaExceededFault")) {
        const parsed_error: ?errors.IntegrationQuotaExceededFault = aws.json.parseJsonObject(errors.IntegrationQuotaExceededFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .integration_quota_exceeded_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        const parsed_error: ?errors.InternalServerException = aws.json.parseJsonObject(errors.InternalServerException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_server_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InternalServiceException")) {
        const parsed_error: ?errors.InternalServiceException = aws.json.parseJsonObject(errors.InternalServiceException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_service_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        const parsed_error: ?errors.InvalidInputException = aws.json.parseJsonObject(errors.InvalidInputException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_input_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidIntegrationStateFault")) {
        const parsed_error: ?errors.InvalidIntegrationStateFault = aws.json.parseJsonObject(errors.InvalidIntegrationStateFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_integration_state_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidStateException")) {
        const parsed_error: ?errors.InvalidStateException = aws.json.parseJsonObject(errors.InvalidStateException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_state_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "KMSKeyNotAccessibleFault")) {
        const parsed_error: ?errors.KMSKeyNotAccessibleFault = aws.json.parseJsonObject(errors.KMSKeyNotAccessibleFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .kms_key_not_accessible_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MaterializedViewRefreshTaskNotRunningException")) {
        const parsed_error: ?errors.MaterializedViewRefreshTaskNotRunningException = aws.json.parseJsonObject(errors.MaterializedViewRefreshTaskNotRunningException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .materialized_view_refresh_task_not_running_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MaterializedViewRefreshTaskRunningException")) {
        const parsed_error: ?errors.MaterializedViewRefreshTaskRunningException = aws.json.parseJsonObject(errors.MaterializedViewRefreshTaskRunningException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .materialized_view_refresh_task_running_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MaterializedViewRefreshTaskStoppingException")) {
        const parsed_error: ?errors.MaterializedViewRefreshTaskStoppingException = aws.json.parseJsonObject(errors.MaterializedViewRefreshTaskStoppingException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .materialized_view_refresh_task_stopping_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MLTransformNotReadyException")) {
        const parsed_error: ?errors.MLTransformNotReadyException = aws.json.parseJsonObject(errors.MLTransformNotReadyException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ml_transform_not_ready_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoScheduleException")) {
        const parsed_error: ?errors.NoScheduleException = aws.json.parseJsonObject(errors.NoScheduleException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_schedule_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OperationNotSupportedException")) {
        const parsed_error: ?errors.OperationNotSupportedException = aws.json.parseJsonObject(errors.OperationNotSupportedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .operation_not_supported_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OperationTimeoutException")) {
        const parsed_error: ?errors.OperationTimeoutException = aws.json.parseJsonObject(errors.OperationTimeoutException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .operation_timeout_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "PermissionTypeMismatchException")) {
        const parsed_error: ?errors.PermissionTypeMismatchException = aws.json.parseJsonObject(errors.PermissionTypeMismatchException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .permission_type_mismatch_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        const parsed_error: ?errors.ResourceNotFoundException = aws.json.parseJsonObject(errors.ResourceNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceNotReadyException")) {
        const parsed_error: ?errors.ResourceNotReadyException = aws.json.parseJsonObject(errors.ResourceNotReadyException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_not_ready_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceNumberLimitExceededException")) {
        const parsed_error: ?errors.ResourceNumberLimitExceededException = aws.json.parseJsonObject(errors.ResourceNumberLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_number_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SchedulerNotRunningException")) {
        const parsed_error: ?errors.SchedulerNotRunningException = aws.json.parseJsonObject(errors.SchedulerNotRunningException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .scheduler_not_running_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SchedulerRunningException")) {
        const parsed_error: ?errors.SchedulerRunningException = aws.json.parseJsonObject(errors.SchedulerRunningException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .scheduler_running_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SchedulerTransitioningException")) {
        const parsed_error: ?errors.SchedulerTransitioningException = aws.json.parseJsonObject(errors.SchedulerTransitioningException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .scheduler_transitioning_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TargetResourceNotFound")) {
        const parsed_error: ?errors.TargetResourceNotFound = aws.json.parseJsonObject(errors.TargetResourceNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .target_resource_not_found = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        const parsed_error: ?errors.ThrottlingException = aws.json.parseJsonObject(errors.ThrottlingException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .throttling_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        const parsed_error: ?errors.ValidationException = aws.json.parseJsonObject(errors.ValidationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .validation_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "VersionMismatchException")) {
        const parsed_error: ?errors.VersionMismatchException = aws.json.parseJsonObject(errors.VersionMismatchException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .version_mismatch_exception = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}

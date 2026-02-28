const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const IntegrationConfig = @import("integration_config.zig").IntegrationConfig;
const Tag = @import("tag.zig").Tag;
const IntegrationError = @import("integration_error.zig").IntegrationError;
const IntegrationStatus = @import("integration_status.zig").IntegrationStatus;

pub const CreateIntegrationInput = struct {
    /// An optional set of non-secret key–value pairs that contains additional
    /// contextual information for encryption. This can only be provided if
    /// `KMSKeyId` is provided.
    additional_encryption_context: ?[]const aws.map.StringMapEntry = null,

    /// Selects source tables for the integration using Maxwell filter syntax.
    data_filter: ?[]const u8 = null,

    /// A description of the integration.
    description: ?[]const u8 = null,

    /// The configuration settings.
    integration_config: ?IntegrationConfig = null,

    /// A unique name for an integration in Glue.
    integration_name: []const u8,

    /// The ARN of a KMS key used for encrypting the channel.
    kms_key_id: ?[]const u8 = null,

    /// The ARN of the source resource for the integration.
    source_arn: []const u8,

    /// Metadata assigned to the resource consisting of a list of key-value pairs.
    tags: ?[]const Tag = null,

    /// The ARN of the target resource for the integration.
    target_arn: []const u8,

    pub const json_field_names = .{
        .additional_encryption_context = "AdditionalEncryptionContext",
        .data_filter = "DataFilter",
        .description = "Description",
        .integration_config = "IntegrationConfig",
        .integration_name = "IntegrationName",
        .kms_key_id = "KmsKeyId",
        .source_arn = "SourceArn",
        .tags = "Tags",
        .target_arn = "TargetArn",
    };
};

pub const CreateIntegrationOutput = struct {
    /// An optional set of non-secret key–value pairs that contains additional
    /// contextual information for encryption.
    additional_encryption_context: ?[]const aws.map.StringMapEntry = null,

    /// The time when the integration was created, in UTC.
    create_time: i64,

    /// Selects source tables for the integration using Maxwell filter syntax.
    data_filter: ?[]const u8 = null,

    /// A description of the integration.
    description: ?[]const u8 = null,

    /// A list of errors associated with the integration creation.
    errors: ?[]const IntegrationError = null,

    /// The Amazon Resource Name (ARN) for the created integration.
    integration_arn: []const u8,

    /// The configuration settings.
    integration_config: ?IntegrationConfig = null,

    /// A unique name for an integration in Glue.
    integration_name: []const u8,

    /// The ARN of a KMS key used for encrypting the channel.
    kms_key_id: ?[]const u8 = null,

    /// The ARN of the source resource for the integration.
    source_arn: []const u8,

    /// The status of the integration being created.
    ///
    /// The possible statuses are:
    ///
    /// * CREATING: The integration is being created.
    ///
    /// * ACTIVE: The integration creation succeeds.
    ///
    /// * MODIFYING: The integration is being modified.
    ///
    /// * FAILED: The integration creation fails.
    ///
    /// * DELETING: The integration is deleted.
    ///
    /// * SYNCING: The integration is synchronizing.
    ///
    /// * NEEDS_ATTENTION: The integration needs attention, such as synchronization.
    status: IntegrationStatus,

    /// Metadata assigned to the resource consisting of a list of key-value pairs.
    tags: ?[]const Tag = null,

    /// The ARN of the target resource for the integration.
    target_arn: []const u8,

    pub const json_field_names = .{
        .additional_encryption_context = "AdditionalEncryptionContext",
        .create_time = "CreateTime",
        .data_filter = "DataFilter",
        .description = "Description",
        .errors = "Errors",
        .integration_arn = "IntegrationArn",
        .integration_config = "IntegrationConfig",
        .integration_name = "IntegrationName",
        .kms_key_id = "KmsKeyId",
        .source_arn = "SourceArn",
        .status = "Status",
        .tags = "Tags",
        .target_arn = "TargetArn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateIntegrationInput, options: Options) !CreateIntegrationOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateIntegrationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "AWSGlue.CreateIntegration");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateIntegrationOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateIntegrationOutput, body, alloc);
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

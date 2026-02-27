const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DefinitionS3Location = @import("definition_s3_location.zig").DefinitionS3Location;
const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;
const EngineVersion = @import("engine_version.zig").EngineVersion;
const LoggingConfiguration = @import("logging_configuration.zig").LoggingConfiguration;
const NetworkConfiguration = @import("network_configuration.zig").NetworkConfiguration;
const ScheduleConfiguration = @import("schedule_configuration.zig").ScheduleConfiguration;
const WorkflowStatus = @import("workflow_status.zig").WorkflowStatus;

pub const GetWorkflowInput = struct {
    /// The Amazon Resource Name (ARN) of the workflow you want to retrieve.
    workflow_arn: []const u8,

    /// Optional. The specific version of the workflow to retrieve. If not
    /// specified, the latest version is returned.
    workflow_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .workflow_arn = "WorkflowArn",
        .workflow_version = "WorkflowVersion",
    };
};

pub const GetWorkflowOutput = struct {
    /// The timestamp when the workflow was created, in ISO 8601 date-time format.
    created_at: ?i64 = null,

    /// The Amazon S3 location of the workflow definition file.
    definition_s3_location: ?DefinitionS3Location = null,

    /// The description of the workflow.
    description: ?[]const u8 = null,

    /// The encryption configuration for the workflow.
    encryption_configuration: ?EncryptionConfiguration = null,

    /// The version of the Amazon Managed Workflows for Apache Airflow Serverless
    /// engine that this workflow uses.
    engine_version: ?EngineVersion = null,

    /// The logging configuration for the workflow.
    logging_configuration: ?LoggingConfiguration = null,

    /// The timestamp when the workflow was last modified, in ISO 8601 date-time
    /// format.
    modified_at: ?i64 = null,

    /// The name of the workflow.
    name: ?[]const u8 = null,

    /// The network configuration for the workflow execution environment.
    network_configuration: ?NetworkConfiguration = null,

    /// The Amazon Resource Name (ARN) of the IAM role used for workflow execution.
    role_arn: ?[]const u8 = null,

    /// The schedule configuration for the workflow, including cron expressions for
    /// automated execution. Amazon Managed Workflows for Apache Airflow Serverless
    /// uses EventBridge Scheduler for cost-effective, timezone-aware scheduling.
    /// When a workflow includes schedule information in its YAML definition, the
    /// service automatically configures the appropriate triggers for automated
    /// execution. Only one version of a workflow can have an active schedule at any
    /// given time.
    schedule_configuration: ?ScheduleConfiguration = null,

    /// The trigger mode for the workflow execution.
    trigger_mode: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the workflow.
    workflow_arn: []const u8,

    /// The workflow definition content.
    workflow_definition: ?[]const u8 = null,

    /// The current status of the workflow.
    workflow_status: ?WorkflowStatus = null,

    /// The version identifier of the workflow.
    workflow_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .definition_s3_location = "DefinitionS3Location",
        .description = "Description",
        .encryption_configuration = "EncryptionConfiguration",
        .engine_version = "EngineVersion",
        .logging_configuration = "LoggingConfiguration",
        .modified_at = "ModifiedAt",
        .name = "Name",
        .network_configuration = "NetworkConfiguration",
        .role_arn = "RoleArn",
        .schedule_configuration = "ScheduleConfiguration",
        .trigger_mode = "TriggerMode",
        .workflow_arn = "WorkflowArn",
        .workflow_definition = "WorkflowDefinition",
        .workflow_status = "WorkflowStatus",
        .workflow_version = "WorkflowVersion",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetWorkflowInput, options: Options) !GetWorkflowOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "mwaaserverless");

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

fn serializeRequest(alloc: std.mem.Allocator, input: GetWorkflowInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mwaaserverless", "MWAA Serverless", alloc);

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
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(alloc, "X-Amz-Target", "AmazonMWAAServerless.GetWorkflow");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetWorkflowOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetWorkflowOutput, body, alloc);
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
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
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
    if (std.mem.eql(u8, error_code, "OperationTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .operation_timeout_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}

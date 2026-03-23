const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const BatchJobIdentifier = @import("batch_job_identifier.zig").BatchJobIdentifier;
const JobStepRestartMarker = @import("job_step_restart_marker.zig").JobStepRestartMarker;
const BatchJobType = @import("batch_job_type.zig").BatchJobType;
const BatchJobExecutionStatus = @import("batch_job_execution_status.zig").BatchJobExecutionStatus;

pub const GetBatchJobExecutionInput = struct {
    /// The identifier of the application.
    application_id: []const u8,

    /// The unique identifier of the batch job execution.
    execution_id: []const u8,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .execution_id = "executionId",
    };
};

pub const GetBatchJobExecutionOutput = struct {
    /// The identifier of the application.
    application_id: []const u8,

    /// The unique identifier of this batch job.
    batch_job_identifier: ?BatchJobIdentifier = null,

    /// The timestamp when the batch job execution ended.
    end_time: ?i64 = null,

    /// The unique identifier for this batch job execution.
    execution_id: []const u8,

    /// The unique identifier for this batch job.
    job_id: ?[]const u8 = null,

    /// The name of this batch job.
    job_name: ?[]const u8 = null,

    /// The step/procedure step information for the restart batch job operation.
    job_step_restart_marker: ?JobStepRestartMarker = null,

    /// The type of job.
    job_type: ?BatchJobType = null,

    /// The user for the job.
    job_user: ?[]const u8 = null,

    /// The batch job return code from either the Blu Age or Micro Focus runtime
    /// engines. For more
    /// information, see [Batch return
    /// codes](https://www.ibm.com/docs/en/was/8.5.5?topic=model-batch-return-codes)
    /// in the *IBM WebSphere Application Server*
    /// documentation.
    return_code: ?[]const u8 = null,

    /// The timestamp when the batch job execution started.
    start_time: i64,

    /// The status of the batch job execution.
    status: BatchJobExecutionStatus,

    /// The reason for the reported status.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .batch_job_identifier = "batchJobIdentifier",
        .end_time = "endTime",
        .execution_id = "executionId",
        .job_id = "jobId",
        .job_name = "jobName",
        .job_step_restart_marker = "jobStepRestartMarker",
        .job_type = "jobType",
        .job_user = "jobUser",
        .return_code = "returnCode",
        .start_time = "startTime",
        .status = "status",
        .status_reason = "statusReason",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetBatchJobExecutionInput, options: CallOptions) !GetBatchJobExecutionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "m2");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetBatchJobExecutionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("m2", "m2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/batch-job-executions/");
    try path_buf.appendSlice(allocator, input.execution_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetBatchJobExecutionOutput {
    var result: GetBatchJobExecutionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetBatchJobExecutionOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "ExecutionTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .execution_timeout_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
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

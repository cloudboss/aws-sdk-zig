const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const DefaultRunSetting = @import("default_run_setting.zig").DefaultRunSetting;
const RunSummary = @import("run_summary.zig").RunSummary;
const BatchStatus = @import("batch_status.zig").BatchStatus;
const SubmissionSummary = @import("submission_summary.zig").SubmissionSummary;

pub const GetBatchInput = struct {
    /// The identifier portion of the run batch ARN.
    batch_id: []const u8,

    pub const json_field_names = .{
        .batch_id = "batchId",
    };
};

pub const GetBatchOutput = struct {
    /// The unique ARN of the run batch.
    arn: ?[]const u8 = null,

    /// The timestamp when the batch was created.
    creation_time: ?i64 = null,

    /// The shared configuration applied to all runs in the batch. See
    /// `DefaultRunSetting`.
    default_run_setting: ?DefaultRunSetting = null,

    /// The timestamp when the batch transitioned to a `FAILED` status.
    failed_time: ?i64 = null,

    /// A description of the batch failure. Present only when status is `FAILED`.
    failure_reason: ?[]const u8 = null,

    /// The identifier portion of the run batch ARN.
    id: ?[]const u8 = null,

    /// The optional user-friendly name of the batch.
    name: ?[]const u8 = null,

    /// The timestamp when all run executions completed.
    processed_time: ?i64 = null,

    /// A summary of run execution states. Run execution counts are eventually
    /// consistent and may lag behind actual run states. Final counts are accurate
    /// once the batch reaches `PROCESSED` status. See `RunSummary`.
    run_summary: ?RunSummary = null,

    /// The current status of the run batch.
    status: ?BatchStatus = null,

    /// A summary of run submission outcomes. See `SubmissionSummary`.
    submission_summary: ?SubmissionSummary = null,

    /// The timestamp when all run submissions completed.
    submitted_time: ?i64 = null,

    /// AWS tags associated with the run batch.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The total number of runs in the batch.
    total_runs: ?i32 = null,

    /// The universally unique identifier (UUID) for the run batch.
    uuid: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_time = "creationTime",
        .default_run_setting = "defaultRunSetting",
        .failed_time = "failedTime",
        .failure_reason = "failureReason",
        .id = "id",
        .name = "name",
        .processed_time = "processedTime",
        .run_summary = "runSummary",
        .status = "status",
        .submission_summary = "submissionSummary",
        .submitted_time = "submittedTime",
        .tags = "tags",
        .total_runs = "totalRuns",
        .uuid = "uuid",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetBatchInput, options: CallOptions) !GetBatchOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "omics");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetBatchInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("omics", "Omics", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/runBatch/");
    try path_buf.appendSlice(allocator, input.batch_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetBatchOutput {
    var result: GetBatchOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetBatchOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotSupportedOperationException")) {
        return .{ .arena = arena, .kind = .{ .not_supported_operation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RangeNotSatisfiableException")) {
        return .{ .arena = arena, .kind = .{ .range_not_satisfiable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RequestTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .request_timeout_exception = .{
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

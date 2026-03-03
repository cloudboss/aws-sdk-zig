const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ModelCardExportJobSortBy = @import("model_card_export_job_sort_by.zig").ModelCardExportJobSortBy;
const ModelCardExportJobSortOrder = @import("model_card_export_job_sort_order.zig").ModelCardExportJobSortOrder;
const ModelCardExportJobStatus = @import("model_card_export_job_status.zig").ModelCardExportJobStatus;
const ModelCardExportJobSummary = @import("model_card_export_job_summary.zig").ModelCardExportJobSummary;

pub const ListModelCardExportJobsInput = struct {
    /// Only list model card export jobs that were created after the time specified.
    creation_time_after: ?i64 = null,

    /// Only list model card export jobs that were created before the time
    /// specified.
    creation_time_before: ?i64 = null,

    /// The maximum number of model card export jobs to list.
    max_results: ?i32 = null,

    /// Only list model card export jobs with names that contain the specified
    /// string.
    model_card_export_job_name_contains: ?[]const u8 = null,

    /// List export jobs for the model card with the specified name.
    model_card_name: []const u8,

    /// List export jobs for the model card with the specified version.
    model_card_version: ?i32 = null,

    /// If the response to a previous `ListModelCardExportJobs` request was
    /// truncated, the response includes a `NextToken`. To retrieve the next set of
    /// model card export jobs, use the token in the next request.
    next_token: ?[]const u8 = null,

    /// Sort model card export jobs by either name or creation time. Sorts by
    /// creation time by default.
    sort_by: ?ModelCardExportJobSortBy = null,

    /// Sort model card export jobs by ascending or descending order.
    sort_order: ?ModelCardExportJobSortOrder = null,

    /// Only list model card export jobs with the specified status.
    status_equals: ?ModelCardExportJobStatus = null,

    pub const json_field_names = .{
        .creation_time_after = "CreationTimeAfter",
        .creation_time_before = "CreationTimeBefore",
        .max_results = "MaxResults",
        .model_card_export_job_name_contains = "ModelCardExportJobNameContains",
        .model_card_name = "ModelCardName",
        .model_card_version = "ModelCardVersion",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
        .status_equals = "StatusEquals",
    };
};

pub const ListModelCardExportJobsOutput = struct {
    /// The summaries of the listed model card export jobs.
    model_card_export_job_summaries: ?[]const ModelCardExportJobSummary = null,

    /// If the response is truncated, SageMaker returns this token. To retrieve the
    /// next set of model card export jobs, use it in the subsequent request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .model_card_export_job_summaries = "ModelCardExportJobSummaries",
        .next_token = "NextToken",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListModelCardExportJobsInput, options: Options) !ListModelCardExportJobsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sagemaker");

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListModelCardExportJobsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker", "SageMaker", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListModelCardExportJobs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListModelCardExportJobsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListModelCardExportJobsOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUse")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found = .{
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

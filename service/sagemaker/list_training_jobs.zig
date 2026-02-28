const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const SortBy = @import("sort_by.zig").SortBy;
const SortOrder = @import("sort_order.zig").SortOrder;
const TrainingJobStatus = @import("training_job_status.zig").TrainingJobStatus;
const WarmPoolResourceStatus = @import("warm_pool_resource_status.zig").WarmPoolResourceStatus;
const TrainingJobSummary = @import("training_job_summary.zig").TrainingJobSummary;

pub const ListTrainingJobsInput = struct {
    /// A filter that returns only training jobs created after the specified time
    /// (timestamp).
    creation_time_after: ?i64 = null,

    /// A filter that returns only training jobs created before the specified time
    /// (timestamp).
    creation_time_before: ?i64 = null,

    /// A filter that returns only training jobs modified after the specified time
    /// (timestamp).
    last_modified_time_after: ?i64 = null,

    /// A filter that returns only training jobs modified before the specified time
    /// (timestamp).
    last_modified_time_before: ?i64 = null,

    /// The maximum number of training jobs to return in the response.
    max_results: ?i32 = null,

    /// A string in the training job name. This filter returns only training jobs
    /// whose name contains the specified string.
    name_contains: ?[]const u8 = null,

    /// If the result of the previous `ListTrainingJobs` request was truncated, the
    /// response includes a `NextToken`. To retrieve the next set of training jobs,
    /// use the token in the next request.
    next_token: ?[]const u8 = null,

    /// The field to sort results by. The default is `CreationTime`.
    sort_by: ?SortBy = null,

    /// The sort order for results. The default is `Ascending`.
    sort_order: ?SortOrder = null,

    /// A filter that retrieves only training jobs with a specific status.
    status_equals: ?TrainingJobStatus = null,

    /// The Amazon Resource Name (ARN); of the training plan to filter training jobs
    /// by. For more information about reserving GPU capacity for your SageMaker
    /// training jobs using Amazon SageMaker Training Plan, see `
    /// [CreateTrainingPlan](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateTrainingPlan.html) `.
    training_plan_arn_equals: ?[]const u8 = null,

    /// A filter that retrieves only training jobs with a specific warm pool status.
    warm_pool_status_equals: ?WarmPoolResourceStatus = null,

    pub const json_field_names = .{
        .creation_time_after = "CreationTimeAfter",
        .creation_time_before = "CreationTimeBefore",
        .last_modified_time_after = "LastModifiedTimeAfter",
        .last_modified_time_before = "LastModifiedTimeBefore",
        .max_results = "MaxResults",
        .name_contains = "NameContains",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
        .status_equals = "StatusEquals",
        .training_plan_arn_equals = "TrainingPlanArnEquals",
        .warm_pool_status_equals = "WarmPoolStatusEquals",
    };
};

pub const ListTrainingJobsOutput = struct {
    /// If the response is truncated, SageMaker returns this token. To retrieve the
    /// next set of training jobs, use it in the subsequent request.
    next_token: ?[]const u8 = null,

    /// An array of `TrainingJobSummary` objects, each listing a training job.
    training_job_summaries: ?[]const TrainingJobSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .training_job_summaries = "TrainingJobSummaries",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTrainingJobsInput, options: Options) !ListTrainingJobsOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: ListTrainingJobsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker", "SageMaker", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "SageMaker.ListTrainingJobs");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ListTrainingJobsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListTrainingJobsOutput, body, alloc);
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

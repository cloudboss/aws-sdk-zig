const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const HyperParameterTuningJobSortByOptions = @import("hyper_parameter_tuning_job_sort_by_options.zig").HyperParameterTuningJobSortByOptions;
const SortOrder = @import("sort_order.zig").SortOrder;
const HyperParameterTuningJobStatus = @import("hyper_parameter_tuning_job_status.zig").HyperParameterTuningJobStatus;
const HyperParameterTuningJobSummary = @import("hyper_parameter_tuning_job_summary.zig").HyperParameterTuningJobSummary;

pub const ListHyperParameterTuningJobsInput = struct {
    /// A filter that returns only tuning jobs that were created after the specified
    /// time.
    creation_time_after: ?i64 = null,

    /// A filter that returns only tuning jobs that were created before the
    /// specified time.
    creation_time_before: ?i64 = null,

    /// A filter that returns only tuning jobs that were modified after the
    /// specified time.
    last_modified_time_after: ?i64 = null,

    /// A filter that returns only tuning jobs that were modified before the
    /// specified time.
    last_modified_time_before: ?i64 = null,

    /// The maximum number of tuning jobs to return. The default value is 10.
    max_results: ?i32 = null,

    /// A string in the tuning job name. This filter returns only tuning jobs whose
    /// name contains the specified string.
    name_contains: ?[]const u8 = null,

    /// If the result of the previous `ListHyperParameterTuningJobs` request was
    /// truncated, the response includes a `NextToken`. To retrieve the next set of
    /// tuning jobs, use the token in the next request.
    next_token: ?[]const u8 = null,

    /// The field to sort results by. The default is `Name`.
    sort_by: ?HyperParameterTuningJobSortByOptions = null,

    /// The sort order for results. The default is `Ascending`.
    sort_order: ?SortOrder = null,

    /// A filter that returns only tuning jobs with the specified status.
    status_equals: ?HyperParameterTuningJobStatus = null,

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
    };
};

pub const ListHyperParameterTuningJobsOutput = struct {
    /// A list of
    /// [HyperParameterTuningJobSummary](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_HyperParameterTuningJobSummary.html) objects that describe the tuning jobs that the `ListHyperParameterTuningJobs` request returned.
    hyper_parameter_tuning_job_summaries: ?[]const HyperParameterTuningJobSummary = null,

    /// If the result of this `ListHyperParameterTuningJobs` request was truncated,
    /// the response includes a `NextToken`. To retrieve the next set of tuning
    /// jobs, use the token in the next request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .hyper_parameter_tuning_job_summaries = "HyperParameterTuningJobSummaries",
        .next_token = "NextToken",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListHyperParameterTuningJobsInput, options: Options) !ListHyperParameterTuningJobsOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ListHyperParameterTuningJobsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "SageMaker.ListHyperParameterTuningJobs");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ListHyperParameterTuningJobsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListHyperParameterTuningJobsOutput, body, alloc);
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

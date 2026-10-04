const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListOptimizationJobsSortBy = @import("list_optimization_jobs_sort_by.zig").ListOptimizationJobsSortBy;
const SortOrder = @import("sort_order.zig").SortOrder;
const OptimizationJobStatus = @import("optimization_job_status.zig").OptimizationJobStatus;
const OptimizationJobSummary = @import("optimization_job_summary.zig").OptimizationJobSummary;

pub const ListOptimizationJobsInput = struct {
    /// Filters the results to only those optimization jobs that were created after
    /// the specified time.
    creation_time_after: ?i64 = null,

    /// Filters the results to only those optimization jobs that were created before
    /// the specified time.
    creation_time_before: ?i64 = null,

    /// Filters the results to only those optimization jobs that were updated after
    /// the specified time.
    last_modified_time_after: ?i64 = null,

    /// Filters the results to only those optimization jobs that were updated before
    /// the specified time.
    last_modified_time_before: ?i64 = null,

    /// The maximum number of optimization jobs to return in the response. The
    /// default is 50.
    max_results: ?i32 = null,

    /// Filters the results to only those optimization jobs with a name that
    /// contains the specified string.
    name_contains: ?[]const u8 = null,

    /// A token that you use to get the next set of results following a truncated
    /// response. If the response to the previous request was truncated, that
    /// response provides the value for this token.
    next_token: ?[]const u8 = null,

    /// Filters the results to only those optimization jobs that apply the specified
    /// optimization techniques. You can specify either `Quantization` or
    /// `Compilation`.
    optimization_contains: ?[]const u8 = null,

    /// The field by which to sort the optimization jobs in the response. The
    /// default is `CreationTime`
    sort_by: ?ListOptimizationJobsSortBy = null,

    /// The sort order for results. The default is `Ascending`
    sort_order: ?SortOrder = null,

    /// Filters the results to only those optimization jobs with the specified
    /// status.
    status_equals: ?OptimizationJobStatus = null,

    pub const json_field_names = .{
        .creation_time_after = "CreationTimeAfter",
        .creation_time_before = "CreationTimeBefore",
        .last_modified_time_after = "LastModifiedTimeAfter",
        .last_modified_time_before = "LastModifiedTimeBefore",
        .max_results = "MaxResults",
        .name_contains = "NameContains",
        .next_token = "NextToken",
        .optimization_contains = "OptimizationContains",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
        .status_equals = "StatusEquals",
    };
};

pub const ListOptimizationJobsOutput = struct {
    /// The token to use in a subsequent request to get the next set of results
    /// following a truncated response.
    next_token: ?[]const u8 = null,

    /// A list of optimization jobs and their properties that matches any of the
    /// filters you specified in the request.
    optimization_job_summaries: ?[]const OptimizationJobSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .optimization_job_summaries = "OptimizationJobSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListOptimizationJobsInput, options: CallOptions) !ListOptimizationJobsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ListOptimizationJobsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListOptimizationJobs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListOptimizationJobsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListOptimizationJobsOutput, body, allocator);
}

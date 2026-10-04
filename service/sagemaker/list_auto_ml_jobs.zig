const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutoMLSortBy = @import("auto_ml_sort_by.zig").AutoMLSortBy;
const AutoMLSortOrder = @import("auto_ml_sort_order.zig").AutoMLSortOrder;
const AutoMLJobStatus = @import("auto_ml_job_status.zig").AutoMLJobStatus;
const AutoMLJobSummary = @import("auto_ml_job_summary.zig").AutoMLJobSummary;

pub const ListAutoMLJobsInput = struct {
    /// Request a list of jobs, using a filter for time.
    creation_time_after: ?i64 = null,

    /// Request a list of jobs, using a filter for time.
    creation_time_before: ?i64 = null,

    /// Request a list of jobs, using a filter for time.
    last_modified_time_after: ?i64 = null,

    /// Request a list of jobs, using a filter for time.
    last_modified_time_before: ?i64 = null,

    /// Request a list of jobs up to a specified limit.
    max_results: ?i32 = null,

    /// Request a list of jobs, using a search filter for name.
    name_contains: ?[]const u8 = null,

    /// If the previous response was truncated, you receive this token. Use it in
    /// your next request to receive the next set of results.
    next_token: ?[]const u8 = null,

    /// The parameter by which to sort the results. The default is `Name`.
    sort_by: ?AutoMLSortBy = null,

    /// The sort order for the results. The default is `Descending`.
    sort_order: ?AutoMLSortOrder = null,

    /// Request a list of jobs, using a filter for status.
    status_equals: ?AutoMLJobStatus = null,

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

pub const ListAutoMLJobsOutput = struct {
    /// Returns a summary list of jobs.
    auto_ml_job_summaries: ?[]const AutoMLJobSummary = null,

    /// If the previous response was truncated, you receive this token. Use it in
    /// your next request to receive the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .auto_ml_job_summaries = "AutoMLJobSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAutoMLJobsInput, options: CallOptions) !ListAutoMLJobsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAutoMLJobsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListAutoMLJobs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAutoMLJobsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListAutoMLJobsOutput, body, allocator);
}

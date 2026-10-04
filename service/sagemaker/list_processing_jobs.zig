const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SortBy = @import("sort_by.zig").SortBy;
const SortOrder = @import("sort_order.zig").SortOrder;
const ProcessingJobStatus = @import("processing_job_status.zig").ProcessingJobStatus;
const ProcessingJobSummary = @import("processing_job_summary.zig").ProcessingJobSummary;

pub const ListProcessingJobsInput = struct {
    /// A filter that returns only processing jobs created after the specified time.
    creation_time_after: ?i64 = null,

    /// A filter that returns only processing jobs created after the specified time.
    creation_time_before: ?i64 = null,

    /// A filter that returns only processing jobs modified after the specified
    /// time.
    last_modified_time_after: ?i64 = null,

    /// A filter that returns only processing jobs modified before the specified
    /// time.
    last_modified_time_before: ?i64 = null,

    /// The maximum number of processing jobs to return in the response.
    max_results: ?i32 = null,

    /// A string in the processing job name. This filter returns only processing
    /// jobs whose name contains the specified string.
    name_contains: ?[]const u8 = null,

    /// If the result of the previous `ListProcessingJobs` request was truncated,
    /// the response includes a `NextToken`. To retrieve the next set of processing
    /// jobs, use the token in the next request.
    next_token: ?[]const u8 = null,

    /// The field to sort results by. The default is `CreationTime`.
    sort_by: ?SortBy = null,

    /// The sort order for results. The default is `Ascending`.
    sort_order: ?SortOrder = null,

    /// A filter that retrieves only processing jobs with a specific status.
    status_equals: ?ProcessingJobStatus = null,

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

pub const ListProcessingJobsOutput = struct {
    /// If the response is truncated, Amazon SageMaker returns this token. To
    /// retrieve the next set of processing jobs, use it in the subsequent request.
    next_token: ?[]const u8 = null,

    /// An array of `ProcessingJobSummary` objects, each listing a processing job.
    processing_job_summaries: ?[]const ProcessingJobSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .processing_job_summaries = "ProcessingJobSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListProcessingJobsInput, options: CallOptions) !ListProcessingJobsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListProcessingJobsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListProcessingJobs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListProcessingJobsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListProcessingJobsOutput, body, allocator);
}

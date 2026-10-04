const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListEdgePackagingJobsSortBy = @import("list_edge_packaging_jobs_sort_by.zig").ListEdgePackagingJobsSortBy;
const SortOrder = @import("sort_order.zig").SortOrder;
const EdgePackagingJobStatus = @import("edge_packaging_job_status.zig").EdgePackagingJobStatus;
const EdgePackagingJobSummary = @import("edge_packaging_job_summary.zig").EdgePackagingJobSummary;

pub const ListEdgePackagingJobsInput = struct {
    /// Select jobs where the job was created after specified time.
    creation_time_after: ?i64 = null,

    /// Select jobs where the job was created before specified time.
    creation_time_before: ?i64 = null,

    /// Select jobs where the job was updated after specified time.
    last_modified_time_after: ?i64 = null,

    /// Select jobs where the job was updated before specified time.
    last_modified_time_before: ?i64 = null,

    /// Maximum number of results to select.
    max_results: ?i32 = null,

    /// Filter for jobs where the model name contains this string.
    model_name_contains: ?[]const u8 = null,

    /// Filter for jobs containing this name in their packaging job name.
    name_contains: ?[]const u8 = null,

    /// The response from the last list when returning a list large enough to need
    /// tokening.
    next_token: ?[]const u8 = null,

    /// Use to specify what column to sort by.
    sort_by: ?ListEdgePackagingJobsSortBy = null,

    /// What direction to sort by.
    sort_order: ?SortOrder = null,

    /// The job status to filter for.
    status_equals: ?EdgePackagingJobStatus = null,

    pub const json_field_names = .{
        .creation_time_after = "CreationTimeAfter",
        .creation_time_before = "CreationTimeBefore",
        .last_modified_time_after = "LastModifiedTimeAfter",
        .last_modified_time_before = "LastModifiedTimeBefore",
        .max_results = "MaxResults",
        .model_name_contains = "ModelNameContains",
        .name_contains = "NameContains",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
        .status_equals = "StatusEquals",
    };
};

pub const ListEdgePackagingJobsOutput = struct {
    /// Summaries of edge packaging jobs.
    edge_packaging_job_summaries: ?[]const EdgePackagingJobSummary = null,

    /// Token to use when calling the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .edge_packaging_job_summaries = "EdgePackagingJobSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListEdgePackagingJobsInput, options: CallOptions) !ListEdgePackagingJobsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListEdgePackagingJobsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListEdgePackagingJobs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListEdgePackagingJobsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListEdgePackagingJobsOutput, body, allocator);
}

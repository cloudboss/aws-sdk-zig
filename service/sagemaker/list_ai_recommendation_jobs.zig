const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListAIRecommendationJobsSortBy = @import("list_ai_recommendation_jobs_sort_by.zig").ListAIRecommendationJobsSortBy;
const SortOrder = @import("sort_order.zig").SortOrder;
const AIRecommendationJobStatus = @import("ai_recommendation_job_status.zig").AIRecommendationJobStatus;
const AIRecommendationJobSummary = @import("ai_recommendation_job_summary.zig").AIRecommendationJobSummary;

pub const ListAIRecommendationJobsInput = struct {
    /// A filter that returns only jobs created after the specified time.
    creation_time_after: ?i64 = null,

    /// A filter that returns only jobs created before the specified time.
    creation_time_before: ?i64 = null,

    /// The maximum number of recommendation jobs to return in the response.
    max_results: ?i32 = null,

    /// A string in the job name. This filter returns only jobs whose name contains
    /// the specified string.
    name_contains: ?[]const u8 = null,

    /// If the previous call to `ListAIRecommendationJobs` didn't return the full
    /// set of jobs, the call returns a token for getting the next set.
    next_token: ?[]const u8 = null,

    /// The field to sort results by. The default is `CreationTime`.
    sort_by: ?ListAIRecommendationJobsSortBy = null,

    /// The sort order for results. The default is `Descending`.
    sort_order: ?SortOrder = null,

    /// A filter that returns only recommendation jobs with the specified status.
    status_equals: ?AIRecommendationJobStatus = null,

    pub const json_field_names = .{
        .creation_time_after = "CreationTimeAfter",
        .creation_time_before = "CreationTimeBefore",
        .max_results = "MaxResults",
        .name_contains = "NameContains",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
        .status_equals = "StatusEquals",
    };
};

pub const ListAIRecommendationJobsOutput = struct {
    /// An array of `AIRecommendationJobSummary` objects, one for each
    /// recommendation job that matches the specified filters.
    ai_recommendation_jobs: ?[]const AIRecommendationJobSummary = null,

    /// If the response is truncated, Amazon SageMaker AI returns this token. To
    /// retrieve the next set of jobs, use it in the subsequent request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .ai_recommendation_jobs = "AIRecommendationJobs",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAIRecommendationJobsInput, options: CallOptions) !ListAIRecommendationJobsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAIRecommendationJobsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListAIRecommendationJobs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAIRecommendationJobsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListAIRecommendationJobsOutput, body, allocator);
}

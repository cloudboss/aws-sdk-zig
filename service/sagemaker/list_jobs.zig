const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const JobCategory = @import("job_category.zig").JobCategory;
const SortBy = @import("sort_by.zig").SortBy;
const SortOrder = @import("sort_order.zig").SortOrder;
const JobStatus = @import("job_status.zig").JobStatus;
const JobSummary = @import("job_summary.zig").JobSummary;

pub const ListJobsInput = struct {
    /// A filter that returns only jobs created after the specified time.
    creation_time_after: ?i64 = null,

    /// A filter that returns only jobs created before the specified time.
    creation_time_before: ?i64 = null,

    /// The category of jobs to list.
    job_category: JobCategory,

    /// A filter that returns only jobs modified after the specified time.
    last_modified_time_after: ?i64 = null,

    /// A filter that returns only jobs modified before the specified time.
    last_modified_time_before: ?i64 = null,

    /// The maximum number of jobs to return in the response. The default value is
    /// 50.
    max_results: ?i32 = null,

    /// A string in the job name to filter results. Only jobs whose name contains
    /// the specified string are returned.
    name_contains: ?[]const u8 = null,

    /// If the previous response was truncated, this token retrieves the next set of
    /// results.
    next_token: ?[]const u8 = null,

    /// The field to sort results by.
    sort_by: ?SortBy = null,

    /// The sort order for results. Valid values are `Ascending` and `Descending`.
    sort_order: ?SortOrder = null,

    /// A filter that returns only jobs with the specified status.
    status_equals: ?JobStatus = null,

    pub const json_field_names = .{
        .creation_time_after = "CreationTimeAfter",
        .creation_time_before = "CreationTimeBefore",
        .job_category = "JobCategory",
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

pub const ListJobsOutput = struct {
    /// An array of `JobSummary` objects that provide summary information about the
    /// jobs.
    job_summaries: ?[]const JobSummary = null,

    /// If the response is truncated, this token retrieves the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .job_summaries = "JobSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListJobsInput, options: CallOptions) !ListJobsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListJobsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListJobs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListJobsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListJobsOutput, body, allocator);
}

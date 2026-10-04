const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTrainingJobsInput, options: CallOptions) !ListTrainingJobsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTrainingJobsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListTrainingJobs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTrainingJobsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListTrainingJobsOutput, body, allocator);
}

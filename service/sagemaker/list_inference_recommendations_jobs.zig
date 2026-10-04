const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListInferenceRecommendationsJobsSortBy = @import("list_inference_recommendations_jobs_sort_by.zig").ListInferenceRecommendationsJobsSortBy;
const SortOrder = @import("sort_order.zig").SortOrder;
const RecommendationJobStatus = @import("recommendation_job_status.zig").RecommendationJobStatus;
const InferenceRecommendationsJob = @import("inference_recommendations_job.zig").InferenceRecommendationsJob;

pub const ListInferenceRecommendationsJobsInput = struct {
    /// A filter that returns only jobs created after the specified time
    /// (timestamp).
    creation_time_after: ?i64 = null,

    /// A filter that returns only jobs created before the specified time
    /// (timestamp).
    creation_time_before: ?i64 = null,

    /// A filter that returns only jobs that were last modified after the specified
    /// time (timestamp).
    last_modified_time_after: ?i64 = null,

    /// A filter that returns only jobs that were last modified before the specified
    /// time (timestamp).
    last_modified_time_before: ?i64 = null,

    /// The maximum number of recommendations to return in the response.
    max_results: ?i32 = null,

    /// A filter that returns only jobs that were created for this model.
    model_name_equals: ?[]const u8 = null,

    /// A filter that returns only jobs that were created for this versioned model
    /// package.
    model_package_version_arn_equals: ?[]const u8 = null,

    /// A string in the job name. This filter returns only recommendations whose
    /// name contains the specified string.
    name_contains: ?[]const u8 = null,

    /// If the response to a previous `ListInferenceRecommendationsJobsRequest`
    /// request was truncated, the response includes a `NextToken`. To retrieve the
    /// next set of recommendations, use the token in the next request.
    next_token: ?[]const u8 = null,

    /// The parameter by which to sort the results.
    sort_by: ?ListInferenceRecommendationsJobsSortBy = null,

    /// The sort order for the results.
    sort_order: ?SortOrder = null,

    /// A filter that retrieves only inference recommendations jobs with a specific
    /// status.
    status_equals: ?RecommendationJobStatus = null,

    pub const json_field_names = .{
        .creation_time_after = "CreationTimeAfter",
        .creation_time_before = "CreationTimeBefore",
        .last_modified_time_after = "LastModifiedTimeAfter",
        .last_modified_time_before = "LastModifiedTimeBefore",
        .max_results = "MaxResults",
        .model_name_equals = "ModelNameEquals",
        .model_package_version_arn_equals = "ModelPackageVersionArnEquals",
        .name_contains = "NameContains",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
        .status_equals = "StatusEquals",
    };
};

pub const ListInferenceRecommendationsJobsOutput = struct {
    /// The recommendations created from the Amazon SageMaker Inference Recommender
    /// job.
    inference_recommendations_jobs: ?[]const InferenceRecommendationsJob = null,

    /// A token for getting the next set of recommendations, if there are any.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .inference_recommendations_jobs = "InferenceRecommendationsJobs",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListInferenceRecommendationsJobsInput, options: CallOptions) !ListInferenceRecommendationsJobsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListInferenceRecommendationsJobsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListInferenceRecommendationsJobs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListInferenceRecommendationsJobsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListInferenceRecommendationsJobsOutput, body, allocator);
}

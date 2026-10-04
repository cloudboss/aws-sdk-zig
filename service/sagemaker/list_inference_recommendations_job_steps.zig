const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RecommendationJobStatus = @import("recommendation_job_status.zig").RecommendationJobStatus;
const RecommendationStepType = @import("recommendation_step_type.zig").RecommendationStepType;
const InferenceRecommendationsJobStep = @import("inference_recommendations_job_step.zig").InferenceRecommendationsJobStep;

pub const ListInferenceRecommendationsJobStepsInput = struct {
    /// The name for the Inference Recommender job.
    job_name: []const u8,

    /// The maximum number of results to return.
    max_results: ?i32 = null,

    /// A token that you can specify to return more results from the list. Specify
    /// this field if you have a token that was returned from a previous request.
    next_token: ?[]const u8 = null,

    /// A filter to return benchmarks of a specified status. If this field is left
    /// empty, then all benchmarks are returned.
    status: ?RecommendationJobStatus = null,

    /// A filter to return details about the specified type of subtask.
    ///
    /// `BENCHMARK`: Evaluate the performance of your model on different instance
    /// types.
    step_type: ?RecommendationStepType = null,

    pub const json_field_names = .{
        .job_name = "JobName",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .status = "Status",
        .step_type = "StepType",
    };
};

pub const ListInferenceRecommendationsJobStepsOutput = struct {
    /// A token that you can specify in your next request to return more results
    /// from the list.
    next_token: ?[]const u8 = null,

    /// A list of all subtask details in Inference Recommender.
    steps: ?[]const InferenceRecommendationsJobStep = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .steps = "Steps",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListInferenceRecommendationsJobStepsInput, options: CallOptions) !ListInferenceRecommendationsJobStepsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListInferenceRecommendationsJobStepsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListInferenceRecommendationsJobSteps");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListInferenceRecommendationsJobStepsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListInferenceRecommendationsJobStepsOutput, body, allocator);
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SortInferenceExperimentsBy = @import("sort_inference_experiments_by.zig").SortInferenceExperimentsBy;
const SortOrder = @import("sort_order.zig").SortOrder;
const InferenceExperimentStatus = @import("inference_experiment_status.zig").InferenceExperimentStatus;
const InferenceExperimentType = @import("inference_experiment_type.zig").InferenceExperimentType;
const InferenceExperimentSummary = @import("inference_experiment_summary.zig").InferenceExperimentSummary;

pub const ListInferenceExperimentsInput = struct {
    /// Selects inference experiments which were created after this timestamp.
    creation_time_after: ?i64 = null,

    /// Selects inference experiments which were created before this timestamp.
    creation_time_before: ?i64 = null,

    /// Selects inference experiments which were last modified after this timestamp.
    last_modified_time_after: ?i64 = null,

    /// Selects inference experiments which were last modified before this
    /// timestamp.
    last_modified_time_before: ?i64 = null,

    /// The maximum number of results to select.
    max_results: ?i32 = null,

    /// Selects inference experiments whose names contain this name.
    name_contains: ?[]const u8 = null,

    /// The response from the last list when returning a list large enough to need
    /// tokening.
    next_token: ?[]const u8 = null,

    /// The column by which to sort the listed inference experiments.
    sort_by: ?SortInferenceExperimentsBy = null,

    /// The direction of sorting (ascending or descending).
    sort_order: ?SortOrder = null,

    /// Selects inference experiments which are in this status. For the possible
    /// statuses, see
    /// [DescribeInferenceExperiment](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_DescribeInferenceExperiment.html).
    status_equals: ?InferenceExperimentStatus = null,

    /// Selects inference experiments of this type. For the possible types of
    /// inference experiments, see
    /// [CreateInferenceExperiment](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateInferenceExperiment.html).
    type: ?InferenceExperimentType = null,

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
        .type = "Type",
    };
};

pub const ListInferenceExperimentsOutput = struct {
    /// List of inference experiments.
    inference_experiments: ?[]const InferenceExperimentSummary = null,

    /// The token to use when calling the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .inference_experiments = "InferenceExperiments",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListInferenceExperimentsInput, options: CallOptions) !ListInferenceExperimentsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListInferenceExperimentsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListInferenceExperiments");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListInferenceExperimentsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListInferenceExperimentsOutput, body, allocator);
}

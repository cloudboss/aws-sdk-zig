const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TrainingJobSortByOptions = @import("training_job_sort_by_options.zig").TrainingJobSortByOptions;
const SortOrder = @import("sort_order.zig").SortOrder;
const TrainingJobStatus = @import("training_job_status.zig").TrainingJobStatus;
const HyperParameterTrainingJobSummary = @import("hyper_parameter_training_job_summary.zig").HyperParameterTrainingJobSummary;

pub const ListTrainingJobsForHyperParameterTuningJobInput = struct {
    /// The name of the tuning job whose training jobs you want to list.
    hyper_parameter_tuning_job_name: []const u8,

    /// The maximum number of training jobs to return. The default value is 10.
    max_results: ?i32 = null,

    /// If the result of the previous `ListTrainingJobsForHyperParameterTuningJob`
    /// request was truncated, the response includes a `NextToken`. To retrieve the
    /// next set of training jobs, use the token in the next request.
    next_token: ?[]const u8 = null,

    /// The field to sort results by. The default is `Name`.
    ///
    /// If the value of this field is `FinalObjectiveMetricValue`, any training jobs
    /// that did not return an objective metric are not listed.
    sort_by: ?TrainingJobSortByOptions = null,

    /// The sort order for results. The default is `Ascending`.
    sort_order: ?SortOrder = null,

    /// A filter that returns only training jobs with the specified status.
    status_equals: ?TrainingJobStatus = null,

    pub const json_field_names = .{
        .hyper_parameter_tuning_job_name = "HyperParameterTuningJobName",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
        .status_equals = "StatusEquals",
    };
};

pub const ListTrainingJobsForHyperParameterTuningJobOutput = struct {
    /// If the result of this `ListTrainingJobsForHyperParameterTuningJob` request
    /// was truncated, the response includes a `NextToken`. To retrieve the next set
    /// of training jobs, use the token in the next request.
    next_token: ?[]const u8 = null,

    /// A list of
    /// [TrainingJobSummary](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_TrainingJobSummary.html) objects that describe the training jobs that the `ListTrainingJobsForHyperParameterTuningJob` request returned.
    training_job_summaries: ?[]const HyperParameterTrainingJobSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .training_job_summaries = "TrainingJobSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTrainingJobsForHyperParameterTuningJobInput, options: CallOptions) !ListTrainingJobsForHyperParameterTuningJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTrainingJobsForHyperParameterTuningJobInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListTrainingJobsForHyperParameterTuningJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTrainingJobsForHyperParameterTuningJobOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListTrainingJobsForHyperParameterTuningJobOutput, body, allocator);
}

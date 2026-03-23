const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
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
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sagemaker");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ListTrainingJobsForHyperParameterTuningJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUse")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}

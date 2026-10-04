const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TrainingPlanFilter = @import("training_plan_filter.zig").TrainingPlanFilter;
const TrainingPlanSortBy = @import("training_plan_sort_by.zig").TrainingPlanSortBy;
const TrainingPlanSortOrder = @import("training_plan_sort_order.zig").TrainingPlanSortOrder;
const TrainingPlanSummary = @import("training_plan_summary.zig").TrainingPlanSummary;

pub const ListTrainingPlansInput = struct {
    /// Additional filters to apply to the list of training plans.
    filters: ?[]const TrainingPlanFilter = null,

    /// The maximum number of results to return in the response.
    max_results: ?i32 = null,

    /// A token to continue pagination if more results are available.
    next_token: ?[]const u8 = null,

    /// The training plan field to sort the results by (e.g., StartTime, Status).
    sort_by: ?TrainingPlanSortBy = null,

    /// The order to sort the results (Ascending or Descending).
    sort_order: ?TrainingPlanSortOrder = null,

    /// Filter to list only training plans with an actual start time after this
    /// date.
    start_time_after: ?i64 = null,

    /// Filter to list only training plans with an actual start time before this
    /// date.
    start_time_before: ?i64 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
        .start_time_after = "StartTimeAfter",
        .start_time_before = "StartTimeBefore",
    };
};

pub const ListTrainingPlansOutput = struct {
    /// A token to continue pagination if more results are available.
    next_token: ?[]const u8 = null,

    /// A list of summary information for the training plans.
    training_plan_summaries: ?[]const TrainingPlanSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .training_plan_summaries = "TrainingPlanSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTrainingPlansInput, options: CallOptions) !ListTrainingPlansOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTrainingPlansInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListTrainingPlans");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTrainingPlansOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListTrainingPlansOutput, body, allocator);
}

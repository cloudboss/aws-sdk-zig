const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SortTrialsBy = @import("sort_trials_by.zig").SortTrialsBy;
const SortOrder = @import("sort_order.zig").SortOrder;
const TrialSummary = @import("trial_summary.zig").TrialSummary;

pub const ListTrialsInput = struct {
    /// A filter that returns only trials created after the specified time.
    created_after: ?i64 = null,

    /// A filter that returns only trials created before the specified time.
    created_before: ?i64 = null,

    /// A filter that returns only trials that are part of the specified experiment.
    experiment_name: ?[]const u8 = null,

    /// The maximum number of trials to return in the response. The default value is
    /// 10.
    max_results: ?i32 = null,

    /// If the previous call to `ListTrials` didn't return the full set of trials,
    /// the call returns a token for getting the next set of trials.
    next_token: ?[]const u8 = null,

    /// The property used to sort results. The default value is `CreationTime`.
    sort_by: ?SortTrialsBy = null,

    /// The sort order. The default value is `Descending`.
    sort_order: ?SortOrder = null,

    /// A filter that returns only trials that are associated with the specified
    /// trial component.
    trial_component_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_after = "CreatedAfter",
        .created_before = "CreatedBefore",
        .experiment_name = "ExperimentName",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
        .trial_component_name = "TrialComponentName",
    };
};

pub const ListTrialsOutput = struct {
    /// A token for getting the next set of trials, if there are any.
    next_token: ?[]const u8 = null,

    /// A list of the summaries of your trials.
    trial_summaries: ?[]const TrialSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .trial_summaries = "TrialSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTrialsInput, options: CallOptions) !ListTrialsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTrialsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListTrials");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTrialsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListTrialsOutput, body, allocator);
}

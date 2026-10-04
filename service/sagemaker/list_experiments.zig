const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SortExperimentsBy = @import("sort_experiments_by.zig").SortExperimentsBy;
const SortOrder = @import("sort_order.zig").SortOrder;
const ExperimentSummary = @import("experiment_summary.zig").ExperimentSummary;

pub const ListExperimentsInput = struct {
    /// A filter that returns only experiments created after the specified time.
    created_after: ?i64 = null,

    /// A filter that returns only experiments created before the specified time.
    created_before: ?i64 = null,

    /// The maximum number of experiments to return in the response. The default
    /// value is 10.
    max_results: ?i32 = null,

    /// If the previous call to `ListExperiments` didn't return the full set of
    /// experiments, the call returns a token for getting the next set of
    /// experiments.
    next_token: ?[]const u8 = null,

    /// The property used to sort results. The default value is `CreationTime`.
    sort_by: ?SortExperimentsBy = null,

    /// The sort order. The default value is `Descending`.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .created_after = "CreatedAfter",
        .created_before = "CreatedBefore",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};

pub const ListExperimentsOutput = struct {
    /// A list of the summaries of your experiments.
    experiment_summaries: ?[]const ExperimentSummary = null,

    /// A token for getting the next set of experiments, if there are any.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .experiment_summaries = "ExperimentSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListExperimentsInput, options: CallOptions) !ListExperimentsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListExperimentsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListExperiments");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListExperimentsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListExperimentsOutput, body, allocator);
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SortTrialComponentsBy = @import("sort_trial_components_by.zig").SortTrialComponentsBy;
const SortOrder = @import("sort_order.zig").SortOrder;
const TrialComponentSummary = @import("trial_component_summary.zig").TrialComponentSummary;

pub const ListTrialComponentsInput = struct {
    /// A filter that returns only components created after the specified time.
    created_after: ?i64 = null,

    /// A filter that returns only components created before the specified time.
    created_before: ?i64 = null,

    /// A filter that returns only components that are part of the specified
    /// experiment. If you specify `ExperimentName`, you can't filter by `SourceArn`
    /// or `TrialName`.
    experiment_name: ?[]const u8 = null,

    /// The maximum number of components to return in the response. The default
    /// value is 10.
    max_results: ?i32 = null,

    /// If the previous call to `ListTrialComponents` didn't return the full set of
    /// components, the call returns a token for getting the next set of components.
    next_token: ?[]const u8 = null,

    /// The property used to sort results. The default value is `CreationTime`.
    sort_by: ?SortTrialComponentsBy = null,

    /// The sort order. The default value is `Descending`.
    sort_order: ?SortOrder = null,

    /// A filter that returns only components that have the specified source Amazon
    /// Resource Name (ARN). If you specify `SourceArn`, you can't filter by
    /// `ExperimentName` or `TrialName`.
    source_arn: ?[]const u8 = null,

    /// A filter that returns only components that are part of the specified trial.
    /// If you specify `TrialName`, you can't filter by `ExperimentName` or
    /// `SourceArn`.
    trial_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_after = "CreatedAfter",
        .created_before = "CreatedBefore",
        .experiment_name = "ExperimentName",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
        .source_arn = "SourceArn",
        .trial_name = "TrialName",
    };
};

pub const ListTrialComponentsOutput = struct {
    /// A token for getting the next set of components, if there are any.
    next_token: ?[]const u8 = null,

    /// A list of the summaries of your trial components.
    trial_component_summaries: ?[]const TrialComponentSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .trial_component_summaries = "TrialComponentSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTrialComponentsInput, options: CallOptions) !ListTrialComponentsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTrialComponentsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListTrialComponents");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTrialComponentsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListTrialComponentsOutput, body, allocator);
}

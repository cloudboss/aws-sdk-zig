const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SortOrder = @import("sort_order.zig").SortOrder;
const FlowDefinitionSummary = @import("flow_definition_summary.zig").FlowDefinitionSummary;

pub const ListFlowDefinitionsInput = struct {
    /// A filter that returns only flow definitions with a creation time greater
    /// than or equal to the specified timestamp.
    creation_time_after: ?i64 = null,

    /// A filter that returns only flow definitions that were created before the
    /// specified timestamp.
    creation_time_before: ?i64 = null,

    /// The total number of items to return. If the total number of available items
    /// is more than the value specified in `MaxResults`, then a `NextToken` will be
    /// provided in the output that you can use to resume pagination.
    max_results: ?i32 = null,

    /// A token to resume pagination.
    next_token: ?[]const u8 = null,

    /// An optional value that specifies whether you want the results sorted in
    /// `Ascending` or `Descending` order.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .creation_time_after = "CreationTimeAfter",
        .creation_time_before = "CreationTimeBefore",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .sort_order = "SortOrder",
    };
};

pub const ListFlowDefinitionsOutput = struct {
    /// An array of objects describing the flow definitions.
    flow_definition_summaries: ?[]const FlowDefinitionSummary = null,

    /// A token to resume pagination.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .flow_definition_summaries = "FlowDefinitionSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListFlowDefinitionsInput, options: CallOptions) !ListFlowDefinitionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListFlowDefinitionsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListFlowDefinitions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListFlowDefinitionsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListFlowDefinitionsOutput, body, allocator);
}

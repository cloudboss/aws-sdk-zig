const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EndpointConfigSortKey = @import("endpoint_config_sort_key.zig").EndpointConfigSortKey;
const OrderKey = @import("order_key.zig").OrderKey;
const EndpointConfigSummary = @import("endpoint_config_summary.zig").EndpointConfigSummary;

pub const ListEndpointConfigsInput = struct {
    /// A filter that returns only endpoint configurations with a creation time
    /// greater than or equal to the specified time (timestamp).
    creation_time_after: ?i64 = null,

    /// A filter that returns only endpoint configurations created before the
    /// specified time (timestamp).
    creation_time_before: ?i64 = null,

    /// The maximum number of training jobs to return in the response.
    max_results: ?i32 = null,

    /// A string in the endpoint configuration name. This filter returns only
    /// endpoint configurations whose name contains the specified string.
    name_contains: ?[]const u8 = null,

    /// If the result of the previous `ListEndpointConfig` request was truncated,
    /// the response includes a `NextToken`. To retrieve the next set of endpoint
    /// configurations, use the token in the next request.
    next_token: ?[]const u8 = null,

    /// The field to sort results by. The default is `CreationTime`.
    sort_by: ?EndpointConfigSortKey = null,

    /// The sort order for results. The default is `Descending`.
    sort_order: ?OrderKey = null,

    pub const json_field_names = .{
        .creation_time_after = "CreationTimeAfter",
        .creation_time_before = "CreationTimeBefore",
        .max_results = "MaxResults",
        .name_contains = "NameContains",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};

pub const ListEndpointConfigsOutput = struct {
    /// An array of endpoint configurations.
    endpoint_configs: ?[]const EndpointConfigSummary = null,

    /// If the response is truncated, SageMaker returns this token. To retrieve the
    /// next set of endpoint configurations, use it in the subsequent request
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .endpoint_configs = "EndpointConfigs",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListEndpointConfigsInput, options: CallOptions) !ListEndpointConfigsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListEndpointConfigsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListEndpointConfigs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListEndpointConfigsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListEndpointConfigsOutput, body, allocator);
}

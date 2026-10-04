const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SignalNodeType = @import("signal_node_type.zig").SignalNodeType;
const Node = @import("node.zig").Node;

pub const ListSignalCatalogNodesInput = struct {
    /// The maximum number of items to return, between 1 and 100, inclusive.
    max_results: ?i32 = null,

    /// The name of the signal catalog to list information about.
    name: []const u8,

    /// A pagination token for the next set of results.
    ///
    /// If the results of a search are large, only a portion of the results are
    /// returned, and a `nextToken` pagination token is returned in the response. To
    /// retrieve the next set of results, reissue the search request and include the
    /// returned token. When all results have been returned, the response does not
    /// contain a pagination token value.
    next_token: ?[]const u8 = null,

    /// The type of node in the signal catalog.
    signal_node_type: ?SignalNodeType = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .name = "name",
        .next_token = "nextToken",
        .signal_node_type = "signalNodeType",
    };
};

pub const ListSignalCatalogNodesOutput = struct {
    /// The token to retrieve the next set of results, or `null` if there are no
    /// more results.
    next_token: ?[]const u8 = null,

    /// A list of information about nodes.
    nodes: ?[]const Node = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .nodes = "nodes",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSignalCatalogNodesInput, options: CallOptions) !ListSignalCatalogNodesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotfleetwise", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSignalCatalogNodesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotfleetwise", "IoTFleetWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "IoTAutobahnControlPlane.ListSignalCatalogNodes");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSignalCatalogNodesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListSignalCatalogNodesOutput, body, allocator);
}

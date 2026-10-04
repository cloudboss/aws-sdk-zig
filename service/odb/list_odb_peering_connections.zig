const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OdbPeeringConnectionSummary = @import("odb_peering_connection_summary.zig").OdbPeeringConnectionSummary;

pub const ListOdbPeeringConnectionsInput = struct {
    /// The maximum number of ODB peering connections to return in the response.
    ///
    /// Default: `20`
    ///
    /// Constraints:
    ///
    /// * Must be between 1 and 100.
    max_results: ?i32 = null,

    /// The pagination token for the next page of ODB peering connections.
    next_token: ?[]const u8 = null,

    /// The identifier of the ODB network to list peering connections for.
    ///
    /// If not specified, lists all ODB peering connections in the account.
    odb_network_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .odb_network_id = "odbNetworkId",
    };
};

pub const ListOdbPeeringConnectionsOutput = struct {
    /// The pagination token for the next page of ODB peering connections.
    next_token: ?[]const u8 = null,

    /// The list of ODB peering connections.
    odb_peering_connections: ?[]const OdbPeeringConnectionSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .odb_peering_connections = "odbPeeringConnections",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListOdbPeeringConnectionsInput, options: CallOptions) !ListOdbPeeringConnectionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "odb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListOdbPeeringConnectionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("odb", "odb", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "Odb.ListOdbPeeringConnections");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListOdbPeeringConnectionsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListOdbPeeringConnectionsOutput, body, allocator);
}

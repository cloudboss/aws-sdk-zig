const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Node = @import("node.zig").Node;

pub const GetNodeInput = struct {
    /// The unique identifier of the member that owns the node.
    ///
    /// Applies only to Hyperledger Fabric and is required for Hyperledger Fabric.
    member_id: ?[]const u8 = null,

    /// The unique identifier of the network that the node is on.
    network_id: []const u8,

    /// The unique identifier of the node.
    node_id: []const u8,

    pub const json_field_names = .{
        .member_id = "MemberId",
        .network_id = "NetworkId",
        .node_id = "NodeId",
    };
};

pub const GetNodeOutput = struct {
    /// Properties of the node configuration.
    node: ?Node = null,

    pub const json_field_names = .{
        .node = "Node",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetNodeInput, options: CallOptions) !GetNodeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "managedblockchain", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetNodeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("managedblockchain", "ManagedBlockchain", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/networks/");
    try path_buf.appendSlice(allocator, input.network_id);
    try path_buf.appendSlice(allocator, "/nodes/");
    try path_buf.appendSlice(allocator, input.node_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.member_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "memberId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetNodeOutput {
    var result: GetNodeOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetNodeOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

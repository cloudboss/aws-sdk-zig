const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NodeStatus = @import("node_status.zig").NodeStatus;
const NodeSummary = @import("node_summary.zig").NodeSummary;

pub const ListNodesInput = struct {
    /// The maximum number of nodes to list.
    max_results: ?i32 = null,

    /// The unique identifier of the member who owns the nodes to list.
    ///
    /// Applies only to Hyperledger Fabric and is required for Hyperledger Fabric.
    member_id: ?[]const u8 = null,

    /// The unique identifier of the network for which to list nodes.
    network_id: []const u8,

    /// The pagination token that indicates the next set of results to retrieve.
    next_token: ?[]const u8 = null,

    /// An optional status specifier. If provided, only nodes currently in this
    /// status are listed.
    status: ?NodeStatus = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .member_id = "MemberId",
        .network_id = "NetworkId",
        .next_token = "NextToken",
        .status = "Status",
    };
};

pub const ListNodesOutput = struct {
    /// The pagination token that indicates the next set of results to retrieve.
    next_token: ?[]const u8 = null,

    /// An array of `NodeSummary` objects that contain configuration properties for
    /// each node.
    nodes: ?[]const NodeSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .nodes = "Nodes",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListNodesInput, options: CallOptions) !ListNodesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListNodesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("managedblockchain", "ManagedBlockchain", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/networks/");
    try path_buf.appendSlice(allocator, input.network_id);
    try path_buf.appendSlice(allocator, "/nodes");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.member_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "memberId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.status) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "status=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListNodesOutput {
    const result: ListNodesOutput = try aws.json.parseJsonObject(
        ListNodesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

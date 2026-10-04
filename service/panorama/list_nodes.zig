const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NodeCategory = @import("node_category.zig").NodeCategory;
const Node = @import("node.zig").Node;

pub const ListNodesInput = struct {
    /// Search for nodes by category.
    category: ?NodeCategory = null,

    /// The maximum number of nodes to return in one page of results.
    max_results: ?i32 = null,

    /// Specify the pagination token from a previous request to retrieve the next
    /// page of results.
    next_token: ?[]const u8 = null,

    /// Search for nodes by the account ID of the nodes' owner.
    owner_account: ?[]const u8 = null,

    /// Search for nodes by name.
    package_name: ?[]const u8 = null,

    /// Search for nodes by version.
    package_version: ?[]const u8 = null,

    /// Search for nodes by patch version.
    patch_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .category = "Category",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .owner_account = "OwnerAccount",
        .package_name = "PackageName",
        .package_version = "PackageVersion",
        .patch_version = "PatchVersion",
    };
};

pub const ListNodesOutput = struct {
    /// A pagination token that's included if more results are available.
    next_token: ?[]const u8 = null,

    /// A list of nodes.
    nodes: ?[]const Node = null,

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
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "panorama", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("panorama", "Panorama", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/nodes";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.category) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "category=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.owner_account) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "ownerAccount=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.package_name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "packageName=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.package_version) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "packageVersion=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.patch_version) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "patchVersion=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListNodesOutput {
    var result: ListNodesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListNodesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

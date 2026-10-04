const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccessorNetworkType = @import("accessor_network_type.zig").AccessorNetworkType;
const AccessorSummary = @import("accessor_summary.zig").AccessorSummary;

pub const ListAccessorsInput = struct {
    /// The maximum number of accessors to list.
    max_results: ?i32 = null,

    /// The blockchain network that the `Accessor` token is created for.
    ///
    /// Use the value `ETHEREUM_MAINNET_AND_GOERLI` for all
    /// existing `Accessors` tokens that were created before the `networkType`
    /// property was introduced.
    network_type: ?AccessorNetworkType = null,

    /// The pagination token that indicates the next set of results to retrieve.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .network_type = "NetworkType",
        .next_token = "NextToken",
    };
};

pub const ListAccessorsOutput = struct {
    /// An array of AccessorSummary objects that contain configuration properties
    /// for
    /// each accessor.
    accessors: ?[]const AccessorSummary = null,

    /// The pagination token that indicates the next set of results to retrieve.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .accessors = "Accessors",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAccessorsInput, options: CallOptions) !ListAccessorsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAccessorsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("managedblockchain", "ManagedBlockchain", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/accessors";

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
    if (input.network_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "networkType=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAccessorsOutput {
    const result: ListAccessorsOutput = try aws.json.parseJsonObject(
        ListAccessorsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

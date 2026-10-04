const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OwnerFilter = @import("owner_filter.zig").OwnerFilter;
const TokenFilter = @import("token_filter.zig").TokenFilter;
const TokenBalance = @import("token_balance.zig").TokenBalance;

pub const ListTokenBalancesInput = struct {
    /// The maximum number of token balances to return.
    ///
    /// Default: `100`
    ///
    /// Even if additional results can be retrieved, the request can return less
    /// results than `maxResults` or an empty array of results.
    ///
    /// To retrieve the next set of results, make another request with the
    /// returned `nextToken` value. The value of `nextToken` is
    /// `null` when there are no more results to return
    max_results: ?i32 = null,

    /// The pagination token that indicates the next set of results to retrieve.
    next_token: ?[]const u8 = null,

    /// The contract or wallet address on the blockchain network by which to filter
    /// the
    /// request. You must specify the `address` property of the `ownerFilter`
    /// when listing balances of tokens owned by the address.
    owner_filter: ?OwnerFilter = null,

    /// The contract address or a token identifier on the
    /// blockchain network by which to filter the request. You must specify the
    /// `contractAddress`
    /// property of this container when listing tokens minted by a contract.
    ///
    /// You must always specify the network property of this
    /// container when using this operation.
    token_filter: TokenFilter,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .owner_filter = "ownerFilter",
        .token_filter = "tokenFilter",
    };
};

pub const ListTokenBalancesOutput = struct {
    /// The pagination token that indicates the next set of results to retrieve.
    next_token: ?[]const u8 = null,

    /// An array of `TokenBalance` objects. Each object contains details about
    /// the token balance.
    token_balances: ?[]const TokenBalance = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .token_balances = "tokenBalances",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTokenBalancesInput, options: CallOptions) !ListTokenBalancesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "managedblockchain-query", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTokenBalancesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("managedblockchain-query", "ManagedBlockchain Query", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/list-token-balances";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.owner_filter) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ownerFilter\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"tokenFilter\":");
    try aws.json.writeValue(@TypeOf(input.token_filter), input.token_filter, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTokenBalancesOutput {
    const result: ListTokenBalancesOutput = try aws.json.parseJsonObject(
        ListTokenBalancesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

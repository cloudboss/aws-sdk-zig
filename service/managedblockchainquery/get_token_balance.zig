const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BlockchainInstant = @import("blockchain_instant.zig").BlockchainInstant;
const OwnerIdentifier = @import("owner_identifier.zig").OwnerIdentifier;
const TokenIdentifier = @import("token_identifier.zig").TokenIdentifier;

pub const GetTokenBalanceInput = struct {
    /// The time for when the TokenBalance is requested or
    /// the current time if a time is not provided in the request.
    ///
    /// This time will only be recorded up to the second.
    at_blockchain_instant: ?BlockchainInstant = null,

    /// The container for the identifier for the owner.
    owner_identifier: OwnerIdentifier,

    /// The container for the identifier for the token, including the unique
    /// token ID and its blockchain network.
    token_identifier: TokenIdentifier,

    pub const json_field_names = .{
        .at_blockchain_instant = "atBlockchainInstant",
        .owner_identifier = "ownerIdentifier",
        .token_identifier = "tokenIdentifier",
    };
};

pub const GetTokenBalanceOutput = struct {
    at_blockchain_instant: ?BlockchainInstant = null,

    /// The container for the token balance.
    balance: []const u8,

    last_updated_time: ?BlockchainInstant = null,

    owner_identifier: ?OwnerIdentifier = null,

    token_identifier: ?TokenIdentifier = null,

    pub const json_field_names = .{
        .at_blockchain_instant = "atBlockchainInstant",
        .balance = "balance",
        .last_updated_time = "lastUpdatedTime",
        .owner_identifier = "ownerIdentifier",
        .token_identifier = "tokenIdentifier",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTokenBalanceInput, options: CallOptions) !GetTokenBalanceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTokenBalanceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("managedblockchain-query", "ManagedBlockchain Query", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/get-token-balance";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.at_blockchain_instant) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"atBlockchainInstant\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ownerIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.owner_identifier), input.owner_identifier, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"tokenIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.token_identifier), input.token_identifier, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTokenBalanceOutput {
    const result: GetTokenBalanceOutput = try aws.json.parseJsonObject(
        GetTokenBalanceOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

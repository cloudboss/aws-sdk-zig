const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BatchGetTokenBalanceInputItem = @import("batch_get_token_balance_input_item.zig").BatchGetTokenBalanceInputItem;
const BatchGetTokenBalanceErrorItem = @import("batch_get_token_balance_error_item.zig").BatchGetTokenBalanceErrorItem;
const BatchGetTokenBalanceOutputItem = @import("batch_get_token_balance_output_item.zig").BatchGetTokenBalanceOutputItem;

pub const BatchGetTokenBalanceInput = struct {
    /// An array of `BatchGetTokenBalanceInputItem` objects whose balance is being
    /// requested.
    get_token_balance_inputs: ?[]const BatchGetTokenBalanceInputItem = null,

    pub const json_field_names = .{
        .get_token_balance_inputs = "getTokenBalanceInputs",
    };
};

pub const BatchGetTokenBalanceOutput = struct {
    /// An array of `BatchGetTokenBalanceErrorItem` objects returned from the
    /// request.
    errors: ?[]const BatchGetTokenBalanceErrorItem = null,

    /// An array of `BatchGetTokenBalanceOutputItem` objects returned by the
    /// response.
    token_balances: ?[]const BatchGetTokenBalanceOutputItem = null,

    pub const json_field_names = .{
        .errors = "errors",
        .token_balances = "tokenBalances",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetTokenBalanceInput, options: CallOptions) !BatchGetTokenBalanceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetTokenBalanceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("managedblockchain-query", "ManagedBlockchain Query", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/batch-get-token-balance";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.get_token_balance_inputs) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"getTokenBalanceInputs\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetTokenBalanceOutput {
    const result: BatchGetTokenBalanceOutput = try aws.json.parseJsonObject(
        BatchGetTokenBalanceOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

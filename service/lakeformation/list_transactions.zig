const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TransactionStatusFilter = @import("transaction_status_filter.zig").TransactionStatusFilter;
const TransactionDescription = @import("transaction_description.zig").TransactionDescription;

pub const ListTransactionsInput = struct {
    /// The catalog for which to list transactions. Defaults to the account ID of
    /// the caller.
    catalog_id: ?[]const u8 = null,

    /// The maximum number of transactions to return in a single call.
    max_results: ?i32 = null,

    /// A continuation token if this is not the first call to retrieve transactions.
    next_token: ?[]const u8 = null,

    /// A filter indicating the status of transactions to return. Options are ALL |
    /// COMPLETED | COMMITTED | ABORTED | ACTIVE. The default is `ALL`.
    status_filter: ?TransactionStatusFilter = null,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .status_filter = "StatusFilter",
    };
};

pub const ListTransactionsOutput = struct {
    /// A continuation token indicating whether additional data is available.
    next_token: ?[]const u8 = null,

    /// A list of transactions. The record for each transaction is a
    /// `TransactionDescription` object.
    transactions: ?[]const TransactionDescription = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .transactions = "Transactions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTransactionsInput, options: CallOptions) !ListTransactionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lakeformation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTransactionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lakeformation", "LakeFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ListTransactions";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.catalog_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CatalogId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.status_filter) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"StatusFilter\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTransactionsOutput {
    const result: ListTransactionsOutput = try aws.json.parseJsonObject(
        ListTransactionsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

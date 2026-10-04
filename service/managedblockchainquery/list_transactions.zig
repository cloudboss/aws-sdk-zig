const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConfirmationStatusFilter = @import("confirmation_status_filter.zig").ConfirmationStatusFilter;
const BlockchainInstant = @import("blockchain_instant.zig").BlockchainInstant;
const QueryNetwork = @import("query_network.zig").QueryNetwork;
const ListTransactionsSort = @import("list_transactions_sort.zig").ListTransactionsSort;
const TransactionOutputItem = @import("transaction_output_item.zig").TransactionOutputItem;

pub const ListTransactionsInput = struct {
    /// The address (either a contract or wallet), whose transactions are being
    /// requested.
    address: []const u8,

    /// This filter is used to include transactions in the response that haven't
    /// reached [
    /// *finality*
    /// ](https://docs.aws.amazon.com/managed-blockchain/latest/ambq-dg/key-concepts.html#finality). Transactions that have reached finality are always
    /// part of the response.
    confirmation_status_filter: ?ConfirmationStatusFilter = null,

    from_blockchain_instant: ?BlockchainInstant = null,

    /// The maximum number of transactions to list.
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

    /// The blockchain network where the transactions occurred.
    network: QueryNetwork,

    /// The pagination token that indicates the next set of results to retrieve.
    next_token: ?[]const u8 = null,

    /// The order by which the results will be sorted.
    sort: ?ListTransactionsSort = null,

    to_blockchain_instant: ?BlockchainInstant = null,

    pub const json_field_names = .{
        .address = "address",
        .confirmation_status_filter = "confirmationStatusFilter",
        .from_blockchain_instant = "fromBlockchainInstant",
        .max_results = "maxResults",
        .network = "network",
        .next_token = "nextToken",
        .sort = "sort",
        .to_blockchain_instant = "toBlockchainInstant",
    };
};

pub const ListTransactionsOutput = struct {
    /// The pagination token that indicates the next set of results to retrieve.
    next_token: ?[]const u8 = null,

    /// The array of transactions returned by the request.
    transactions: ?[]const TransactionOutputItem = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .transactions = "transactions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTransactionsInput, options: CallOptions) !ListTransactionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTransactionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("managedblockchain-query", "ManagedBlockchain Query", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/list-transactions";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"address\":");
    try aws.json.writeValue(@TypeOf(input.address), input.address, allocator, &body_buf);
    has_prev = true;
    if (input.confirmation_status_filter) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"confirmationStatusFilter\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.from_blockchain_instant) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"fromBlockchainInstant\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"network\":");
    try aws.json.writeValue(@TypeOf(input.network), input.network, allocator, &body_buf);
    has_prev = true;
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sort) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sort\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.to_blockchain_instant) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"toBlockchainInstant\":");
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
    var result: ListTransactionsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListTransactionsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

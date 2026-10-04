const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AddressIdentifierFilter = @import("address_identifier_filter.zig").AddressIdentifierFilter;
const ConfirmationStatusFilter = @import("confirmation_status_filter.zig").ConfirmationStatusFilter;
const ListFilteredTransactionEventsSort = @import("list_filtered_transaction_events_sort.zig").ListFilteredTransactionEventsSort;
const TimeFilter = @import("time_filter.zig").TimeFilter;
const VoutFilter = @import("vout_filter.zig").VoutFilter;
const TransactionEvent = @import("transaction_event.zig").TransactionEvent;

pub const ListFilteredTransactionEventsInput = struct {
    /// This is the unique public address on the blockchain for which the
    /// transaction events are being requested.
    address_identifier_filter: AddressIdentifierFilter,

    confirmation_status_filter: ?ConfirmationStatusFilter = null,

    /// The maximum number of transaction events to list.
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

    /// The blockchain network where the transaction occurred.
    ///
    /// Valid Values: `BITCOIN_MAINNET` | `BITCOIN_TESTNET`
    network: []const u8,

    /// The pagination token that indicates the next set of results to retrieve.
    next_token: ?[]const u8 = null,

    /// The order by which the results will be sorted.
    sort: ?ListFilteredTransactionEventsSort = null,

    /// This container specifies the time frame for the transaction events returned
    /// in the response.
    time_filter: ?TimeFilter = null,

    /// This container specifies filtering attributes related to BITCOIN_VOUT event
    /// types
    vout_filter: ?VoutFilter = null,

    pub const json_field_names = .{
        .address_identifier_filter = "addressIdentifierFilter",
        .confirmation_status_filter = "confirmationStatusFilter",
        .max_results = "maxResults",
        .network = "network",
        .next_token = "nextToken",
        .sort = "sort",
        .time_filter = "timeFilter",
        .vout_filter = "voutFilter",
    };
};

pub const ListFilteredTransactionEventsOutput = struct {
    /// The transaction events returned by the request.
    events: ?[]const TransactionEvent = null,

    /// The pagination token that indicates the next set of results to retrieve.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .events = "events",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListFilteredTransactionEventsInput, options: CallOptions) !ListFilteredTransactionEventsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListFilteredTransactionEventsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("managedblockchain-query", "ManagedBlockchain Query", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/list-filtered-transaction-events";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"addressIdentifierFilter\":");
    try aws.json.writeValue(@TypeOf(input.address_identifier_filter), input.address_identifier_filter, allocator, &body_buf);
    has_prev = true;
    if (input.confirmation_status_filter) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"confirmationStatusFilter\":");
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
    if (input.time_filter) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"timeFilter\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.vout_filter) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"voutFilter\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListFilteredTransactionEventsOutput {
    const result: ListFilteredTransactionEventsOutput = try aws.json.parseJsonObject(
        ListFilteredTransactionEventsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

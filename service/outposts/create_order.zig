const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LineItemRequest = @import("line_item_request.zig").LineItemRequest;
const PaymentOption = @import("payment_option.zig").PaymentOption;
const PaymentTerm = @import("payment_term.zig").PaymentTerm;
const Order = @import("order.zig").Order;

pub const CreateOrderInput = struct {
    /// The line items that make up the order.
    line_items: ?[]const LineItemRequest = null,

    /// The ID or the Amazon Resource Name (ARN) of the Outpost.
    outpost_identifier: []const u8,

    /// The payment option.
    payment_option: PaymentOption,

    /// The payment terms.
    payment_term: ?PaymentTerm = null,

    /// The ID of the quote to use for the order.
    quote_identifier: ?[]const u8 = null,

    /// The ID of the quote option to use for the order.
    quote_option_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .line_items = "LineItems",
        .outpost_identifier = "OutpostIdentifier",
        .payment_option = "PaymentOption",
        .payment_term = "PaymentTerm",
        .quote_identifier = "QuoteIdentifier",
        .quote_option_identifier = "QuoteOptionIdentifier",
    };
};

pub const CreateOrderOutput = struct {
    /// Information about this order.
    order: ?Order = null,

    pub const json_field_names = .{
        .order = "Order",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateOrderInput, options: CallOptions) !CreateOrderOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "outposts", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateOrderInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("outposts", "Outposts", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/orders";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.line_items) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LineItems\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"OutpostIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.outpost_identifier), input.outpost_identifier, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PaymentOption\":");
    try aws.json.writeValue(@TypeOf(input.payment_option), input.payment_option, allocator, &body_buf);
    has_prev = true;
    if (input.payment_term) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PaymentTerm\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.quote_identifier) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"QuoteIdentifier\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.quote_option_identifier) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"QuoteOptionIdentifier\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateOrderOutput {
    const result: CreateOrderOutput = try aws.json.parseJsonObject(
        CreateOrderOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

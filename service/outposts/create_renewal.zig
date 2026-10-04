const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PaymentOption = @import("payment_option.zig").PaymentOption;
const PaymentTerm = @import("payment_term.zig").PaymentTerm;

pub const CreateRenewalInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the
    /// request.
    client_token: ?[]const u8 = null,

    /// The ID or ARN of the Outpost.
    outpost_identifier: []const u8,

    /// The payment option.
    payment_option: PaymentOption,

    /// The payment term.
    payment_term: PaymentTerm,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .outpost_identifier = "OutpostIdentifier",
        .payment_option = "PaymentOption",
        .payment_term = "PaymentTerm",
    };
};

pub const CreateRenewalOutput = struct {
    /// The monthly recurring price of the renewal.
    monthly_recurring_price: ?f32 = null,

    /// The ID of the Outpost.
    outpost_id: ?[]const u8 = null,

    /// The payment option.
    payment_option: ?PaymentOption = null,

    /// The payment term.
    payment_term: ?PaymentTerm = null,

    /// The upfront price of the renewal.
    upfront_price: ?f32 = null,

    pub const json_field_names = .{
        .monthly_recurring_price = "MonthlyRecurringPrice",
        .outpost_id = "OutpostId",
        .payment_option = "PaymentOption",
        .payment_term = "PaymentTerm",
        .upfront_price = "UpfrontPrice",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRenewalInput, options: CallOptions) !CreateRenewalOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRenewalInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("outposts", "Outposts", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/renewals";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PaymentTerm\":");
    try aws.json.writeValue(@TypeOf(input.payment_term), input.payment_term, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRenewalOutput {
    var result: CreateRenewalOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateRenewalOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

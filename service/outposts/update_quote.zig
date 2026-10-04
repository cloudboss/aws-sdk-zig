const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const QuoteCapacity = @import("quote_capacity.zig").QuoteCapacity;
const QuoteConstraint = @import("quote_constraint.zig").QuoteConstraint;
const PaymentOption = @import("payment_option.zig").PaymentOption;
const PaymentTerm = @import("payment_term.zig").PaymentTerm;
const Quote = @import("quote.zig").Quote;

pub const UpdateQuoteInput = struct {
    /// The country code for the Outpost site location.
    country_code: ?[]const u8 = null,

    /// A description for the quote.
    description: ?[]const u8 = null,

    /// The ID or ARN of the Outpost to associate with the quote. Specify an empty
    /// string to
    /// remove the Outpost association.
    outpost_identifier: ?[]const u8 = null,

    /// The ID of the quote.
    quote_identifier: []const u8,

    /// The updated capacity requirements for the quote.
    requested_capacities: ?[]const QuoteCapacity = null,

    /// The updated physical constraints for the quote.
    requested_constraints: ?[]const QuoteConstraint = null,

    /// The updated payment options to include in the quote pricing.
    requested_payment_options: ?[]const PaymentOption = null,

    /// The updated payment terms to include in the quote pricing.
    requested_payment_terms: ?[]const PaymentTerm = null,

    pub const json_field_names = .{
        .country_code = "CountryCode",
        .description = "Description",
        .outpost_identifier = "OutpostIdentifier",
        .quote_identifier = "QuoteIdentifier",
        .requested_capacities = "RequestedCapacities",
        .requested_constraints = "RequestedConstraints",
        .requested_payment_options = "RequestedPaymentOptions",
        .requested_payment_terms = "RequestedPaymentTerms",
    };
};

pub const UpdateQuoteOutput = struct {
    /// Information about the updated quote.
    quote: ?Quote = null,

    pub const json_field_names = .{
        .quote = "Quote",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateQuoteInput, options: CallOptions) !UpdateQuoteOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateQuoteInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("outposts", "Outposts", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/quotes/");
    try path_buf.appendSlice(allocator, input.quote_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.country_code) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CountryCode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.outpost_identifier) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OutpostIdentifier\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.requested_capacities) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RequestedCapacities\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.requested_constraints) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RequestedConstraints\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.requested_payment_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RequestedPaymentOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.requested_payment_terms) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RequestedPaymentTerms\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateQuoteOutput {
    const result: UpdateQuoteOutput = try aws.json.parseJsonObject(
        UpdateQuoteOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

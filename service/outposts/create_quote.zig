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

pub const CreateQuoteInput = struct {
    /// The country code for the Outpost site location.
    country_code: []const u8,

    /// A description for the quote.
    description: ?[]const u8 = null,

    /// The ID or ARN of the Outpost to associate with the quote. If not specified,
    /// the quote is
    /// created without an Outpost association.
    outpost_identifier: ?[]const u8 = null,

    /// The capacity requirements for the quote. Each entry specifies a capacity
    /// type (such as
    /// Amazon EC2), the unit, and the quantity. For Amazon EC2, the quantity is the
    /// number of additional
    /// instances to add to the Outpost. For Amazon EBS and Amazon S3, the quantity
    /// is the total desired
    /// end-state capacity of the Outpost.
    requested_capacities: []const QuoteCapacity,

    /// The physical constraints for the quote, such as maximum number of racks,
    /// maximum power
    /// draw per rack, or maximum weight per rack.
    requested_constraints: ?[]const QuoteConstraint = null,

    /// The payment options to include in the quote pricing. If not specified, all
    /// available
    /// payment options are returned.
    requested_payment_options: ?[]const PaymentOption = null,

    /// The payment terms to include in the quote pricing. If not specified, all
    /// available
    /// payment terms are returned.
    requested_payment_terms: ?[]const PaymentTerm = null,

    pub const json_field_names = .{
        .country_code = "CountryCode",
        .description = "Description",
        .outpost_identifier = "OutpostIdentifier",
        .requested_capacities = "RequestedCapacities",
        .requested_constraints = "RequestedConstraints",
        .requested_payment_options = "RequestedPaymentOptions",
        .requested_payment_terms = "RequestedPaymentTerms",
    };
};

pub const CreateQuoteOutput = struct {
    /// Information about the quote.
    quote: ?Quote = null,

    pub const json_field_names = .{
        .quote = "Quote",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateQuoteInput, options: CallOptions) !CreateQuoteOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateQuoteInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("outposts", "Outposts", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/quotes";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"CountryCode\":");
    try aws.json.writeValue(@TypeOf(input.country_code), input.country_code, allocator, &body_buf);
    has_prev = true;
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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RequestedCapacities\":");
    try aws.json.writeValue(@TypeOf(input.requested_capacities), input.requested_capacities, allocator, &body_buf);
    has_prev = true;
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
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateQuoteOutput {
    const result: CreateQuoteOutput = try aws.json.parseJsonObject(
        CreateQuoteOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

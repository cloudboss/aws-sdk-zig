const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const SetReceiptRulePositionInput = struct {
    /// The name of the receipt rule after which to place the specified receipt
    /// rule.
    after: ?[]const u8 = null,

    /// The name of the receipt rule to reposition.
    rule_name: []const u8,

    /// The name of the receipt rule set that contains the receipt rule to
    /// reposition.
    rule_set_name: []const u8,
};

pub const SetReceiptRulePositionOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SetReceiptRulePositionInput, options: CallOptions) !SetReceiptRulePositionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ses", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SetReceiptRulePositionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SES", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=SetReceiptRulePosition&Version=2010-12-01");
    if (input.after) |v| {
        try body_buf.appendSlice(allocator, "&After=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&RuleName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.rule_name);
    try body_buf.appendSlice(allocator, "&RuleSetName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.rule_set_name);

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SetReceiptRulePositionOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: SetReceiptRulePositionOutput = .{};

    return result;
}

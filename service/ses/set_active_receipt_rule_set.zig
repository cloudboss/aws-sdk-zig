const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const SetActiveReceiptRuleSetInput = struct {
    /// The name of the receipt rule set to make active. Setting this value to null
    /// disables
    /// all email receiving.
    rule_set_name: ?[]const u8 = null,
};

pub const SetActiveReceiptRuleSetOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SetActiveReceiptRuleSetInput, options: CallOptions) !SetActiveReceiptRuleSetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SetActiveReceiptRuleSetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SES", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=SetActiveReceiptRuleSet&Version=2010-12-01");
    if (input.rule_set_name) |v| {
        try body_buf.appendSlice(allocator, "&RuleSetName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SetActiveReceiptRuleSetOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: SetActiveReceiptRuleSetOutput = .{};

    return result;
}

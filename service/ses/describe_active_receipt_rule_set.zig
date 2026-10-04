const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReceiptRuleSetMetadata = @import("receipt_rule_set_metadata.zig").ReceiptRuleSetMetadata;
const ReceiptRule = @import("receipt_rule.zig").ReceiptRule;
const serde = @import("serde.zig");

pub const DescribeActiveReceiptRuleSetInput = struct {
};

pub const DescribeActiveReceiptRuleSetOutput = struct {
    /// The metadata for the currently active receipt rule set. The metadata
    /// consists of the
    /// rule set name and a timestamp of when the rule set was created.
    metadata: ?ReceiptRuleSetMetadata = null,

    /// The receipt rules that belong to the active rule set.
    rules: ?[]const ReceiptRule = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeActiveReceiptRuleSetInput, options: CallOptions) !DescribeActiveReceiptRuleSetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeActiveReceiptRuleSetInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("email", "SES", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeActiveReceiptRuleSet&Version=2010-12-01");

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeActiveReceiptRuleSetOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeActiveReceiptRuleSetResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeActiveReceiptRuleSetOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Metadata")) {
                    result.metadata = try serde.deserializeReceiptRuleSetMetadata(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "Rules")) {
                    result.rules = try serde.deserializeReceiptRulesList(allocator, &reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}

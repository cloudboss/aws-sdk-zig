const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ManagedRule = @import("managed_rule.zig").ManagedRule;
const PartialFailure = @import("partial_failure.zig").PartialFailure;
const serde = @import("serde.zig");

pub const PutManagedInsightRulesInput = struct {
    /// A list of `ManagedRules` to enable.
    managed_rules: []const ManagedRule,

    pub const json_field_names = .{
        .managed_rules = "ManagedRules",
    };
};

pub const PutManagedInsightRulesOutput = struct {
    /// An array that lists the rules that could not be enabled.
    failures: ?[]const PartialFailure = null,

    pub const json_field_names = .{
        .failures = "Failures",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutManagedInsightRulesInput, options: CallOptions) !PutManagedInsightRulesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "monitoring", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutManagedInsightRulesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("monitoring", "CloudWatch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=PutManagedInsightRules&Version=2010-08-01");
    for (input.managed_rules, 0..) |item, idx| {
        const n = idx + 1;
        {
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ManagedRules.member.{d}.ResourceARN=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item.resource_arn);
        }
        if (item.tags) |lst_1| {
            for (lst_1, 0..) |item_1, idx_1| {
                const n_1 = idx_1 + 1;
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ManagedRules.member.{d}.Tags.member.{d}.Key=", .{n, n_1}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_1.key);
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ManagedRules.member.{d}.Tags.member.{d}.Value=", .{n, n_1}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_1.value);
                }
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ManagedRules.member.{d}.TemplateName=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item.template_name);
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutManagedInsightRulesOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PutManagedInsightRulesResult")) break;
            },
            else => {},
        }
    }

    var result: PutManagedInsightRulesOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Failures")) {
                    result.failures = try serde.deserializeBatchFailures(allocator, &reader, "member");
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

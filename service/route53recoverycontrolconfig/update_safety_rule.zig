const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssertionRuleUpdate = @import("assertion_rule_update.zig").AssertionRuleUpdate;
const GatingRuleUpdate = @import("gating_rule_update.zig").GatingRuleUpdate;
const AssertionRule = @import("assertion_rule.zig").AssertionRule;
const GatingRule = @import("gating_rule.zig").GatingRule;

pub const UpdateSafetyRuleInput = struct {
    /// The assertion rule to update.
    assertion_rule_update: ?AssertionRuleUpdate = null,

    /// The gating rule to update.
    gating_rule_update: ?GatingRuleUpdate = null,

    pub const json_field_names = .{
        .assertion_rule_update = "AssertionRuleUpdate",
        .gating_rule_update = "GatingRuleUpdate",
    };
};

pub const UpdateSafetyRuleOutput = struct {
    /// The assertion rule updated.
    assertion_rule: ?AssertionRule = null,

    /// The gating rule updated.
    gating_rule: ?GatingRule = null,

    pub const json_field_names = .{
        .assertion_rule = "AssertionRule",
        .gating_rule = "GatingRule",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSafetyRuleInput, options: CallOptions) !UpdateSafetyRuleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "route53-recovery-control-config", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSafetyRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53-recovery-control-config", "Route53 Recovery Control Config", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/safetyrule";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.assertion_rule_update) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AssertionRuleUpdate\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.gating_rule_update) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"GatingRuleUpdate\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSafetyRuleOutput {
    var result: UpdateSafetyRuleOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateSafetyRuleOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

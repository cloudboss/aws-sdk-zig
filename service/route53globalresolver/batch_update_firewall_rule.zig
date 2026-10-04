const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BatchUpdateFirewallRuleInputItem = @import("batch_update_firewall_rule_input_item.zig").BatchUpdateFirewallRuleInputItem;
const BatchUpdateFirewallRuleOutputItem = @import("batch_update_firewall_rule_output_item.zig").BatchUpdateFirewallRuleOutputItem;

pub const BatchUpdateFirewallRuleInput = struct {
    /// The DNS Firewall rule IDs to be updated.
    firewall_rules: []const BatchUpdateFirewallRuleInputItem,

    pub const json_field_names = .{
        .firewall_rules = "firewallRules",
    };
};

pub const BatchUpdateFirewallRuleOutput = struct {
    /// High level information about the DNS Firewall rules that failed to update.
    failures: ?[]const BatchUpdateFirewallRuleOutputItem = null,

    /// High level information about the DNS Firewall rules that were successfully
    /// updated.
    successes: ?[]const BatchUpdateFirewallRuleOutputItem = null,

    pub const json_field_names = .{
        .failures = "failures",
        .successes = "successes",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchUpdateFirewallRuleInput, options: CallOptions) !BatchUpdateFirewallRuleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "route53globalresolver", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchUpdateFirewallRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53globalresolver", "Route53GlobalResolver", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/firewall-rules/batch-update";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"firewallRules\":");
    try aws.json.writeValue(@TypeOf(input.firewall_rules), input.firewall_rules, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchUpdateFirewallRuleOutput {
    var result: BatchUpdateFirewallRuleOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchUpdateFirewallRuleOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

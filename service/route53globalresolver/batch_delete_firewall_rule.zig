const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BatchDeleteFirewallRuleInputItem = @import("batch_delete_firewall_rule_input_item.zig").BatchDeleteFirewallRuleInputItem;
const BatchDeleteFirewallRuleOutputItem = @import("batch_delete_firewall_rule_output_item.zig").BatchDeleteFirewallRuleOutputItem;

pub const BatchDeleteFirewallRuleInput = struct {
    /// An array of the DNS Firewall IDs to be deleted.
    firewall_rules: []const BatchDeleteFirewallRuleInputItem,

    pub const json_field_names = .{
        .firewall_rules = "firewallRules",
    };
};

pub const BatchDeleteFirewallRuleOutput = struct {
    /// High level information about the DNS Firewall rules that failed to delete.
    failures: ?[]const BatchDeleteFirewallRuleOutputItem = null,

    /// High level information about the DNS Firewall rules that were deleted
    /// successfully.
    successes: ?[]const BatchDeleteFirewallRuleOutputItem = null,

    pub const json_field_names = .{
        .failures = "failures",
        .successes = "successes",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchDeleteFirewallRuleInput, options: CallOptions) !BatchDeleteFirewallRuleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchDeleteFirewallRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53globalresolver", "Route53GlobalResolver", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/firewall-rules/batch-delete";

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchDeleteFirewallRuleOutput {
    var result: BatchDeleteFirewallRuleOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchDeleteFirewallRuleOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

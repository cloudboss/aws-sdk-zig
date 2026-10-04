const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RuleGroupRequestPhase = @import("rule_group_request_phase.zig").RuleGroupRequestPhase;
const ProxyRulePriority = @import("proxy_rule_priority.zig").ProxyRulePriority;

pub const UpdateProxyRulePrioritiesInput = struct {
    /// The Amazon Resource Name (ARN) of a proxy rule group.
    ///
    /// You must specify the ARN or the name, and you can specify both.
    proxy_rule_group_arn: ?[]const u8 = null,

    /// The descriptive name of the proxy rule group. You can't change the name of a
    /// proxy rule group after you create it.
    ///
    /// You must specify the ARN or the name, and you can specify both.
    proxy_rule_group_name: ?[]const u8 = null,

    /// Evaluation points in the traffic flow where rules are applied. There are
    /// three phases in a traffic where the rule match is applied.
    rule_group_request_phase: RuleGroupRequestPhase,

    /// proxy rule resources to update to new positions.
    rules: []const ProxyRulePriority,

    /// A token used for optimistic locking. Network Firewall returns a token to
    /// your requests that access the proxy rule group. The token marks the state of
    /// the proxy rule group resource at the time of the request.
    ///
    /// To make changes to the proxy rule group, you provide the token in your
    /// request. Network Firewall uses the token to ensure that the proxy rule group
    /// hasn't changed since you last retrieved it. If it has changed, the operation
    /// fails with an `InvalidTokenException`. If this happens, retrieve the proxy
    /// rule group again to get a current copy of it with a current token. Reapply
    /// your changes as needed, then try the operation again using the new token.
    update_token: []const u8,

    pub const json_field_names = .{
        .proxy_rule_group_arn = "ProxyRuleGroupArn",
        .proxy_rule_group_name = "ProxyRuleGroupName",
        .rule_group_request_phase = "RuleGroupRequestPhase",
        .rules = "Rules",
        .update_token = "UpdateToken",
    };
};

pub const UpdateProxyRulePrioritiesOutput = struct {
    /// The Amazon Resource Name (ARN) of a proxy rule group.
    proxy_rule_group_arn: ?[]const u8 = null,

    /// The descriptive name of the proxy rule group. You can't change the name of a
    /// proxy rule group after you create it.
    proxy_rule_group_name: ?[]const u8 = null,

    /// Evaluation points in the traffic flow where rules are applied. There are
    /// three phases in a traffic where the rule match is applied.
    rule_group_request_phase: ?RuleGroupRequestPhase = null,

    /// The updated proxy rule hierarchy that reflects the updates from the request.
    rules: ?[]const ProxyRulePriority = null,

    /// A token used for optimistic locking. Network Firewall returns a token to
    /// your requests that access the proxy rule group. The token marks the state of
    /// the proxy rule group resource at the time of the request.
    ///
    /// To make changes to the proxy rule group, you provide the token in your
    /// request. Network Firewall uses the token to ensure that the proxy rule group
    /// hasn't changed since you last retrieved it. If it has changed, the operation
    /// fails with an `InvalidTokenException`. If this happens, retrieve the proxy
    /// rule group again to get a current copy of it with a current token. Reapply
    /// your changes as needed, then try the operation again using the new token.
    update_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .proxy_rule_group_arn = "ProxyRuleGroupArn",
        .proxy_rule_group_name = "ProxyRuleGroupName",
        .rule_group_request_phase = "RuleGroupRequestPhase",
        .rules = "Rules",
        .update_token = "UpdateToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateProxyRulePrioritiesInput, options: CallOptions) !UpdateProxyRulePrioritiesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "network-firewall", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateProxyRulePrioritiesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("network-firewall", "Network Firewall", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "NetworkFirewall_20201112.UpdateProxyRulePriorities");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateProxyRulePrioritiesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateProxyRulePrioritiesOutput, body, allocator);
}

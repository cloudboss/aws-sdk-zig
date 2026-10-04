const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProxyRulesByRequestPhase = @import("proxy_rules_by_request_phase.zig").ProxyRulesByRequestPhase;
const Tag = @import("tag.zig").Tag;
const ProxyRuleGroup = @import("proxy_rule_group.zig").ProxyRuleGroup;

pub const CreateProxyRuleGroupInput = struct {
    /// A description of the proxy rule group.
    description: ?[]const u8 = null,

    /// The descriptive name of the proxy rule group. You can't change the name of a
    /// proxy rule group after you create it.
    proxy_rule_group_name: []const u8,

    /// Individual rules that define match conditions and actions for
    /// application-layer traffic. Rules specify what to inspect (domains, headers,
    /// methods) and what action to take (allow, deny, alert).
    rules: ?ProxyRulesByRequestPhase = null,

    /// The key:value pairs to associate with the resource.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .description = "Description",
        .proxy_rule_group_name = "ProxyRuleGroupName",
        .rules = "Rules",
        .tags = "Tags",
    };
};

pub const CreateProxyRuleGroupOutput = struct {
    /// The properties that define the proxy rule group.
    proxy_rule_group: ?ProxyRuleGroup = null,

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
        .proxy_rule_group = "ProxyRuleGroup",
        .update_token = "UpdateToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateProxyRuleGroupInput, options: CallOptions) !CreateProxyRuleGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateProxyRuleGroupInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "NetworkFirewall_20201112.CreateProxyRuleGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateProxyRuleGroupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateProxyRuleGroupOutput, body, allocator);
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProxyRule = @import("proxy_rule.zig").ProxyRule;

pub const DescribeProxyRuleInput = struct {
    /// The Amazon Resource Name (ARN) of a proxy rule group.
    ///
    /// You must specify the ARN or the name, and you can specify both.
    proxy_rule_group_arn: ?[]const u8 = null,

    /// The descriptive name of the proxy rule group. You can't change the name of a
    /// proxy rule group after you create it.
    ///
    /// You must specify the ARN or the name, and you can specify both.
    proxy_rule_group_name: ?[]const u8 = null,

    /// The descriptive name of the proxy rule. You can't change the name of a proxy
    /// rule after you create it.
    proxy_rule_name: []const u8,

    pub const json_field_names = .{
        .proxy_rule_group_arn = "ProxyRuleGroupArn",
        .proxy_rule_group_name = "ProxyRuleGroupName",
        .proxy_rule_name = "ProxyRuleName",
    };
};

pub const DescribeProxyRuleOutput = struct {
    /// The configuration for the specified proxy rule.
    proxy_rule: ?ProxyRule = null,

    /// A token used for optimistic locking. Network Firewall returns a token to
    /// your requests that access the proxy rule. The token marks the state of the
    /// proxy rule resource at the time of the request.
    ///
    /// To make changes to the proxy rule, you provide the token in your request.
    /// Network Firewall uses the token to ensure that the proxy rule hasn't changed
    /// since you last retrieved it. If it has changed, the operation fails with an
    /// `InvalidTokenException`. If this happens, retrieve the proxy rule again to
    /// get a current copy of it with a current token. Reapply your changes as
    /// needed, then try the operation again using the new token.
    update_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .proxy_rule = "ProxyRule",
        .update_token = "UpdateToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeProxyRuleInput, options: CallOptions) !DescribeProxyRuleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeProxyRuleInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "NetworkFirewall_20201112.DescribeProxyRule");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeProxyRuleOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeProxyRuleOutput, body, allocator);
}

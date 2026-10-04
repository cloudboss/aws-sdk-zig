const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProxyRuleGroup = @import("proxy_rule_group.zig").ProxyRuleGroup;

pub const DeleteProxyRulesInput = struct {
    /// The Amazon Resource Name (ARN) of a proxy rule group.
    ///
    /// You must specify the ARN or the name, and you can specify both.
    proxy_rule_group_arn: ?[]const u8 = null,

    /// The descriptive name of the proxy rule group. You can't change the name of a
    /// proxy rule group after you create it.
    ///
    /// You must specify the ARN or the name, and you can specify both.
    proxy_rule_group_name: ?[]const u8 = null,

    /// The proxy rule(s) to remove from the existing proxy rule group.
    rules: []const []const u8,

    pub const json_field_names = .{
        .proxy_rule_group_arn = "ProxyRuleGroupArn",
        .proxy_rule_group_name = "ProxyRuleGroupName",
        .rules = "Rules",
    };
};

pub const DeleteProxyRulesOutput = struct {
    /// The properties that define the proxy rule group with the newly created proxy
    /// rule(s).
    proxy_rule_group: ?ProxyRuleGroup = null,

    pub const json_field_names = .{
        .proxy_rule_group = "ProxyRuleGroup",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteProxyRulesInput, options: CallOptions) !DeleteProxyRulesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteProxyRulesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "NetworkFirewall_20201112.DeleteProxyRules");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteProxyRulesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeleteProxyRulesOutput, body, allocator);
}

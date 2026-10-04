const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProxyConfiguration = @import("proxy_configuration.zig").ProxyConfiguration;

pub const DescribeProxyConfigurationInput = struct {
    /// The Amazon Resource Name (ARN) of a proxy configuration.
    ///
    /// You must specify the ARN or the name, and you can specify both.
    proxy_configuration_arn: ?[]const u8 = null,

    /// The descriptive name of the proxy configuration. You can't change the name
    /// of a proxy configuration after you create it.
    ///
    /// You must specify the ARN or the name, and you can specify both.
    proxy_configuration_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .proxy_configuration_arn = "ProxyConfigurationArn",
        .proxy_configuration_name = "ProxyConfigurationName",
    };
};

pub const DescribeProxyConfigurationOutput = struct {
    /// The configuration for the specified proxy configuration.
    proxy_configuration: ?ProxyConfiguration = null,

    /// A token used for optimistic locking. Network Firewall returns a token to
    /// your requests that access the proxy configuration. The token marks the state
    /// of the proxy configuration resource at the time of the request.
    ///
    /// To make changes to the proxy configuration, you provide the token in your
    /// request. Network Firewall uses the token to ensure that the proxy
    /// configuration hasn't changed since you last retrieved it. If it has changed,
    /// the operation fails with an `InvalidTokenException`. If this happens,
    /// retrieve the proxy configuration again to get a current copy of it with a
    /// current token. Reapply your changes as needed, then try the operation again
    /// using the new token.
    update_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .proxy_configuration = "ProxyConfiguration",
        .update_token = "UpdateToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeProxyConfigurationInput, options: CallOptions) !DescribeProxyConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeProxyConfigurationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "NetworkFirewall_20201112.DescribeProxyConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeProxyConfigurationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeProxyConfigurationOutput, body, allocator);
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteProxyInput = struct {
    /// The NAT Gateway the proxy is attached to.
    nat_gateway_id: []const u8,

    /// The Amazon Resource Name (ARN) of a proxy.
    ///
    /// You must specify the ARN or the name, and you can specify both.
    proxy_arn: ?[]const u8 = null,

    /// The descriptive name of the proxy. You can't change the name of a proxy
    /// after you create it.
    ///
    /// You must specify the ARN or the name, and you can specify both.
    proxy_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .nat_gateway_id = "NatGatewayId",
        .proxy_arn = "ProxyArn",
        .proxy_name = "ProxyName",
    };
};

pub const DeleteProxyOutput = struct {
    /// The NAT Gateway the Proxy was attached to.
    nat_gateway_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of a proxy.
    proxy_arn: ?[]const u8 = null,

    /// The descriptive name of the proxy. You can't change the name of a proxy
    /// after you create it.
    proxy_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .nat_gateway_id = "NatGatewayId",
        .proxy_arn = "ProxyArn",
        .proxy_name = "ProxyName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteProxyInput, options: CallOptions) !DeleteProxyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteProxyInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "NetworkFirewall_20201112.DeleteProxy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteProxyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeleteProxyOutput, body, allocator);
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Firewall = @import("firewall.zig").Firewall;
const FirewallStatus = @import("firewall_status.zig").FirewallStatus;

pub const DeleteFirewallInput = struct {
    /// The Amazon Resource Name (ARN) of the firewall.
    ///
    /// You must specify the ARN or the name, and you can specify both.
    firewall_arn: ?[]const u8 = null,

    /// The descriptive name of the firewall. You can't change the name of a
    /// firewall after you create it.
    ///
    /// You must specify the ARN or the name, and you can specify both.
    firewall_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .firewall_arn = "FirewallArn",
        .firewall_name = "FirewallName",
    };
};

pub const DeleteFirewallOutput = struct {
    firewall: ?Firewall = null,

    firewall_status: ?FirewallStatus = null,

    pub const json_field_names = .{
        .firewall = "Firewall",
        .firewall_status = "FirewallStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteFirewallInput, options: CallOptions) !DeleteFirewallOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteFirewallInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "NetworkFirewall_20201112.DeleteFirewall");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteFirewallOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeleteFirewallOutput, body, allocator);
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FirewallFailOpenStatus = @import("firewall_fail_open_status.zig").FirewallFailOpenStatus;
const FirewallConfig = @import("firewall_config.zig").FirewallConfig;

pub const UpdateFirewallConfigInput = struct {
    /// Determines how Route 53 Resolver handles queries during failures, for
    /// example when all traffic that is sent to DNS Firewall fails to receive a
    /// reply.
    ///
    /// * By default, fail open is disabled, which means the failure mode is closed.
    ///   This approach favors security over availability.
    /// DNS Firewall blocks queries that it is unable to evaluate properly.
    ///
    /// * If you enable this option, the failure mode is open. This approach favors
    ///   availability over security. DNS Firewall allows queries to proceed if it
    /// is unable to properly evaluate them.
    ///
    /// This behavior is only enforced for VPCs that have at least one DNS Firewall
    /// rule group association.
    firewall_fail_open: FirewallFailOpenStatus,

    /// The ID of the VPC that the configuration is for.
    resource_id: []const u8,

    pub const json_field_names = .{
        .firewall_fail_open = "FirewallFailOpen",
        .resource_id = "ResourceId",
    };
};

pub const UpdateFirewallConfigOutput = struct {
    /// Configuration of the firewall behavior provided by DNS Firewall for a single
    /// VPC.
    firewall_config: ?FirewallConfig = null,

    pub const json_field_names = .{
        .firewall_config = "FirewallConfig",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateFirewallConfigInput, options: CallOptions) !UpdateFirewallConfigOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "route53resolver", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateFirewallConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53resolver", "Route53Resolver", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Route53Resolver.UpdateFirewallConfig");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateFirewallConfigOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateFirewallConfigOutput, body, allocator);
}

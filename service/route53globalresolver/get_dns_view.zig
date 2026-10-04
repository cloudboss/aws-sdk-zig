const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DnsSecValidationType = @import("dns_sec_validation_type.zig").DnsSecValidationType;
const EdnsClientSubnetType = @import("edns_client_subnet_type.zig").EdnsClientSubnetType;
const FirewallRulesFailOpenType = @import("firewall_rules_fail_open_type.zig").FirewallRulesFailOpenType;
const ProfileResourceStatus = @import("profile_resource_status.zig").ProfileResourceStatus;

pub const GetDNSViewInput = struct {
    /// The ID of the DNS view to retrieve information about.
    dns_view_id: []const u8,

    pub const json_field_names = .{
        .dns_view_id = "dnsViewId",
    };
};

pub const GetDNSViewOutput = struct {
    /// Amazon Resource Name (ARN) of the DNS view.
    arn: []const u8,

    /// A unique, case-sensitive identifier to ensure idempotency. This means that
    /// making the same request multiple times with the same `clientToken` has the
    /// same result every time.
    client_token: ?[]const u8 = null,

    /// The time and date the DNS view was creates on.
    created_at: i64,

    /// Description of the DNS view.
    description: ?[]const u8 = null,

    /// Specifies whether DNSSEC is enabled or disabled for the DNS view.
    dnssec_validation: DnsSecValidationType,

    /// Specifies whether edns0 client subnet is enabled.
    edns_client_subnet: EdnsClientSubnetType,

    /// Specifies the DNS Firewall failure mode configuration. When enabled, the DNS
    /// Firewall allows DNS queries to proceed if it's unable to properly evaluate
    /// them. When disabled, the DNS Firewall blocks DNS queries it's unable to
    /// evaluate.
    firewall_rules_fail_open: FirewallRulesFailOpenType,

    /// ID of the Global Resolver the DNS view is associated to.
    global_resolver_id: []const u8,

    /// ID of the DNS view.
    id: []const u8,

    /// Name of the DNS view.
    name: []const u8,

    /// Operational status of the DNS view.
    status: ProfileResourceStatus,

    /// The time and date the DNS view was updated on.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .client_token = "clientToken",
        .created_at = "createdAt",
        .description = "description",
        .dnssec_validation = "dnssecValidation",
        .edns_client_subnet = "ednsClientSubnet",
        .firewall_rules_fail_open = "firewallRulesFailOpen",
        .global_resolver_id = "globalResolverId",
        .id = "id",
        .name = "name",
        .status = "status",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDNSViewInput, options: CallOptions) !GetDNSViewOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDNSViewInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53globalresolver", "Route53GlobalResolver", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/dns-views/");
    try path_buf.appendSlice(allocator, input.dns_view_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDNSViewOutput {
    var result: GetDNSViewOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetDNSViewOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

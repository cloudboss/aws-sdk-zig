const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CRResourceStatus = @import("cr_resource_status.zig").CRResourceStatus;

pub const GetFirewallDomainListInput = struct {
    /// ID of the domain list.
    firewall_domain_list_id: []const u8,

    pub const json_field_names = .{
        .firewall_domain_list_id = "firewallDomainListId",
    };
};

pub const GetFirewallDomainListOutput = struct {
    /// Amazon Resource Name (ARN) of the domain list.
    arn: []const u8,

    /// A unique, case-sensitive identifier to ensure idempotency. This means that
    /// making the same request multiple times with the same `clientToken` has the
    /// same result every time.
    client_token: ?[]const u8 = null,

    /// The time and date the domain list was created.
    created_at: i64,

    /// The description of the domain list.
    description: ?[]const u8 = null,

    /// Number of domains in the domain list.
    domain_count: i32,

    /// ID of the Global Resolver that the domain list is associated to.
    global_resolver_id: []const u8,

    /// ID of the domain list.
    id: []const u8,

    /// Name of the domain list.
    name: []const u8,

    /// Operational status of the domain list.
    status: CRResourceStatus,

    /// Additional information about the status of the domain list.
    status_message: ?[]const u8 = null,

    /// The date and time the domain list was updated.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .client_token = "clientToken",
        .created_at = "createdAt",
        .description = "description",
        .domain_count = "domainCount",
        .global_resolver_id = "globalResolverId",
        .id = "id",
        .name = "name",
        .status = "status",
        .status_message = "statusMessage",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetFirewallDomainListInput, options: CallOptions) !GetFirewallDomainListOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetFirewallDomainListInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53globalresolver", "Route53GlobalResolver", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/firewall-domain-lists/");
    try path_buf.appendSlice(allocator, input.firewall_domain_list_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetFirewallDomainListOutput {
    const result: GetFirewallDomainListOutput = try aws.json.parseJsonObject(
        GetFirewallDomainListOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

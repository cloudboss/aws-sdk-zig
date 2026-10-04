const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CRResourceStatus = @import("cr_resource_status.zig").CRResourceStatus;

pub const UpdateFirewallDomainsInput = struct {
    /// A list of the domains. You can add up to 1000 domains per request.
    domains: []const []const u8,

    /// The ID of the DNS Firewall domain list to which you want to add the domains.
    firewall_domain_list_id: []const u8,

    /// The operation for updating the domain list. The allowed values are ADD,
    /// REMOVE, and REPLACE.
    operation: []const u8,

    pub const json_field_names = .{
        .domains = "domains",
        .firewall_domain_list_id = "firewallDomainListId",
        .operation = "operation",
    };
};

pub const UpdateFirewallDomainsOutput = struct {
    /// The ID of the DNS Firewall domain list.
    id: []const u8,

    /// The name of the domain list.
    name: []const u8,

    /// The operational status of the domain list.
    status: CRResourceStatus,

    pub const json_field_names = .{
        .id = "id",
        .name = "name",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateFirewallDomainsInput, options: CallOptions) !UpdateFirewallDomainsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateFirewallDomainsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53globalresolver", "Route53GlobalResolver", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/firewall-domain-lists/");
    try path_buf.appendSlice(allocator, input.firewall_domain_list_id);
    try path_buf.appendSlice(allocator, "/domains");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"domains\":");
    try aws.json.writeValue(@TypeOf(input.domains), input.domains, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"operation\":");
    try aws.json.writeValue(@TypeOf(input.operation), input.operation, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateFirewallDomainsOutput {
    const result: UpdateFirewallDomainsOutput = try aws.json.parseJsonObject(
        UpdateFirewallDomainsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

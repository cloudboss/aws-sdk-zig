const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FirewallDomainUpdateOperation = @import("firewall_domain_update_operation.zig").FirewallDomainUpdateOperation;
const FirewallDomainListStatus = @import("firewall_domain_list_status.zig").FirewallDomainListStatus;

pub const UpdateFirewallDomainsInput = struct {
    /// A list of domains to use in the update operation.
    ///
    /// There is a limit of 1000 domains per request.
    ///
    /// Each domain specification in your domain list must satisfy the following
    /// requirements:
    ///
    /// * It can optionally start with `*` (asterisk).
    ///
    /// * With the exception of the optional starting asterisk, it must only contain
    /// the following characters: `A-Z`, `a-z`,
    /// `0-9`, `-` (hyphen).
    ///
    /// * It must be from 1-255 characters in length.
    domains: []const []const u8,

    /// The ID of the domain list whose domains you want to update.
    firewall_domain_list_id: []const u8,

    /// What you want DNS Firewall to do with the domains that you are providing:
    ///
    /// * `ADD` - Add the domains to the ones that are already in the domain list.
    ///
    /// * `REMOVE` - Search the domain list for the domains and remove them from the
    ///   list.
    ///
    /// * `REPLACE` - Update the domain list to exactly match the list that you are
    ///   providing.
    operation: FirewallDomainUpdateOperation,

    pub const json_field_names = .{
        .domains = "Domains",
        .firewall_domain_list_id = "FirewallDomainListId",
        .operation = "Operation",
    };
};

pub const UpdateFirewallDomainsOutput = struct {
    /// The ID of the firewall domain list that DNS Firewall just updated.
    id: ?[]const u8 = null,

    /// The name of the domain list.
    name: ?[]const u8 = null,

    /// Status of the `UpdateFirewallDomains` request.
    status: ?FirewallDomainListStatus = null,

    /// Additional information about the status of the list, if available.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "Id",
        .name = "Name",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateFirewallDomainsInput, options: CallOptions) !UpdateFirewallDomainsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateFirewallDomainsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Route53Resolver.UpdateFirewallDomains");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateFirewallDomainsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateFirewallDomainsOutput, body, allocator);
}

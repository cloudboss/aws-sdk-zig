const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FirewallRule = @import("firewall_rule.zig").FirewallRule;

pub const DeleteFirewallRuleInput = struct {
    /// The ID of the domain list that's used in the rule.
    firewall_domain_list_id: ?[]const u8 = null,

    /// The unique identifier of the firewall rule group that you want to delete the
    /// rule from.
    firewall_rule_group_id: []const u8,

    /// The ID that is created for a DNS Firewall Advanced rule.
    firewall_threat_protection_id: ?[]const u8 = null,

    /// The DNS query type that the rule you are deleting evaluates. Allowed values
    /// are;
    ///
    /// * A: Returns an IPv4 address.
    ///
    /// * AAAA: Returns an Ipv6 address.
    ///
    /// * CAA: Restricts CAs that can create SSL/TLS certifications for the domain.
    ///
    /// * CNAME: Returns another domain name.
    ///
    /// * DS: Record that identifies the DNSSEC signing key of a delegated zone.
    ///
    /// * MX: Specifies mail servers.
    ///
    /// * NAPTR: Regular-expression-based rewriting of domain names.
    ///
    /// * NS: Authoritative name servers.
    ///
    /// * PTR: Maps an IP address to a domain name.
    ///
    /// * SOA: Start of authority record for the zone.
    ///
    /// * SPF: Lists the servers authorized to send emails from a domain.
    ///
    /// * SRV: Application specific values that identify servers.
    ///
    /// * TXT: Verifies email senders and application-specific values.
    ///
    /// * A query type you define by using the DNS type ID, for example 28 for AAAA.
    ///   The values must be
    /// defined as TYPENUMBER, where the
    /// NUMBER can be 1-65534, for
    /// example, TYPE28. For more information, see
    /// [List of DNS record
    /// types](https://en.wikipedia.org/wiki/List_of_DNS_record_types).
    qtype: ?[]const u8 = null,

    pub const json_field_names = .{
        .firewall_domain_list_id = "FirewallDomainListId",
        .firewall_rule_group_id = "FirewallRuleGroupId",
        .firewall_threat_protection_id = "FirewallThreatProtectionId",
        .qtype = "Qtype",
    };
};

pub const DeleteFirewallRuleOutput = struct {
    /// The specification for the firewall rule that you just deleted.
    firewall_rule: ?FirewallRule = null,

    pub const json_field_names = .{
        .firewall_rule = "FirewallRule",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteFirewallRuleInput, options: CallOptions) !DeleteFirewallRuleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteFirewallRuleInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Route53Resolver.DeleteFirewallRule");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteFirewallRuleOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeleteFirewallRuleOutput, body, allocator);
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FirewallRuleTypeDefinition = @import("firewall_rule_type_definition.zig").FirewallRuleTypeDefinition;

pub const ListFirewallRuleTypesInput = struct {
    /// The maximum number of objects that you want Resolver to return for this
    /// request. If more objects are available, in the response, Resolver provides a
    /// `NextToken` value that you can use in a subsequent call to get the next
    /// batch of objects.
    max_results: ?i32 = null,

    /// For the first call to this list request, omit this value. When you request a
    /// list of objects, Resolver returns at most the number of objects specified in
    /// `MaxResults`. If more objects are available for retrieval, Resolver provides
    /// a `NextToken` value in the response. To retrieve the next batch of objects,
    /// use the token that was returned for the prior request in your next request.
    next_token: ?[]const u8 = null,

    /// An optional filter that restricts the response to a single FirewallRuleType
    /// variant. Supported values: `FirewallAdvancedContentCategory`,
    /// `FirewallAdvancedThreatCategory`, `DnsThreatProtection`, and
    /// `PartnerThreatProtection`. If omitted, definitions across all variants are
    /// returned.
    rule_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .rule_type = "RuleType",
    };
};

pub const ListFirewallRuleTypesOutput = struct {
    /// A list of the available rule type definitions.
    firewall_rule_types: ?[]const FirewallRuleTypeDefinition = null,

    /// If objects are still available for retrieval, Resolver returns this token in
    /// the response. To retrieve the next batch of objects, provide this token in
    /// your next request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .firewall_rule_types = "FirewallRuleTypes",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListFirewallRuleTypesInput, options: CallOptions) !ListFirewallRuleTypesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListFirewallRuleTypesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Route53Resolver.ListFirewallRuleTypes");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListFirewallRuleTypesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListFirewallRuleTypesOutput, body, allocator);
}

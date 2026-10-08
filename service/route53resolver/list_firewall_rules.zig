const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Action = @import("action.zig").Action;
const FirewallRule = @import("firewall_rule.zig").FirewallRule;

pub const ListFirewallRulesInput = struct {
    /// Optional additional filter for the rules to retrieve.
    ///
    /// The action that DNS Firewall should take on a DNS query when it matches one
    /// of the domains in the rule's domain list, or a threat in a DNS Firewall
    /// Advanced rule:
    ///
    /// * `ALLOW` - Permit the request to go through. Not availabe for DNS Firewall
    ///   Advanced rules.
    ///
    /// * `ALERT` - Permit the request to go through but send an alert to the logs.
    ///
    /// * `BLOCK` - Disallow the request. If this is specified, additional handling
    ///   details are provided in the rule's `BlockResponse` setting.
    action: ?Action = null,

    /// The unique identifier of the firewall rule group that you want to retrieve
    /// the rules for.
    firewall_rule_group_id: []const u8,

    /// The maximum number of objects that you want Resolver to return for this
    /// request. If more
    /// objects are available, in the response, Resolver provides a
    /// `NextToken` value that you can use in a subsequent call to get the next
    /// batch of objects.
    ///
    /// If you don't specify a value for `MaxResults`, Resolver returns up to 100
    /// objects.
    max_results: ?i32 = null,

    /// For the first call to this list request, omit this value.
    ///
    /// When you request a list of objects, Resolver returns at most the number of
    /// objects
    /// specified in `MaxResults`. If more objects are available for retrieval,
    /// Resolver returns a `NextToken` value in the response. To retrieve the next
    /// batch of objects, use the token that was returned for the prior request in
    /// your next request.
    next_token: ?[]const u8 = null,

    /// Optional additional filter for the rules to retrieve.
    ///
    /// The setting that determines the processing order of the rules in a rule
    /// group. DNS Firewall
    /// processes the rules in a rule group by order of priority, starting from the
    /// lowest setting.
    priority: ?i32 = null,

    pub const json_field_names = .{
        .action = "Action",
        .firewall_rule_group_id = "FirewallRuleGroupId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .priority = "Priority",
    };
};

pub const ListFirewallRulesOutput = struct {
    /// A list of the rules that you have defined.
    ///
    /// This might be a partial list of the firewall rules that you've defined. For
    /// information,
    /// see `MaxResults`.
    firewall_rules: ?[]const FirewallRule = null,

    /// If objects are still available for retrieval, Resolver returns this token in
    /// the response.
    /// To retrieve the next batch of objects, provide this token in your next
    /// request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .firewall_rules = "FirewallRules",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListFirewallRulesInput, options: CallOptions) !ListFirewallRulesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListFirewallRulesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Route53Resolver.ListFirewallRules");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListFirewallRulesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListFirewallRulesOutput, body, allocator);
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Action = @import("action.zig").Action;
const BlockOverrideDnsType = @import("block_override_dns_type.zig").BlockOverrideDnsType;
const BlockResponse = @import("block_response.zig").BlockResponse;
const ConfidenceThreshold = @import("confidence_threshold.zig").ConfidenceThreshold;
const DnsThreatProtection = @import("dns_threat_protection.zig").DnsThreatProtection;
const FirewallDomainRedirectionAction = @import("firewall_domain_redirection_action.zig").FirewallDomainRedirectionAction;
const FirewallRule = @import("firewall_rule.zig").FirewallRule;

pub const CreateFirewallRuleInput = @import("create_firewall_rule_request.zig").CreateFirewallRuleRequest;

pub const CreateFirewallRuleOutput = @import("create_firewall_rule_response.zig").CreateFirewallRuleResponse;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFirewallRuleInput, options: CallOptions) !CreateFirewallRuleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateFirewallRuleInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Route53Resolver.CreateFirewallRule");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateFirewallRuleOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateFirewallRuleOutput, body, allocator);
}

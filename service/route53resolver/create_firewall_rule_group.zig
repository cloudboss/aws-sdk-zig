const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const FirewallRuleGroup = @import("firewall_rule_group.zig").FirewallRuleGroup;

pub const CreateFirewallRuleGroupInput = struct {
    /// A unique string defined by you to identify the request. This allows you to
    /// retry failed
    /// requests without the risk of running the operation twice. This can be any
    /// unique string,
    /// for example, a timestamp.
    creator_request_id: []const u8,

    /// A name that lets you identify the rule group, to manage and use it.
    name: []const u8,

    /// A list of the tag keys and values that you want to associate with the rule
    /// group.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .creator_request_id = "CreatorRequestId",
        .name = "Name",
        .tags = "Tags",
    };
};

pub const CreateFirewallRuleGroupOutput = struct {
    /// A collection of rules used to filter DNS network traffic.
    firewall_rule_group: ?FirewallRuleGroup = null,

    pub const json_field_names = .{
        .firewall_rule_group = "FirewallRuleGroup",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFirewallRuleGroupInput, options: CallOptions) !CreateFirewallRuleGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateFirewallRuleGroupInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Route53Resolver.CreateFirewallRuleGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateFirewallRuleGroupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateFirewallRuleGroupOutput, body, allocator);
}

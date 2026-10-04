const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MutationProtectionStatus = @import("mutation_protection_status.zig").MutationProtectionStatus;
const Tag = @import("tag.zig").Tag;
const FirewallRuleGroupAssociation = @import("firewall_rule_group_association.zig").FirewallRuleGroupAssociation;

pub const AssociateFirewallRuleGroupInput = struct {
    /// A unique string that identifies the request and that allows failed requests
    /// to be
    /// retried without the risk of running the operation twice. `CreatorRequestId`
    /// can be any unique string, for example, a date/time stamp.
    creator_request_id: []const u8,

    /// The unique identifier of the firewall rule group.
    firewall_rule_group_id: []const u8,

    /// If enabled, this setting disallows modification or removal of the
    /// association, to help prevent against accidentally altering DNS firewall
    /// protections.
    /// When you create the association, the default setting is `DISABLED`.
    mutation_protection: ?MutationProtectionStatus = null,

    /// A name that lets you identify the association, to manage and use it.
    name: []const u8,

    /// The setting that determines the processing order of the rule group among the
    /// rule
    /// groups that you associate with the specified VPC. DNS Firewall filters VPC
    /// traffic
    /// starting from the rule group with the lowest numeric priority setting.
    ///
    /// You must specify a unique priority for each rule group that you associate
    /// with a single VPC.
    /// To make it easier to insert rule groups later, leave space between the
    /// numbers, for example, use 101, 200, and so on. You
    /// can change the priority setting for a rule group association after you
    /// create it.
    ///
    /// The allowed values for `Priority` are between 100 and 9900.
    priority: i32,

    /// A list of the tag keys and values that you want to associate with the rule
    /// group association.
    tags: ?[]const Tag = null,

    /// The unique identifier of the VPC that you want to associate with the rule
    /// group.
    vpc_id: []const u8,

    pub const json_field_names = .{
        .creator_request_id = "CreatorRequestId",
        .firewall_rule_group_id = "FirewallRuleGroupId",
        .mutation_protection = "MutationProtection",
        .name = "Name",
        .priority = "Priority",
        .tags = "Tags",
        .vpc_id = "VpcId",
    };
};

pub const AssociateFirewallRuleGroupOutput = struct {
    /// The association that you just created. The association has an ID that you
    /// can use to
    /// identify it in other requests, like update and delete.
    firewall_rule_group_association: ?FirewallRuleGroupAssociation = null,

    pub const json_field_names = .{
        .firewall_rule_group_association = "FirewallRuleGroupAssociation",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateFirewallRuleGroupInput, options: CallOptions) !AssociateFirewallRuleGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateFirewallRuleGroupInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Route53Resolver.AssociateFirewallRuleGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateFirewallRuleGroupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(AssociateFirewallRuleGroupOutput, body, allocator);
}

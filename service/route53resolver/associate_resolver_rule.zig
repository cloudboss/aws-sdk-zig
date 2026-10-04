const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResolverRuleAssociation = @import("resolver_rule_association.zig").ResolverRuleAssociation;

pub const AssociateResolverRuleInput = struct {
    /// A name for the association that you're creating between a Resolver rule and
    /// a VPC.
    ///
    /// The name can be up to 64 characters long and can contain letters (a-z, A-Z),
    /// numbers (0-9), hyphens (-), underscores (_), and spaces. The name cannot
    /// consist of only numbers.
    name: ?[]const u8 = null,

    /// The ID of the Resolver rule that you want to associate with the VPC. To list
    /// the existing Resolver rules, use
    /// [ListResolverRules](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_ListResolverRules.html).
    resolver_rule_id: []const u8,

    /// The ID of the VPC that you want to associate the Resolver rule with.
    vpc_id: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .resolver_rule_id = "ResolverRuleId",
        .vpc_id = "VPCId",
    };
};

pub const AssociateResolverRuleOutput = struct {
    /// Information about the `AssociateResolverRule` request, including the status
    /// of the request.
    resolver_rule_association: ?ResolverRuleAssociation = null,

    pub const json_field_names = .{
        .resolver_rule_association = "ResolverRuleAssociation",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateResolverRuleInput, options: CallOptions) !AssociateResolverRuleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateResolverRuleInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Route53Resolver.AssociateResolverRule");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateResolverRuleOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(AssociateResolverRuleOutput, body, allocator);
}

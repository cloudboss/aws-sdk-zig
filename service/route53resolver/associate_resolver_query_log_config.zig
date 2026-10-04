const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResolverQueryLogConfigAssociation = @import("resolver_query_log_config_association.zig").ResolverQueryLogConfigAssociation;

pub const AssociateResolverQueryLogConfigInput = struct {
    /// The ID of the query logging configuration that you want to associate a VPC
    /// with.
    resolver_query_log_config_id: []const u8,

    /// The ID of an Amazon VPC that you want this query logging configuration to
    /// log queries for.
    ///
    /// The VPCs and the query logging configuration must be in the same Region.
    resource_id: []const u8,

    pub const json_field_names = .{
        .resolver_query_log_config_id = "ResolverQueryLogConfigId",
        .resource_id = "ResourceId",
    };
};

pub const AssociateResolverQueryLogConfigOutput = struct {
    /// A complex type that contains settings for a specified association between an
    /// Amazon VPC and a query logging configuration.
    resolver_query_log_config_association: ?ResolverQueryLogConfigAssociation = null,

    pub const json_field_names = .{
        .resolver_query_log_config_association = "ResolverQueryLogConfigAssociation",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateResolverQueryLogConfigInput, options: CallOptions) !AssociateResolverQueryLogConfigOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateResolverQueryLogConfigInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Route53Resolver.AssociateResolverQueryLogConfig");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateResolverQueryLogConfigOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(AssociateResolverQueryLogConfigOutput, body, allocator);
}

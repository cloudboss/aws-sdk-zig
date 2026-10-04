const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Validation = @import("validation.zig").Validation;
const ResolverDnssecConfig = @import("resolver_dnssec_config.zig").ResolverDnssecConfig;

pub const UpdateResolverDnssecConfigInput = struct {
    /// The ID of the virtual private cloud (VPC) that you're updating the DNSSEC
    /// validation status for.
    resource_id: []const u8,

    /// The new value that you are specifying for DNSSEC validation for the VPC. The
    /// value can be `ENABLE`
    /// or `DISABLE`. Be aware that it can take time for a validation status change
    /// to be completed.
    validation: Validation,

    pub const json_field_names = .{
        .resource_id = "ResourceId",
        .validation = "Validation",
    };
};

pub const UpdateResolverDnssecConfigOutput = struct {
    /// A complex type that contains settings for the specified DNSSEC
    /// configuration.
    resolver_dnssec_config: ?ResolverDnssecConfig = null,

    pub const json_field_names = .{
        .resolver_dnssec_config = "ResolverDNSSECConfig",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateResolverDnssecConfigInput, options: CallOptions) !UpdateResolverDnssecConfigOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateResolverDnssecConfigInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Route53Resolver.UpdateResolverDnssecConfig");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateResolverDnssecConfigOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateResolverDnssecConfigOutput, body, allocator);
}

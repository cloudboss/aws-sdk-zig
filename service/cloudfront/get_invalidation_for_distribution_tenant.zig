const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Invalidation = @import("invalidation.zig").Invalidation;
const serde = @import("serde.zig");

pub const GetInvalidationForDistributionTenantInput = struct {
    /// The ID of the distribution tenant.
    distribution_tenant_id: []const u8,

    /// The ID of the invalidation to retrieve.
    id: []const u8,
};

pub const GetInvalidationForDistributionTenantOutput = struct {
    invalidation: ?Invalidation = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetInvalidationForDistributionTenantInput, options: CallOptions) !GetInvalidationForDistributionTenantOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudfront", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetInvalidationForDistributionTenantInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudfront", "CloudFront", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2020-05-31/distribution-tenant/");
    try path_buf.appendSlice(allocator, input.distribution_tenant_id);
    try path_buf.appendSlice(allocator, "/invalidation/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetInvalidationForDistributionTenantOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: GetInvalidationForDistributionTenantOutput = .{};

    return result;
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ManagedCertificateDetails = @import("managed_certificate_details.zig").ManagedCertificateDetails;
const serde = @import("serde.zig");

pub const GetManagedCertificateDetailsInput = struct {
    /// The identifier of the distribution tenant. You can specify the ARN, ID, or
    /// name of the distribution tenant.
    identifier: []const u8,
};

pub const GetManagedCertificateDetailsOutput = struct {
    /// Contains details about the CloudFront managed ACM certificate.
    managed_certificate_details: ?ManagedCertificateDetails = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetManagedCertificateDetailsInput, options: CallOptions) !GetManagedCertificateDetailsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetManagedCertificateDetailsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudfront", "CloudFront", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2020-05-31/managed-certificate/");
    try path_buf.appendSlice(allocator, input.identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetManagedCertificateDetailsOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: GetManagedCertificateDetailsOutput = .{};

    return result;
}

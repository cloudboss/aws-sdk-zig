const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Certificate = @import("certificate.zig").Certificate;
const serde = @import("serde.zig");

pub const RemoveListenerCertificatesInput = struct {
    /// The certificate to remove. You can specify one certificate per call. Set
    /// `CertificateArn` to the certificate ARN but do not set
    /// `IsDefault`.
    certificates: []const Certificate,

    /// The Amazon Resource Name (ARN) of the listener.
    listener_arn: []const u8,
};

pub const RemoveListenerCertificatesOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RemoveListenerCertificatesInput, options: CallOptions) !RemoveListenerCertificatesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticloadbalancing", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RemoveListenerCertificatesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticloadbalancing", "Elastic Load Balancing v2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=RemoveListenerCertificates&Version=2015-12-01");
    for (input.certificates, 0..) |item, idx| {
        const n = idx + 1;
        {
            var prefix_buf: [256]u8 = undefined;
            if (item.certificate_arn) |fv_1| {
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Certificates.member.{d}.CertificateArn=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            if (item.is_default) |fv_1| {
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Certificates.member.{d}.IsDefault=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_1) "true" else "false");
            }
        }
    }
    try body_buf.appendSlice(allocator, "&ListenerArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.listener_arn);

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RemoveListenerCertificatesOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: RemoveListenerCertificatesOutput = .{};

    return result;
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Certificate = @import("certificate.zig").Certificate;
const serde = @import("serde.zig");

pub const ModifyCertificatesInput = struct {
    /// The new default certificate identifier to override the current one with.
    ///
    /// To determine the valid values, use the `describe-certificates` CLI command
    /// or the `DescribeCertificates` API operation.
    certificate_identifier: ?[]const u8 = null,

    /// Specifies whether to remove the override for the default certificate. If the
    /// override is removed, the default certificate is the system default.
    remove_customer_override: ?bool = null,
};

pub const ModifyCertificatesOutput = struct {
    certificate: ?Certificate = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyCertificatesInput, options: CallOptions) !ModifyCertificatesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rds", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyCertificatesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyCertificates&Version=2014-10-31");
    if (input.certificate_identifier) |v| {
        try body_buf.appendSlice(allocator, "&CertificateIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.remove_customer_override) |v| {
        try body_buf.appendSlice(allocator, "&RemoveCustomerOverride=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyCertificatesOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifyCertificatesResult")) break;
            },
            else => {},
        }
    }

    var result: ModifyCertificatesOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Certificate")) {
                    result.certificate = try serde.deserializeCertificate(allocator, &reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}

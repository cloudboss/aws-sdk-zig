const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DnsConfiguration = @import("dns_configuration.zig").DnsConfiguration;
const serde = @import("serde.zig");

pub const VerifyDnsConfigurationInput = struct {
    /// The domain name that you're verifying.
    domain: ?[]const u8 = null,

    /// The identifier of the distribution tenant. You can specify the ARN, ID, or
    /// name of the distribution tenant.
    identifier: []const u8,
};

pub const VerifyDnsConfigurationOutput = struct {
    /// The list of domain names, their statuses, and a description of each status.
    dns_configuration_list: ?[]const DnsConfiguration = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: VerifyDnsConfigurationInput, options: CallOptions) !VerifyDnsConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: VerifyDnsConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudfront", "CloudFront", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2020-05-31/verify-dns-configuration";

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<VerifyDnsConfigurationRequest xmlns=\"http://cloudfront.amazonaws.com/doc/2020-05-31/\">");
    if (input.domain) |v| {
        try body_buf.appendSlice(allocator, "<Domain>");
        try aws.xml.appendXmlEscaped(allocator, &body_buf, v);
        try body_buf.appendSlice(allocator, "</Domain>");
    }
    try body_buf.appendSlice(allocator, "<Identifier>");
    try aws.xml.appendXmlEscaped(allocator, &body_buf, input.identifier);
    try body_buf.appendSlice(allocator, "</Identifier>");
    try body_buf.appendSlice(allocator, "</VerifyDnsConfigurationRequest>");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/xml");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !VerifyDnsConfigurationOutput {
    var result: VerifyDnsConfigurationOutput = .{};
    _ = status;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DnsConfigurationList")) {
                    result.dns_configuration_list = try serde.deserializeDnsConfigurationList(allocator, &reader, "DnsConfiguration");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    _ = headers;

    return result;
}

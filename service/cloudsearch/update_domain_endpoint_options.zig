const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DomainEndpointOptions = @import("domain_endpoint_options.zig").DomainEndpointOptions;
const DomainEndpointOptionsStatus = @import("domain_endpoint_options_status.zig").DomainEndpointOptionsStatus;
const serde = @import("serde.zig");

pub const UpdateDomainEndpointOptionsInput = struct {
    /// Whether to require that all requests to the domain arrive over HTTPS. We
    /// recommend Policy-Min-TLS-1-2-2019-07 for TLSSecurityPolicy. For
    /// compatibility with older clients, the default is Policy-Min-TLS-1-0-2019-07.
    domain_endpoint_options: DomainEndpointOptions,

    /// A string that represents the name of a domain.
    domain_name: []const u8,
};

pub const UpdateDomainEndpointOptionsOutput = struct {
    /// The newly-configured domain endpoint options.
    domain_endpoint_options: ?DomainEndpointOptionsStatus = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDomainEndpointOptionsInput, options: CallOptions) !UpdateDomainEndpointOptionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudsearch", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDomainEndpointOptionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudsearch", "CloudSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=UpdateDomainEndpointOptions&Version=2013-01-01");
    if (input.domain_endpoint_options.enforce_https) |sv| {
        try body_buf.appendSlice(allocator, "&DomainEndpointOptions.EnforceHTTPS=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv) "true" else "false");
    }
    if (input.domain_endpoint_options.tls_security_policy) |sv| {
        try body_buf.appendSlice(allocator, "&DomainEndpointOptions.TLSSecurityPolicy=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv.wireName());
    }
    try body_buf.appendSlice(allocator, "&DomainName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.domain_name);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDomainEndpointOptionsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "UpdateDomainEndpointOptionsResult")) break;
            },
            else => {},
        }
    }

    var result: UpdateDomainEndpointOptionsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DomainEndpointOptions")) {
                    result.domain_endpoint_options = try serde.deserializeDomainEndpointOptionsStatus(allocator, &reader);
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

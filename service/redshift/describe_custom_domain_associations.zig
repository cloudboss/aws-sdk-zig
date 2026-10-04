const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Association = @import("association.zig").Association;
const serde = @import("serde.zig");

pub const DescribeCustomDomainAssociationsInput = struct {
    /// The certificate Amazon Resource Name (ARN) for the custom domain
    /// association.
    custom_domain_certificate_arn: ?[]const u8 = null,

    /// The custom domain name for the custom domain association.
    custom_domain_name: ?[]const u8 = null,

    /// The marker for the custom domain association.
    marker: ?[]const u8 = null,

    /// The maximum records setting for the associated custom domain.
    max_records: ?i32 = null,
};

pub const DescribeCustomDomainAssociationsOutput = struct {
    /// The associations for the custom domain.
    associations: ?[]const Association = null,

    /// The marker for the custom domain association.
    marker: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeCustomDomainAssociationsInput, options: CallOptions) !DescribeCustomDomainAssociationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "redshift", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeCustomDomainAssociationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeCustomDomainAssociations&Version=2012-12-01");
    if (input.custom_domain_certificate_arn) |v| {
        try body_buf.appendSlice(allocator, "&CustomDomainCertificateArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.custom_domain_name) |v| {
        try body_buf.appendSlice(allocator, "&CustomDomainName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.marker) |v| {
        try body_buf.appendSlice(allocator, "&Marker=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.max_records) |v| {
        try body_buf.appendSlice(allocator, "&MaxRecords=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeCustomDomainAssociationsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeCustomDomainAssociationsResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeCustomDomainAssociationsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Associations")) {
                    result.associations = try serde.deserializeAssociationList(allocator, &reader, "Association");
                } else if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try allocator.dupe(u8, try reader.readElementText());
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

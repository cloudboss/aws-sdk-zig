const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DistributionResourceId = @import("distribution_resource_id.zig").DistributionResourceId;
const serde = @import("serde.zig");

pub const UpdateDomainAssociationInput = struct {
    /// The domain to update.
    domain: []const u8,

    /// The value of the `ETag` identifier for the standard distribution or
    /// distribution tenant that will be associated with the domain.
    if_match: ?[]const u8 = null,

    /// The target standard distribution or distribution tenant resource for the
    /// domain. You can specify either `DistributionId` or `DistributionTenantId`,
    /// but not both.
    target_resource: DistributionResourceId,
};

pub const UpdateDomainAssociationOutput = struct {
    /// The domain that you're moving.
    domain: ?[]const u8 = null,

    /// The current version of the target standard distribution or distribution
    /// tenant that was associated with the domain.
    e_tag: ?[]const u8 = null,

    /// The intended destination for the domain.
    resource_id: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDomainAssociationInput, options: CallOptions) !UpdateDomainAssociationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDomainAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudfront", "CloudFront", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2020-05-31/domain-association";

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<UpdateDomainAssociationRequest xmlns=\"http://cloudfront.amazonaws.com/doc/2020-05-31/\">");
    try body_buf.appendSlice(allocator, "<Domain>");
    try aws.xml.appendXmlEscaped(allocator, &body_buf, input.domain);
    try body_buf.appendSlice(allocator, "</Domain>");
    try body_buf.appendSlice(allocator, "<TargetResource>");
    try serde.serializeDistributionResourceId(allocator, &body_buf, input.target_resource);
    try body_buf.appendSlice(allocator, "</TargetResource>");
    try body_buf.appendSlice(allocator, "</UpdateDomainAssociationRequest>");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/xml");
    if (input.if_match) |v| {
        try request.headers.put(allocator, "If-Match", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDomainAssociationOutput {
    var result: UpdateDomainAssociationOutput = .{};
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
                if (std.mem.eql(u8, e.local, "Domain")) {
                    result.domain = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceId")) {
                    result.resource_id = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    if (headers.get("etag")) |value| {
        result.e_tag = try allocator.dupe(u8, value);
    }

    return result;
}

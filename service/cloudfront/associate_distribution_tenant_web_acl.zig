const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const AssociateDistributionTenantWebACLInput = struct {
    /// The ID of the distribution tenant.
    id: []const u8,

    /// The current `ETag` of the distribution tenant. This value is returned in the
    /// response of the `GetDistributionTenant` API operation.
    if_match: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the WAF web ACL to associate.
    web_acl_arn: []const u8,
};

pub const AssociateDistributionTenantWebACLOutput = struct {
    /// The current version of the distribution tenant.
    e_tag: ?[]const u8 = null,

    /// The ID of the distribution tenant.
    id: ?[]const u8 = null,

    /// The ARN of the WAF web ACL that you associated with the distribution tenant.
    web_acl_arn: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateDistributionTenantWebACLInput, options: CallOptions) !AssociateDistributionTenantWebACLOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateDistributionTenantWebACLInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudfront", "CloudFront", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2020-05-31/distribution-tenant/");
    try path_buf.appendSlice(allocator, input.id);
    try path_buf.appendSlice(allocator, "/associate-web-acl");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<AssociateDistributionTenantWebACLRequest xmlns=\"http://cloudfront.amazonaws.com/doc/2020-05-31/\">");
    try body_buf.appendSlice(allocator, "<WebACLArn>");
    try aws.xml.appendXmlEscaped(allocator, &body_buf, input.web_acl_arn);
    try body_buf.appendSlice(allocator, "</WebACLArn>");
    try body_buf.appendSlice(allocator, "</AssociateDistributionTenantWebACLRequest>");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateDistributionTenantWebACLOutput {
    var result: AssociateDistributionTenantWebACLOutput = .{};
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
                if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "WebACLArn")) {
                    result.web_acl_arn = try allocator.dupe(u8, try reader.readElementText());
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

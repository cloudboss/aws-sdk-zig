const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthorizationStatus = @import("authorization_status.zig").AuthorizationStatus;
const serde = @import("serde.zig");

pub const RevokeEndpointAccessInput = struct {
    /// The Amazon Web Services account ID whose access is to be revoked.
    account: ?[]const u8 = null,

    /// The cluster to revoke access from.
    cluster_identifier: ?[]const u8 = null,

    /// Indicates whether to force the revoke action.
    /// If true, the Redshift-managed VPC endpoints associated with the endpoint
    /// authorization are also deleted.
    force: ?bool = null,

    /// The virtual private cloud (VPC) identifiers for which access is to be
    /// revoked.
    vpc_ids: ?[]const []const u8 = null,
};

pub const RevokeEndpointAccessOutput = @import("endpoint_authorization.zig").EndpointAuthorization;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RevokeEndpointAccessInput, options: CallOptions) !RevokeEndpointAccessOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RevokeEndpointAccessInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=RevokeEndpointAccess&Version=2012-12-01");
    if (input.account) |v| {
        try body_buf.appendSlice(allocator, "&Account=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.cluster_identifier) |v| {
        try body_buf.appendSlice(allocator, "&ClusterIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.force) |v| {
        try body_buf.appendSlice(allocator, "&Force=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.vpc_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&VpcIds.VpcIdentifier.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RevokeEndpointAccessOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "RevokeEndpointAccessResult")) break;
            },
            else => {},
        }
    }

    var result: RevokeEndpointAccessOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AllowedAllVPCs")) {
                    result.allowed_all_vp_cs = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "AllowedVPCs")) {
                    result.allowed_vp_cs = try serde.deserializeVpcIdentifierList(allocator, &reader, "VpcIdentifier");
                } else if (std.mem.eql(u8, e.local, "AuthorizeTime")) {
                    result.authorize_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ClusterIdentifier")) {
                    result.cluster_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ClusterStatus")) {
                    result.cluster_status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EndpointCount")) {
                    result.endpoint_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Grantee")) {
                    result.grantee = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Grantor")) {
                    result.grantor = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = AuthorizationStatus.fromWireName(try reader.readElementText());
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

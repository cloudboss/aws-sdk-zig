const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const serde = @import("serde.zig");

pub const CreateDBClusterEndpointInput = struct {
    /// The identifier to use for the new endpoint. This parameter is stored as a
    /// lowercase string.
    db_cluster_endpoint_identifier: []const u8,

    /// The DB cluster identifier of the DB cluster associated with the endpoint.
    /// This parameter is stored as a lowercase string.
    db_cluster_identifier: []const u8,

    /// The type of the endpoint, one of: `READER`, `WRITER`, `ANY`.
    endpoint_type: []const u8,

    /// List of DB instance identifiers that aren't part of the custom endpoint
    /// group. All other eligible instances are reachable through the custom
    /// endpoint. This parameter is relevant only if the list of static members is
    /// empty.
    excluded_members: ?[]const []const u8 = null,

    /// List of DB instance identifiers that are part of the custom endpoint group.
    static_members: ?[]const []const u8 = null,

    /// The tags to be assigned to the Amazon RDS resource.
    tags: ?[]const Tag = null,
};

pub const CreateDBClusterEndpointOutput = @import("db_cluster_endpoint.zig").DBClusterEndpoint;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDBClusterEndpointInput, options: CallOptions) !CreateDBClusterEndpointOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDBClusterEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateDBClusterEndpoint&Version=2014-10-31");
    try body_buf.appendSlice(allocator, "&DBClusterEndpointIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_cluster_endpoint_identifier);
    try body_buf.appendSlice(allocator, "&DBClusterIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_cluster_identifier);
    try body_buf.appendSlice(allocator, "&EndpointType=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.endpoint_type);
    if (input.excluded_members) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludedMembers.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.static_members) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&StaticMembers.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.key) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Key=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.value) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Value=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDBClusterEndpointOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateDBClusterEndpointResult")) break;
            },
            else => {},
        }
    }

    var result: CreateDBClusterEndpointOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CustomEndpointType")) {
                    result.custom_endpoint_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBClusterEndpointArn")) {
                    result.db_cluster_endpoint_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBClusterEndpointIdentifier")) {
                    result.db_cluster_endpoint_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBClusterEndpointResourceIdentifier")) {
                    result.db_cluster_endpoint_resource_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBClusterIdentifier")) {
                    result.db_cluster_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Endpoint")) {
                    result.endpoint = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EndpointType")) {
                    result.endpoint_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ExcludedMembers")) {
                    result.excluded_members = try serde.deserializeStringList(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "StaticMembers")) {
                    result.static_members = try serde.deserializeStringList(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
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

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const serde = @import("serde.zig");

pub const ModifyDBClusterEndpointInput = struct {
    /// The identifier of the endpoint to modify. This parameter is stored as a
    /// lowercase string.
    db_cluster_endpoint_identifier: []const u8,

    /// The type of the endpoint. One of: `READER`, `WRITER`, `ANY`.
    endpoint_type: ?[]const u8 = null,

    /// List of DB instance identifiers that aren't part of the custom endpoint
    /// group.
    /// All other eligible instances are reachable through the custom endpoint.
    /// Only relevant if the list of static members is empty.
    excluded_members: ?[]const []const u8 = null,

    /// List of DB instance identifiers that are part of the custom endpoint group.
    static_members: ?[]const []const u8 = null,
};

pub const ModifyDBClusterEndpointOutput = struct {
    /// The type associated with a custom endpoint. One of: `READER`,
    /// `WRITER`, `ANY`.
    custom_endpoint_type: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the endpoint.
    db_cluster_endpoint_arn: ?[]const u8 = null,

    /// The identifier associated with the endpoint. This parameter is stored as a
    /// lowercase string.
    db_cluster_endpoint_identifier: ?[]const u8 = null,

    /// A unique system-generated identifier for an endpoint. It remains the same
    /// for the whole life of the endpoint.
    db_cluster_endpoint_resource_identifier: ?[]const u8 = null,

    /// The DB cluster identifier of the DB cluster associated with the endpoint.
    /// This parameter is
    /// stored as a lowercase string.
    db_cluster_identifier: ?[]const u8 = null,

    /// The DNS address of the endpoint.
    endpoint: ?[]const u8 = null,

    /// The type of the endpoint. One of: `READER`, `WRITER`, `CUSTOM`.
    endpoint_type: ?[]const u8 = null,

    /// List of DB instance identifiers that aren't part of the custom endpoint
    /// group.
    /// All other eligible instances are reachable through the custom endpoint.
    /// Only relevant if the list of static members is empty.
    excluded_members: ?[]const []const u8 = null,

    /// List of DB instance identifiers that are part of the custom endpoint group.
    static_members: ?[]const []const u8 = null,

    /// The current status of the endpoint. One of: `creating`, `available`,
    /// `deleting`, `inactive`, `modifying`. The `inactive` state applies to an
    /// endpoint that cannot be used for a certain kind of cluster,
    /// such as a `writer` endpoint for a read-only secondary cluster in a global
    /// database.
    status: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyDBClusterEndpointInput, options: CallOptions) !ModifyDBClusterEndpointOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyDBClusterEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "Neptune", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyDBClusterEndpoint&Version=2014-10-31");
    try body_buf.appendSlice(allocator, "&DBClusterEndpointIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_cluster_endpoint_identifier);
    if (input.endpoint_type) |v| {
        try body_buf.appendSlice(allocator, "&EndpointType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyDBClusterEndpointOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifyDBClusterEndpointResult")) break;
            },
            else => {},
        }
    }

    var result: ModifyDBClusterEndpointOutput = .{};
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

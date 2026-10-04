const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const serde = @import("serde.zig");

pub const CreateDBShardGroupInput = struct {
    /// Specifies whether to create standby standby DB data access shard for the DB
    /// shard group. Valid values are the following:
    ///
    /// * 0 - Creates a DB shard group without a standby DB data access shard. This
    ///   is the default value.
    /// * 1 - Creates a DB shard group with a standby DB data access shard in a
    ///   different Availability Zone (AZ).
    /// * 2 - Creates a DB shard group with two standby DB data access shard in two
    ///   different AZs.
    compute_redundancy: ?i32 = null,

    /// The name of the primary DB cluster for the DB shard group.
    db_cluster_identifier: []const u8,

    /// The name of the DB shard group.
    db_shard_group_identifier: []const u8,

    /// The maximum capacity of the DB shard group in Aurora capacity units (ACUs).
    max_acu: f64,

    /// The minimum capacity of the DB shard group in Aurora capacity units (ACUs).
    min_acu: ?f64 = null,

    /// Specifies whether the DB shard group is publicly accessible.
    ///
    /// When the DB shard group is publicly accessible, its Domain Name System (DNS)
    /// endpoint resolves to the private IP address from within the DB shard group's
    /// virtual private cloud (VPC). It resolves to the public IP address from
    /// outside of the DB shard group's VPC. Access to the DB shard group is
    /// ultimately controlled by the security group it uses. That public access is
    /// not permitted if the security group assigned to the DB shard group doesn't
    /// permit it.
    ///
    /// When the DB shard group isn't publicly accessible, it is an internal DB
    /// shard group with a DNS name that resolves to a private IP address.
    ///
    /// Default: The default behavior varies depending on whether
    /// `DBSubnetGroupName` is specified.
    ///
    /// If `DBSubnetGroupName` isn't specified, and `PubliclyAccessible` isn't
    /// specified, the following applies:
    ///
    /// * If the default VPC in the target Region doesn’t have an internet gateway
    ///   attached to it, the DB shard group is private.
    /// * If the default VPC in the target Region has an internet gateway attached
    ///   to it, the DB shard group is public.
    ///
    /// If `DBSubnetGroupName` is specified, and `PubliclyAccessible` isn't
    /// specified, the following applies:
    ///
    /// * If the subnets are part of a VPC that doesn’t have an internet gateway
    ///   attached to it, the DB shard group is private.
    /// * If the subnets are part of a VPC that has an internet gateway attached to
    ///   it, the DB shard group is public.
    publicly_accessible: ?bool = null,

    tags: ?[]const Tag = null,
};

pub const CreateDBShardGroupOutput = @import("db_shard_group.zig").DBShardGroup;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDBShardGroupInput, options: CallOptions) !CreateDBShardGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDBShardGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateDBShardGroup&Version=2014-10-31");
    if (input.compute_redundancy) |v| {
        try body_buf.appendSlice(allocator, "&ComputeRedundancy=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    try body_buf.appendSlice(allocator, "&DBClusterIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_cluster_identifier);
    try body_buf.appendSlice(allocator, "&DBShardGroupIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_shard_group_identifier);
    try body_buf.appendSlice(allocator, "&MaxACU=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{input.max_acu}) catch "");
    if (input.min_acu) |v| {
        try body_buf.appendSlice(allocator, "&MinACU=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.publicly_accessible) |v| {
        try body_buf.appendSlice(allocator, "&PubliclyAccessible=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDBShardGroupOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateDBShardGroupResult")) break;
            },
            else => {},
        }
    }

    var result: CreateDBShardGroupOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ComputeRedundancy")) {
                    result.compute_redundancy = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "DBClusterIdentifier")) {
                    result.db_cluster_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBShardGroupArn")) {
                    result.db_shard_group_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBShardGroupIdentifier")) {
                    result.db_shard_group_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBShardGroupResourceId")) {
                    result.db_shard_group_resource_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Endpoint")) {
                    result.endpoint = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MaxACU")) {
                    result.max_acu = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "MinACU")) {
                    result.min_acu = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "PubliclyAccessible")) {
                    result.publicly_accessible = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TagList")) {
                    result.tag_list = try serde.deserializeTagList(allocator, &reader, "Tag");
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

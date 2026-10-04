const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const serde = @import("serde.zig");

pub const ModifyDBShardGroupInput = struct {
    /// Specifies whether to create standby DB shard groups for the DB shard group.
    /// Valid values are the following:
    ///
    /// * 0 - Creates a DB shard group without a standby DB shard group. This is the
    ///   default value.
    /// * 1 - Creates a DB shard group with a standby DB shard group in a different
    ///   Availability Zone (AZ).
    /// * 2 - Creates a DB shard group with two standby DB shard groups in two
    ///   different AZs.
    compute_redundancy: ?i32 = null,

    /// The name of the DB shard group to modify.
    db_shard_group_identifier: []const u8,

    /// The maximum capacity of the DB shard group in Aurora capacity units (ACUs).
    max_acu: ?f64 = null,

    /// The minimum capacity of the DB shard group in Aurora capacity units (ACUs).
    min_acu: ?f64 = null,
};

pub const ModifyDBShardGroupOutput = @import("db_shard_group.zig").DBShardGroup;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyDBShardGroupInput, options: CallOptions) !ModifyDBShardGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyDBShardGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyDBShardGroup&Version=2014-10-31");
    if (input.compute_redundancy) |v| {
        try body_buf.appendSlice(allocator, "&ComputeRedundancy=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    try body_buf.appendSlice(allocator, "&DBShardGroupIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_shard_group_identifier);
    if (input.max_acu) |v| {
        try body_buf.appendSlice(allocator, "&MaxACU=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.min_acu) |v| {
        try body_buf.appendSlice(allocator, "&MinACU=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyDBShardGroupOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifyDBShardGroupResult")) break;
            },
            else => {},
        }
    }

    var result: ModifyDBShardGroupOutput = .{};
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

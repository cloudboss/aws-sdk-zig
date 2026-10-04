const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UserGroupPendingChanges = @import("user_group_pending_changes.zig").UserGroupPendingChanges;
const serde = @import("serde.zig");

pub const ModifyUserGroupInput = struct {
    /// Modifies the engine listed in a user group. The options are valkey or redis.
    engine: ?[]const u8 = null,

    /// The ID of the user group.
    user_group_id: []const u8,

    /// The list of user IDs to add to the user group.
    user_ids_to_add: ?[]const []const u8 = null,

    /// The list of user IDs to remove from the user group.
    user_ids_to_remove: ?[]const []const u8 = null,
};

pub const ModifyUserGroupOutput = @import("user_group.zig").UserGroup;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyUserGroupInput, options: CallOptions) !ModifyUserGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticache", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyUserGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticache", "ElastiCache", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyUserGroup&Version=2015-02-02");
    if (input.engine) |v| {
        try body_buf.appendSlice(allocator, "&Engine=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&UserGroupId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.user_group_id);
    if (input.user_ids_to_add) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&UserIdsToAdd.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.user_ids_to_remove) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&UserIdsToRemove.member.{d}=", .{n}) catch continue;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyUserGroupOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifyUserGroupResult")) break;
            },
            else => {},
        }
    }

    var result: ModifyUserGroupOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ARN")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MinimumEngineVersion")) {
                    result.minimum_engine_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PendingChanges")) {
                    result.pending_changes = try serde.deserializeUserGroupPendingChanges(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "ReplicationGroups")) {
                    result.replication_groups = try serde.deserializeUGReplicationGroupIdList(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "ServerlessCaches")) {
                    result.serverless_caches = try serde.deserializeUGServerlessCacheIdList(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UserGroupId")) {
                    result.user_group_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UserIds")) {
                    result.user_ids = try serde.deserializeUserIdList(allocator, &reader, "member");
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

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConfigureShard = @import("configure_shard.zig").ConfigureShard;
const ReplicationGroup = @import("replication_group.zig").ReplicationGroup;
const serde = @import("serde.zig");

pub const IncreaseReplicaCountInput = struct {
    /// If `True`, the number of replica nodes is increased immediately.
    /// `ApplyImmediately=False` is not currently supported.
    apply_immediately: bool,

    /// The number of read replica nodes you want at the completion of this
    /// operation. For Valkey or Redis OSS (cluster mode disabled) replication
    /// groups, this is the number of replica nodes in
    /// the replication group. For Valkey or Redis OSS (cluster mode enabled)
    /// replication groups, this is the
    /// number of replica nodes in each of the replication group's node groups.
    new_replica_count: ?i32 = null,

    /// A list of `ConfigureShard` objects that can be used to configure each
    /// shard in a Valkey or Redis OSS (cluster mode enabled) replication group. The
    /// `ConfigureShard` has three members: `NewReplicaCount`,
    /// `NodeGroupId`, and `PreferredAvailabilityZones`.
    replica_configuration: ?[]const ConfigureShard = null,

    /// The id of the replication group to which you want to add replica nodes.
    replication_group_id: []const u8,
};

pub const IncreaseReplicaCountOutput = struct {
    replication_group: ?ReplicationGroup = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: IncreaseReplicaCountInput, options: CallOptions) !IncreaseReplicaCountOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: IncreaseReplicaCountInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticache", "ElastiCache", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=IncreaseReplicaCount&Version=2015-02-02");
    try body_buf.appendSlice(allocator, "&ApplyImmediately=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, if (input.apply_immediately) "true" else "false");
    if (input.new_replica_count) |v| {
        try body_buf.appendSlice(allocator, "&NewReplicaCount=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.replica_configuration) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ReplicaConfiguration.ConfigureShard.{d}.NewReplicaCount=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{item.new_replica_count}) catch "");
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ReplicaConfiguration.ConfigureShard.{d}.NodeGroupId=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.node_group_id);
            }
            if (item.preferred_availability_zones) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ReplicaConfiguration.ConfigureShard.{d}.PreferredAvailabilityZones.PreferredAvailabilityZone.{d}=", .{ n, n_1 }) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, item_1);
                    }
                }
            }
            if (item.preferred_outpost_arns) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ReplicaConfiguration.ConfigureShard.{d}.PreferredOutpostArns.PreferredOutpostArn.{d}=", .{ n, n_1 }) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, item_1);
                    }
                }
            }
        }
    }
    try body_buf.appendSlice(allocator, "&ReplicationGroupId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.replication_group_id);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !IncreaseReplicaCountOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IncreaseReplicaCountResult")) break;
            },
            else => {},
        }
    }

    var result: IncreaseReplicaCountOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ReplicationGroup")) {
                    result.replication_group = try serde.deserializeReplicationGroup(allocator, &reader);
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

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReshardingConfiguration = @import("resharding_configuration.zig").ReshardingConfiguration;
const ReplicationGroup = @import("replication_group.zig").ReplicationGroup;
const serde = @import("serde.zig");

pub const ModifyReplicationGroupShardConfigurationInput = struct {
    /// Indicates that the shard reconfiguration process begins immediately. At
    /// present, the
    /// only permitted value for this parameter is `true`.
    ///
    /// Value: true
    apply_immediately: bool,

    /// The number of node groups (shards) that results from the modification of the
    /// shard
    /// configuration.
    node_group_count: i32,

    /// If the value of `NodeGroupCount` is less than the current number of node
    /// groups (shards), then either `NodeGroupsToRemove` or
    /// `NodeGroupsToRetain` is required. `NodeGroupsToRemove` is a
    /// list of `NodeGroupId`s to remove from the cluster.
    ///
    /// ElastiCache will attempt to remove all node groups listed by
    /// `NodeGroupsToRemove` from the cluster.
    node_groups_to_remove: ?[]const []const u8 = null,

    /// If the value of `NodeGroupCount` is less than the current number of node
    /// groups (shards), then either `NodeGroupsToRemove` or
    /// `NodeGroupsToRetain` is required. `NodeGroupsToRetain` is a
    /// list of `NodeGroupId`s to retain in the cluster.
    ///
    /// ElastiCache will attempt to remove all node groups except those listed by
    /// `NodeGroupsToRetain` from the cluster.
    node_groups_to_retain: ?[]const []const u8 = null,

    /// The name of the Valkey or Redis OSS (cluster mode enabled) cluster
    /// (replication group) on which the
    /// shards are to be configured.
    replication_group_id: []const u8,

    /// Specifies the preferred availability zones for each node group in the
    /// cluster. If the
    /// value of `NodeGroupCount` is greater than the current number of node groups
    /// (shards), you can use this parameter to specify the preferred availability
    /// zones of the
    /// cluster's shards. If you omit this parameter ElastiCache selects
    /// availability zones for
    /// you.
    ///
    /// You can specify this parameter only if the value of `NodeGroupCount` is
    /// greater than the current number of node groups (shards).
    resharding_configuration: ?[]const ReshardingConfiguration = null,
};

pub const ModifyReplicationGroupShardConfigurationOutput = struct {
    replication_group: ?ReplicationGroup = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyReplicationGroupShardConfigurationInput, options: CallOptions) !ModifyReplicationGroupShardConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyReplicationGroupShardConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticache", "ElastiCache", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyReplicationGroupShardConfiguration&Version=2015-02-02");
    try body_buf.appendSlice(allocator, "&ApplyImmediately=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, if (input.apply_immediately) "true" else "false");
    try body_buf.appendSlice(allocator, "&NodeGroupCount=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{input.node_group_count}) catch "");
    if (input.node_groups_to_remove) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NodeGroupsToRemove.NodeGroupToRemove.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.node_groups_to_retain) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NodeGroupsToRetain.NodeGroupToRetain.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    try body_buf.appendSlice(allocator, "&ReplicationGroupId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.replication_group_id);
    if (input.resharding_configuration) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.node_group_id) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ReshardingConfiguration.ReshardingConfiguration.{d}.NodeGroupId=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            if (item.preferred_availability_zones) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ReshardingConfiguration.ReshardingConfiguration.{d}.PreferredAvailabilityZones.AvailabilityZone.{d}=", .{ n, n_1 }) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, item_1);
                    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyReplicationGroupShardConfigurationOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifyReplicationGroupShardConfigurationResult")) break;
            },
            else => {},
        }
    }

    var result: ModifyReplicationGroupShardConfigurationOutput = .{};
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

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RegionalConfiguration = @import("regional_configuration.zig").RegionalConfiguration;
const GlobalReplicationGroup = @import("global_replication_group.zig").GlobalReplicationGroup;
const serde = @import("serde.zig");

pub const IncreaseNodeGroupsInGlobalReplicationGroupInput = struct {
    /// Indicates that the process begins immediately. At present, the only
    /// permitted value
    /// for this parameter is true.
    apply_immediately: bool,

    /// The name of the Global datastore
    global_replication_group_id: []const u8,

    /// Total number of node groups you want
    node_group_count: i32,

    /// Describes the replication group IDs, the Amazon regions where they are
    /// stored and the
    /// shard configuration for each that comprise the Global datastore
    regional_configurations: ?[]const RegionalConfiguration = null,
};

pub const IncreaseNodeGroupsInGlobalReplicationGroupOutput = struct {
    global_replication_group: ?GlobalReplicationGroup = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: IncreaseNodeGroupsInGlobalReplicationGroupInput, options: CallOptions) !IncreaseNodeGroupsInGlobalReplicationGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: IncreaseNodeGroupsInGlobalReplicationGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticache", "ElastiCache", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=IncreaseNodeGroupsInGlobalReplicationGroup&Version=2015-02-02");
    try body_buf.appendSlice(allocator, "&ApplyImmediately=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, if (input.apply_immediately) "true" else "false");
    try body_buf.appendSlice(allocator, "&GlobalReplicationGroupId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.global_replication_group_id);
    try body_buf.appendSlice(allocator, "&NodeGroupCount=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{input.node_group_count}) catch "");
    if (input.regional_configurations) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&RegionalConfigurations.RegionalConfiguration.{d}.ReplicationGroupId=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.replication_group_id);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&RegionalConfigurations.RegionalConfiguration.{d}.ReplicationGroupRegion=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.replication_group_region);
            }
            for (item.resharding_configuration, 0..) |item_1, idx_1| {
                const n_1 = idx_1 + 1;
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (item_1.node_group_id) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&RegionalConfigurations.RegionalConfiguration.{d}.ReshardingConfiguration.ReshardingConfiguration.{d}.NodeGroupId=", .{ n, n_1 }) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                if (item_1.preferred_availability_zones) |lst_2| {
                    for (lst_2, 0..) |item_2, idx_2| {
                        const n_2 = idx_2 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&RegionalConfigurations.RegionalConfiguration.{d}.ReshardingConfiguration.ReshardingConfiguration.{d}.PreferredAvailabilityZones.AvailabilityZone.{d}=", .{ n, n_1, n_2 }) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, item_2);
                        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !IncreaseNodeGroupsInGlobalReplicationGroupOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IncreaseNodeGroupsInGlobalReplicationGroupResult")) break;
            },
            else => {},
        }
    }

    var result: IncreaseNodeGroupsInGlobalReplicationGroupOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GlobalReplicationGroup")) {
                    result.global_replication_group = try serde.deserializeGlobalReplicationGroup(allocator, &reader);
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

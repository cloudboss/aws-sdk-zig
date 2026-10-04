const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ServiceUpdateStatus = @import("service_update_status.zig").ServiceUpdateStatus;
const TimeRangeFilter = @import("time_range_filter.zig").TimeRangeFilter;
const UpdateActionStatus = @import("update_action_status.zig").UpdateActionStatus;
const UpdateAction = @import("update_action.zig").UpdateAction;
const serde = @import("serde.zig");

pub const DescribeUpdateActionsInput = struct {
    /// The cache cluster IDs
    cache_cluster_ids: ?[]const []const u8 = null,

    /// The Elasticache engine to which the update applies. Either Valkey, Redis OSS
    /// or Memcached.
    engine: ?[]const u8 = null,

    /// An optional marker returned from a prior request. Use this marker for
    /// pagination of
    /// results from this operation. If this parameter is specified, the response
    /// includes only
    /// records beyond the marker, up to the value specified by `MaxRecords`.
    marker: ?[]const u8 = null,

    /// The maximum number of records to include in the response
    max_records: ?i32 = null,

    /// The replication group IDs
    replication_group_ids: ?[]const []const u8 = null,

    /// The unique ID of the service update
    service_update_name: ?[]const u8 = null,

    /// The status of the service update
    service_update_status: ?[]const ServiceUpdateStatus = null,

    /// The range of time specified to search for service updates that are in
    /// available
    /// status
    service_update_time_range: ?TimeRangeFilter = null,

    /// Dictates whether to include node level update status in the response
    show_node_level_update_status: ?bool = null,

    /// The status of the update action.
    update_action_status: ?[]const UpdateActionStatus = null,
};

pub const DescribeUpdateActionsOutput = struct {
    /// An optional marker returned from a prior request. Use this marker for
    /// pagination of
    /// results from this operation. If this parameter is specified, the response
    /// includes only
    /// records beyond the marker, up to the value specified by `MaxRecords`.
    marker: ?[]const u8 = null,

    /// Returns a list of update actions
    update_actions: ?[]const UpdateAction = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeUpdateActionsInput, options: CallOptions) !DescribeUpdateActionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeUpdateActionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticache", "ElastiCache", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeUpdateActions&Version=2015-02-02");
    if (input.cache_cluster_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&CacheClusterIds.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.engine) |v| {
        try body_buf.appendSlice(allocator, "&Engine=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.marker) |v| {
        try body_buf.appendSlice(allocator, "&Marker=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.max_records) |v| {
        try body_buf.appendSlice(allocator, "&MaxRecords=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.replication_group_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ReplicationGroupIds.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.service_update_name) |v| {
        try body_buf.appendSlice(allocator, "&ServiceUpdateName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.service_update_status) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ServiceUpdateStatus.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item.wireName());
        }
    }
    if (input.service_update_time_range) |v| {
        if (v.end_time) |sv| {
            try body_buf.appendSlice(allocator, "&ServiceUpdateTimeRange.EndTime=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
        if (v.start_time) |sv| {
            try body_buf.appendSlice(allocator, "&ServiceUpdateTimeRange.StartTime=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
    }
    if (input.show_node_level_update_status) |v| {
        try body_buf.appendSlice(allocator, "&ShowNodeLevelUpdateStatus=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.update_action_status) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&UpdateActionStatus.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeUpdateActionsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeUpdateActionsResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeUpdateActionsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UpdateActions")) {
                    result.update_actions = try serde.deserializeUpdateActionList(allocator, &reader, "UpdateAction");
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

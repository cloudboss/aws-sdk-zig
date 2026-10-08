const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const SourceType = @import("source_type.zig").SourceType;
const Event = @import("event.zig").Event;
const serde = @import("serde.zig");

pub const DescribeEventsInput = struct {
    /// The number of minutes to retrieve events for.
    ///
    /// Default: 60
    duration: ?i32 = null,

    /// The end of the time interval for which to retrieve events, specified in ISO
    /// 8601 format. For more information about ISO 8601, go to the [ISO8601
    /// Wikipedia page.](http://en.wikipedia.org/wiki/ISO_8601)
    ///
    /// Example: 2009-07-08T18:00Z
    end_time: ?i64 = null,

    /// A list of event categories that trigger notifications for a event
    /// notification subscription.
    event_categories: ?[]const []const u8 = null,

    /// This parameter isn't currently supported.
    filters: ?[]const Filter = null,

    /// An optional pagination token provided by a previous DescribeEvents request.
    /// If this parameter is specified, the response includes only records beyond
    /// the marker, up to the value specified by `MaxRecords`.
    marker: ?[]const u8 = null,

    /// The maximum number of records to include in the response. If more records
    /// exist than the specified `MaxRecords` value, a pagination token called a
    /// marker is included in the response so that you can retrieve the remaining
    /// results.
    ///
    /// Default: 100
    ///
    /// Constraints: Minimum 20, maximum 100.
    max_records: ?i32 = null,

    /// The identifier of the event source for which events are returned. If not
    /// specified, then all sources are included in the response.
    ///
    /// Constraints:
    ///
    /// * If `SourceIdentifier` is supplied, `SourceType` must also be provided.
    /// * If the source type is a DB instance, a `DBInstanceIdentifier` value must
    ///   be supplied.
    /// * If the source type is a DB cluster, a `DBClusterIdentifier` value must be
    ///   supplied.
    /// * If the source type is a DB parameter group, a `DBParameterGroupName` value
    ///   must be supplied.
    /// * If the source type is a DB security group, a `DBSecurityGroupName` value
    ///   must be supplied.
    /// * If the source type is a DB snapshot, a `DBSnapshotIdentifier` value must
    ///   be supplied.
    /// * If the source type is a DB cluster snapshot, a
    ///   `DBClusterSnapshotIdentifier` value must be supplied.
    /// * If the source type is an RDS Proxy, a `DBProxyName` value must be
    ///   supplied.
    /// * Can't end with a hyphen or contain two consecutive hyphens.
    source_identifier: ?[]const u8 = null,

    /// The event source to retrieve events for. If no value is specified, all
    /// events are returned.
    source_type: ?SourceType = null,

    /// The beginning of the time interval to retrieve events for, specified in ISO
    /// 8601 format. For more information about ISO 8601, go to the [ISO8601
    /// Wikipedia page.](http://en.wikipedia.org/wiki/ISO_8601)
    ///
    /// Example: 2009-07-08T18:00Z
    start_time: ?i64 = null,
};

pub const DescribeEventsOutput = struct {
    /// A list of `Event` instances.
    events: ?[]const Event = null,

    /// An optional pagination token provided by a previous Events request. If this
    /// parameter is specified, the response includes only records beyond the
    /// marker, up to the value specified by `MaxRecords`.
    marker: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeEventsInput, options: CallOptions) !DescribeEventsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeEventsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeEvents&Version=2014-10-31");
    if (input.duration) |v| {
        try body_buf.appendSlice(allocator, "&Duration=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.end_time) |v| {
        try body_buf.appendSlice(allocator, "&EndTime=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.event_categories) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&EventCategories.EventCategory.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.filters) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filters.Filter.{d}.Name=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.name);
            }
            for (item.values, 0..) |item_1, idx_1| {
                const n_1 = idx_1 + 1;
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filters.Filter.{d}.Values.Value.{d}=", .{ n, n_1 }) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_1);
                }
            }
        }
    }
    if (input.marker) |v| {
        try body_buf.appendSlice(allocator, "&Marker=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.max_records) |v| {
        try body_buf.appendSlice(allocator, "&MaxRecords=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.source_identifier) |v| {
        try body_buf.appendSlice(allocator, "&SourceIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.source_type) |v| {
        try body_buf.appendSlice(allocator, "&SourceType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.start_time) |v| {
        try body_buf.appendSlice(allocator, "&StartTime=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeEventsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeEventsResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeEventsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Events")) {
                    result.events = try serde.deserializeEventList(allocator, &reader, "Event");
                } else if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try allocator.dupe(u8, try reader.readElementText());
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

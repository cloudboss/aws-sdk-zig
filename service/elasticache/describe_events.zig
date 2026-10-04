const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SourceType = @import("source_type.zig").SourceType;
const Event = @import("event.zig").Event;
const serde = @import("serde.zig");

pub const DescribeEventsInput = struct {
    /// The number of minutes worth of events to retrieve.
    duration: ?i32 = null,

    /// The end of the time interval for which to retrieve events, specified in ISO
    /// 8601
    /// format.
    ///
    /// **Example:** 2017-03-30T07:03:49.555Z
    end_time: ?i64 = null,

    /// An optional marker returned from a prior request. Use this marker for
    /// pagination of
    /// results from this operation. If this parameter is specified, the response
    /// includes only
    /// records beyond the marker, up to the value specified by `MaxRecords`.
    marker: ?[]const u8 = null,

    /// The maximum number of records to include in the response. If more records
    /// exist than
    /// the specified `MaxRecords` value, a marker is included in the response so
    /// that the remaining results can be retrieved.
    ///
    /// Default: 100
    ///
    /// Constraints: minimum 20; maximum 100.
    max_records: ?i32 = null,

    /// The identifier of the event source for which events are returned. If not
    /// specified,
    /// all sources are included in the response.
    source_identifier: ?[]const u8 = null,

    /// The event source to retrieve events for. If no value is specified, all
    /// events are
    /// returned.
    source_type: ?SourceType = null,

    /// The beginning of the time interval to retrieve events for, specified in ISO
    /// 8601
    /// format.
    ///
    /// **Example:** 2017-03-30T07:03:49.555Z
    start_time: ?i64 = null,
};

pub const DescribeEventsOutput = struct {
    /// A list of events. Each element in the list contains detailed information
    /// about one
    /// event.
    events: ?[]const Event = null,

    /// Provides an identifier to allow retrieval of paginated results.
    marker: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeEventsInput, options: CallOptions) !DescribeEventsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeEventsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticache", "ElastiCache", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeEvents&Version=2015-02-02");
    if (input.duration) |v| {
        try body_buf.appendSlice(allocator, "&Duration=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.end_time) |v| {
        try body_buf.appendSlice(allocator, "&EndTime=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
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

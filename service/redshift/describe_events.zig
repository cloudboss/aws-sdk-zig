const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SourceType = @import("source_type.zig").SourceType;
const Event = @import("event.zig").Event;
const serde = @import("serde.zig");

pub const DescribeEventsInput = struct {
    /// The number of minutes prior to the time of the request for which to retrieve
    /// events. For example, if the request is sent at 18:00 and you specify a
    /// duration of 60,
    /// then only events which have occurred after 17:00 will be returned.
    ///
    /// Default: `60`
    duration: ?i32 = null,

    /// The end of the time interval for which to retrieve events, specified in ISO
    /// 8601
    /// format. For more information about ISO 8601, go to the [ISO8601 Wikipedia
    /// page.](http://en.wikipedia.org/wiki/ISO_8601)
    ///
    /// Example: `2009-07-08T18:00Z`
    end_time: ?i64 = null,

    /// An optional parameter that specifies the starting point to return a set of
    /// response
    /// records. When the results of a DescribeEvents request exceed the value
    /// specified in `MaxRecords`, Amazon Web Services returns a value in the
    /// `Marker`
    /// field of the response. You can retrieve the next set of response records by
    /// providing
    /// the returned marker value in the `Marker` parameter and retrying the
    /// request.
    marker: ?[]const u8 = null,

    /// The maximum number of response records to return in each call. If the number
    /// of
    /// remaining response records exceeds the specified `MaxRecords` value, a value
    /// is returned in a `marker` field of the response. You can retrieve the next
    /// set of records by retrying the command with the returned marker value.
    ///
    /// Default: `100`
    ///
    /// Constraints: minimum 20, maximum 100.
    max_records: ?i32 = null,

    /// The identifier of the event source for which events will be returned. If
    /// this
    /// parameter is not specified, then all sources are included in the response.
    ///
    /// Constraints:
    ///
    /// If *SourceIdentifier* is supplied,
    /// *SourceType* must also be provided.
    ///
    /// * Specify a cluster identifier when *SourceType* is
    /// `cluster`.
    ///
    /// * Specify a cluster security group name when *SourceType*
    /// is `cluster-security-group`.
    ///
    /// * Specify a cluster parameter group name when *SourceType*
    /// is `cluster-parameter-group`.
    ///
    /// * Specify a cluster snapshot identifier when *SourceType*
    /// is `cluster-snapshot`.
    source_identifier: ?[]const u8 = null,

    /// The event source to retrieve events for. If no value is specified, all
    /// events are
    /// returned.
    ///
    /// Constraints:
    ///
    /// If *SourceType* is supplied,
    /// *SourceIdentifier* must also be provided.
    ///
    /// * Specify `cluster` when *SourceIdentifier* is
    /// a cluster identifier.
    ///
    /// * Specify `cluster-security-group` when
    /// *SourceIdentifier* is a cluster security group
    /// name.
    ///
    /// * Specify `cluster-parameter-group` when
    /// *SourceIdentifier* is a cluster parameter group
    /// name.
    ///
    /// * Specify `cluster-snapshot` when
    /// *SourceIdentifier* is a cluster snapshot
    /// identifier.
    source_type: ?SourceType = null,

    /// The beginning of the time interval to retrieve events for, specified in ISO
    /// 8601
    /// format. For more information about ISO 8601, go to the [ISO8601 Wikipedia
    /// page.](http://en.wikipedia.org/wiki/ISO_8601)
    ///
    /// Example: `2009-07-08T18:00Z`
    start_time: ?i64 = null,
};

pub const DescribeEventsOutput = struct {
    /// A list of `Event` instances.
    events: ?[]const Event = null,

    /// A value that indicates the starting point for the next set of response
    /// records in a
    /// subsequent request. If a value is returned in a response, you can retrieve
    /// the next set
    /// of records by providing this returned marker value in the `Marker` parameter
    /// and retrying the command. If the `Marker` field is empty, all response
    /// records have been retrieved for the request.
    marker: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeEventsInput, options: CallOptions) !DescribeEventsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "redshift", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeEvents&Version=2012-12-01");
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

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const FleetEventType = @import("fleet_event_type.zig").FleetEventType;
const HistoryRecordEntry = @import("history_record_entry.zig").HistoryRecordEntry;
const serde = @import("serde.zig");

/// Describes the events for the specified EC2 Fleet during the specified time.
///
/// EC2 Fleet events are delayed by up to 30 seconds before they can be
/// described. This ensures
/// that you can query by the last evaluated time and not miss a recorded event.
/// EC2 Fleet events
/// are available for 48 hours.
///
/// For more information, see [Monitor fleet events using Amazon
/// EventBridge](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/fleet-monitor.html) in the
/// *Amazon EC2 User Guide*.
pub const DescribeFleetHistoryInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The type of events to describe. By default, all events are described.
    event_type: ?FleetEventType = null,

    /// The ID of the EC2 Fleet.
    fleet_id: []const u8,

    /// The maximum number of items to return for this request.
    /// To get the next page of items, make another request with the token returned
    /// in the output.
    /// For more information, see
    /// [Pagination](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Query-Requests.html#api-pagination).
    max_results: ?i32 = null,

    /// The token returned from a previous paginated request. Pagination continues
    /// from the end of the items returned by the previous request.
    next_token: ?[]const u8 = null,

    /// The start date and time for the events, in UTC format (for example,
    /// *YYYY*-*MM*-*DD*T*HH*:*MM*:*SS*Z).
    start_time: i64,
};

pub const DescribeFleetHistoryOutput = struct {
    /// The ID of the EC Fleet.
    fleet_id: ?[]const u8 = null,

    /// Information about the events in the history of the EC2 Fleet.
    history_records: ?[]const HistoryRecordEntry = null,

    /// The last date and time for the events, in UTC format (for example,
    /// *YYYY*-*MM*-*DD*T*HH*:*MM*:*SS*Z).
    /// All records up to this time were retrieved.
    ///
    /// If `nextToken` indicates that there are more items, this value is not
    /// present.
    last_evaluated_time: ?i64 = null,

    /// The token to include in another request to get the next page of items. This
    /// value is `null` when there
    /// are no more items to return.
    next_token: ?[]const u8 = null,

    /// The start date and time for the events, in UTC format (for example,
    /// *YYYY*-*MM*-*DD*T*HH*:*MM*:*SS*Z).
    start_time: ?i64 = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *DescribeFleetHistoryOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: DescribeFleetHistoryInput, options: Options) !DescribeFleetHistoryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ec2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status);
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeFleetHistoryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=DescribeFleetHistory&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.event_type) |v| {
        try body_buf.appendSlice(alloc, "&EventType=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    try body_buf.appendSlice(alloc, "&FleetId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.fleet_id);
    if (input.max_results) |v| {
        try body_buf.appendSlice(alloc, "&MaxResults=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(alloc, "&NextToken=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    try body_buf.appendSlice(alloc, "&StartTime=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{input.start_time}) catch "");

    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeFleetHistoryOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: DescribeFleetHistoryOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "fleetId")) {
                    result.fleet_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "historyRecordSet")) {
                    result.history_records = try serde.deserializeHistoryRecordSet(&reader, alloc, "item");
                } else if (std.mem.eql(u8, e.local, "lastEvaluatedTime")) {
                    result.last_evaluated_time = aws.imds.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "nextToken")) {
                    result.next_token = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "startTime")) {
                    result.start_time = aws.imds.parseIso8601(try reader.readElementText()) catch null;
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

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}

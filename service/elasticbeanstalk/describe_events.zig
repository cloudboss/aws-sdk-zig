const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EventSeverity = @import("event_severity.zig").EventSeverity;
const EventDescription = @import("event_description.zig").EventDescription;
const serde = @import("serde.zig");

pub const DescribeEventsInput = struct {
    /// If specified, Elastic Beanstalk restricts the returned descriptions to
    /// include only those associated with this application.
    application_name: ?[]const u8 = null,

    /// If specified, Elastic Beanstalk restricts the returned descriptions to those
    /// that occur up to, but not including, the `EndTime`.
    end_time: ?i64 = null,

    /// If specified, Elastic Beanstalk restricts the returned descriptions to those
    /// associated with this environment.
    environment_id: ?[]const u8 = null,

    /// If specified, Elastic Beanstalk restricts the returned descriptions to those
    /// associated with this environment.
    environment_name: ?[]const u8 = null,

    /// Specifies the maximum number of events that can be returned, beginning with
    /// the most recent event.
    max_records: ?i32 = null,

    /// Pagination token. If specified, the events return the next batch of results.
    next_token: ?[]const u8 = null,

    /// The ARN of a custom platform version. If specified, Elastic Beanstalk
    /// restricts the returned descriptions to those associated with this custom
    /// platform
    /// version.
    platform_arn: ?[]const u8 = null,

    /// If specified, Elastic Beanstalk restricts the described events to include
    /// only those associated with this request ID.
    request_id: ?[]const u8 = null,

    /// If specified, limits the events returned from this call to include only
    /// those with the specified severity or higher.
    severity: ?EventSeverity = null,

    /// If specified, Elastic Beanstalk restricts the returned descriptions to those
    /// that occur on or after this time.
    start_time: ?i64 = null,

    /// If specified, Elastic Beanstalk restricts the returned descriptions to those
    /// that are associated with this environment configuration.
    template_name: ?[]const u8 = null,

    /// If specified, Elastic Beanstalk restricts the returned descriptions to those
    /// associated with this application version.
    version_label: ?[]const u8 = null,
};

pub const DescribeEventsOutput = struct {
    /// A list of EventDescription.
    events: ?[]const EventDescription = null,

    /// If returned, this indicates that there are more results to obtain. Use this
    /// token in the next DescribeEvents call to get the next
    /// batch of events.
    next_token: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeEventsInput, options: CallOptions) !DescribeEventsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticbeanstalk", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("elasticbeanstalk", "Elastic Beanstalk", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeEvents&Version=2010-12-01");
    if (input.application_name) |v| {
        try body_buf.appendSlice(allocator, "&ApplicationName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.end_time) |v| {
        try body_buf.appendSlice(allocator, "&EndTime=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.environment_id) |v| {
        try body_buf.appendSlice(allocator, "&EnvironmentId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.environment_name) |v| {
        try body_buf.appendSlice(allocator, "&EnvironmentName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.max_records) |v| {
        try body_buf.appendSlice(allocator, "&MaxRecords=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(allocator, "&NextToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.platform_arn) |v| {
        try body_buf.appendSlice(allocator, "&PlatformArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.request_id) |v| {
        try body_buf.appendSlice(allocator, "&RequestId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.severity) |v| {
        try body_buf.appendSlice(allocator, "&Severity=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.start_time) |v| {
        try body_buf.appendSlice(allocator, "&StartTime=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.template_name) |v| {
        try body_buf.appendSlice(allocator, "&TemplateName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.version_label) |v| {
        try body_buf.appendSlice(allocator, "&VersionLabel=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
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
                    result.events = try serde.deserializeEventDescriptionList(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "NextToken")) {
                    result.next_token = try allocator.dupe(u8, try reader.readElementText());
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

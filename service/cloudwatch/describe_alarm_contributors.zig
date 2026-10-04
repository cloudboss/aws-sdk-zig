const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AlarmContributor = @import("alarm_contributor.zig").AlarmContributor;
const serde = @import("serde.zig");

pub const DescribeAlarmContributorsInput = struct {
    /// The name of the alarm for which to retrieve contributor information.
    alarm_name: []const u8,

    /// The token returned by a previous call to indicate that there is more data
    /// available.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .alarm_name = "AlarmName",
        .next_token = "NextToken",
    };
};

pub const DescribeAlarmContributorsOutput = struct {
    /// A list of alarm contributors that provide details about the individual time
    /// series contributing to the alarm's state.
    alarm_contributors: ?[]const AlarmContributor = null,

    /// The token that marks the start of the next batch of returned results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .alarm_contributors = "AlarmContributors",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAlarmContributorsInput, options: CallOptions) !DescribeAlarmContributorsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "monitoring", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAlarmContributorsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("monitoring", "CloudWatch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeAlarmContributors&Version=2010-08-01");
    try body_buf.appendSlice(allocator, "&AlarmName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.alarm_name);
    if (input.next_token) |v| {
        try body_buf.appendSlice(allocator, "&NextToken=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAlarmContributorsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeAlarmContributorsResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeAlarmContributorsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AlarmContributors")) {
                    result.alarm_contributors = try serde.deserializeAlarmContributors(allocator, &reader, "member");
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

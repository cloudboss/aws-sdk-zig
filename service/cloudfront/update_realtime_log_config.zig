const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EndPoint = @import("end_point.zig").EndPoint;
const RealtimeLogConfig = @import("realtime_log_config.zig").RealtimeLogConfig;
const serde = @import("serde.zig");

pub const UpdateRealtimeLogConfigInput = struct {
    /// The Amazon Resource Name (ARN) for this real-time log configuration.
    arn: ?[]const u8 = null,

    /// Contains information about the Amazon Kinesis data stream where you are
    /// sending real-time log data.
    end_points: ?[]const EndPoint = null,

    /// A list of fields to include in each real-time log record.
    ///
    /// For more information about fields, see [Real-time log configuration
    /// fields](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/real-time-logs.html#understand-real-time-log-config-fields) in the *Amazon CloudFront Developer Guide*.
    fields: ?[]const []const u8 = null,

    /// The name for this real-time log configuration.
    name: ?[]const u8 = null,

    /// The sampling rate for this real-time log configuration. The sampling rate
    /// determines the percentage of viewer requests that are represented in the
    /// real-time log data. You must provide an integer between 1 and 100,
    /// inclusive.
    sampling_rate: ?i64 = null,
};

pub const UpdateRealtimeLogConfigOutput = struct {
    /// A real-time log configuration.
    realtime_log_config: ?RealtimeLogConfig = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateRealtimeLogConfigInput, options: CallOptions) !UpdateRealtimeLogConfigOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudfront", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateRealtimeLogConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudfront", "CloudFront", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2020-05-31/realtime-log-config";

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<UpdateRealtimeLogConfigRequest xmlns=\"http://cloudfront.amazonaws.com/doc/2020-05-31/\">");
    if (input.arn) |v| {
        try body_buf.appendSlice(allocator, "<ARN>");
        try aws.xml.appendXmlEscaped(allocator, &body_buf, v);
        try body_buf.appendSlice(allocator, "</ARN>");
    }
    if (input.end_points) |v| {
        try body_buf.appendSlice(allocator, "<EndPoints>");
        try serde.serializeEndPointList(allocator, &body_buf, v, "member");
        try body_buf.appendSlice(allocator, "</EndPoints>");
    }
    if (input.fields) |v| {
        try body_buf.appendSlice(allocator, "<Fields>");
        try serde.serializeFieldList(allocator, &body_buf, v, "Field");
        try body_buf.appendSlice(allocator, "</Fields>");
    }
    if (input.name) |v| {
        try body_buf.appendSlice(allocator, "<Name>");
        try aws.xml.appendXmlEscaped(allocator, &body_buf, v);
        try body_buf.appendSlice(allocator, "</Name>");
    }
    if (input.sampling_rate) |v| {
        try body_buf.appendSlice(allocator, "<SamplingRate>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try body_buf.appendSlice(allocator, num_str);
        }
        try body_buf.appendSlice(allocator, "</SamplingRate>");
    }
    try body_buf.appendSlice(allocator, "</UpdateRealtimeLogConfigRequest>");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/xml");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateRealtimeLogConfigOutput {
    var result: UpdateRealtimeLogConfigOutput = .{};
    _ = status;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "RealtimeLogConfig")) {
                    result.realtime_log_config = try serde.deserializeRealtimeLogConfig(allocator, &reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    _ = headers;

    return result;
}

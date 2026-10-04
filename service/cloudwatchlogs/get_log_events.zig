const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OutputLogEvent = @import("output_log_event.zig").OutputLogEvent;

pub const GetLogEventsInput = struct {
    /// The end of the time range, expressed as the number of milliseconds after
    /// `Jan 1,
    /// 1970 00:00:00 UTC`. Events with a timestamp equal to or later than this time
    /// are not
    /// included.
    end_time: ?i64 = null,

    /// The maximum number of log events returned. If you don't specify a limit, the
    /// default is
    /// as many log events as can fit in a response size of 1 MB (up to 10,000 log
    /// events).
    limit: ?i32 = null,

    /// Specify either the name or ARN of the log group to view events from. If the
    /// log group is
    /// in a source account and you are using a monitoring account, you must use the
    /// log group
    /// ARN.
    ///
    /// You must include either `logGroupIdentifier` or `logGroupName`,
    /// but not both.
    log_group_identifier: ?[]const u8 = null,

    /// The name of the log group.
    ///
    /// You must include either `logGroupIdentifier` or `logGroupName`,
    /// but not both.
    log_group_name: ?[]const u8 = null,

    /// The name of the log stream.
    log_stream_name: []const u8,

    /// The token for the next set of items to return. (You received this token from
    /// a previous
    /// call.)
    next_token: ?[]const u8 = null,

    /// If the value is true, the earliest log events are returned first. If the
    /// value is
    /// false, the latest log events are returned first. The default value is false.
    ///
    /// If you are using a previous `nextForwardToken` value as the
    /// `nextToken` in this operation, you must specify `true` for
    /// `startFromHead`.
    start_from_head: ?bool = null,

    /// The start of the time range, expressed as the number of milliseconds after
    /// `Jan 1,
    /// 1970 00:00:00 UTC`. Events with a timestamp equal to this time or later than
    /// this time
    /// are included. Events with a timestamp earlier than this time are not
    /// included.
    ///
    /// Set `startTime` explicitly to reduce the chances of empty pages in the
    /// response.
    start_time: ?i64 = null,

    /// Specify `true` to display the log event fields with all sensitive data
    /// unmasked
    /// and visible. The default is `false`.
    ///
    /// To use this operation with this parameter, you must be signed into an
    /// account with the
    /// `logs:Unmask` permission.
    unmask: ?bool = null,

    pub const json_field_names = .{
        .end_time = "endTime",
        .limit = "limit",
        .log_group_identifier = "logGroupIdentifier",
        .log_group_name = "logGroupName",
        .log_stream_name = "logStreamName",
        .next_token = "nextToken",
        .start_from_head = "startFromHead",
        .start_time = "startTime",
        .unmask = "unmask",
    };
};

pub const GetLogEventsOutput = struct {
    /// The events.
    events: ?[]const OutputLogEvent = null,

    /// The token for the next set of items in the backward direction. The token
    /// expires after
    /// 24 hours. This token is not null. If you have reached the end of the stream,
    /// it returns the
    /// same token you passed in.
    next_backward_token: ?[]const u8 = null,

    /// The token for the next set of items in the forward direction. The token
    /// expires after
    /// 24 hours. If you have reached the end of the stream, it returns the same
    /// token you passed
    /// in.
    next_forward_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .events = "events",
        .next_backward_token = "nextBackwardToken",
        .next_forward_token = "nextForwardToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetLogEventsInput, options: CallOptions) !GetLogEventsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "logs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetLogEventsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("logs", "CloudWatch Logs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.GetLogEvents");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetLogEventsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetLogEventsOutput, body, allocator);
}

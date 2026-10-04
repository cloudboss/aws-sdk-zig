const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OrderBy = @import("order_by.zig").OrderBy;
const LogStream = @import("log_stream.zig").LogStream;

pub const DescribeLogStreamsInput = struct {
    /// If the value is true, results are returned in descending order. If the value
    /// is to
    /// false, results are returned in ascending order. The default value is false.
    descending: ?bool = null,

    /// The maximum number of items returned. If you don't specify a value, the
    /// default is up
    /// to 50 items.
    limit: ?i32 = null,

    /// Specify either the name or ARN of the log group to view. If the log group is
    /// in a source
    /// account and you are using a monitoring account, you must use the log group
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

    /// The prefix to match.
    ///
    /// If `orderBy` is `LastEventTime`, you cannot specify this
    /// parameter.
    log_stream_name_prefix: ?[]const u8 = null,

    /// The token for the next set of items to return. (You received this token from
    /// a previous
    /// call.)
    next_token: ?[]const u8 = null,

    /// If the value is `LogStreamName`, the results are ordered by log stream name.
    /// If the value is `LastEventTime`, the results are ordered by the event time.
    /// The
    /// default value is `LogStreamName`.
    ///
    /// If you order the results by event time, you cannot specify the
    /// `logStreamNamePrefix` parameter.
    ///
    /// `lastEventTimestamp` represents the time of the most recent log event in the
    /// log stream in CloudWatch Logs. This number is expressed as the number of
    /// milliseconds after
    /// `Jan 1, 1970 00:00:00 UTC`. `lastEventTimestamp` updates on an
    /// eventual consistency basis. It typically updates in less than an hour from
    /// ingestion, but in
    /// rare situations might take longer.
    order_by: ?OrderBy = null,

    pub const json_field_names = .{
        .descending = "descending",
        .limit = "limit",
        .log_group_identifier = "logGroupIdentifier",
        .log_group_name = "logGroupName",
        .log_stream_name_prefix = "logStreamNamePrefix",
        .next_token = "nextToken",
        .order_by = "orderBy",
    };
};

pub const DescribeLogStreamsOutput = struct {
    /// The log streams.
    log_streams: ?[]const LogStream = null,

    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .log_streams = "logStreams",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeLogStreamsInput, options: CallOptions) !DescribeLogStreamsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeLogStreamsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.DescribeLogStreams");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeLogStreamsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeLogStreamsOutput, body, allocator);
}

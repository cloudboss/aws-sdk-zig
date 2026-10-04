const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StartLiveTailResponseStream = @import("start_live_tail_response_stream.zig").StartLiveTailResponseStream;

pub const StartLiveTailInput = struct {
    /// An optional pattern to use to filter the results to include only log events
    /// that match the
    /// pattern. For example, a filter pattern of `error 404` causes only log events
    /// that
    /// include both `error` and `404` to be included in the Live Tail
    /// stream.
    ///
    /// Regular expression filter patterns are supported.
    ///
    /// For more information about filter pattern syntax, see [Filter and Pattern
    /// Syntax](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/FilterAndPatternSyntax.html).
    log_event_filter_pattern: ?[]const u8 = null,

    /// An array where each item in the array is a log group to include in the Live
    /// Tail
    /// session.
    ///
    /// Specify each log group by its ARN.
    ///
    /// If you specify an ARN, the ARN can't end with an asterisk (*).
    ///
    /// You can include up to 10 log groups.
    log_group_identifiers: []const []const u8,

    /// If you specify this parameter, then only log events in the log streams that
    /// have names
    /// that start with the prefixes that you specify here are included in the Live
    /// Tail
    /// session.
    ///
    /// If you specify this field, you can't also specify the `logStreamNames`
    /// field.
    ///
    /// You can specify this parameter only if you specify only one log group in
    /// `logGroupIdentifiers`.
    log_stream_name_prefixes: ?[]const []const u8 = null,

    /// If you specify this parameter, then only log events in the log streams that
    /// you specify
    /// here are included in the Live Tail session.
    ///
    /// If you specify this field, you can't also specify the
    /// `logStreamNamePrefixes`
    /// field.
    ///
    /// You can specify this parameter only if you specify only one log group in
    /// `logGroupIdentifiers`.
    log_stream_names: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .log_event_filter_pattern = "logEventFilterPattern",
        .log_group_identifiers = "logGroupIdentifiers",
        .log_stream_name_prefixes = "logStreamNamePrefixes",
        .log_stream_names = "logStreamNames",
    };
};

pub const StartLiveTailOutput = struct {

    response_stream: aws.event_stream_reader.EventStreamReader = undefined,

    pub fn deinit(self: *StartLiveTailOutput) void {
        self.response_stream.deinit();
    }

    pub const json_field_names = .{
        .response_stream = "responseStream",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartLiveTailInput, options: CallOptions) !StartLiveTailOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "logs", client.config.http_client.clock_skew_offset);

    var stream_resp = try client.config.http_client.sendStreamingRequestWithOptions(&request, client.options);

    if (!stream_resp.isSuccess()) {
        defer stream_resp.deinit();
        const error_body = stream_resp.body.readAll(client.allocator, 10 * 1024 * 1024) catch return error.RequestFailed;
        defer client.allocator.free(error_body);
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, error_body, stream_resp.status);
        }
        return error.ServiceError;
    }

    errdefer stream_resp.deinit();
    const result = try deserializeStreamingResponse(allocator, &stream_resp);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: StartLiveTailInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.StartLiveTail");

    return request;
}

fn deserializeStreamingResponse(allocator: std.mem.Allocator, stream_resp: *aws.http.StreamingResponse) !StartLiveTailOutput {
    const result: StartLiveTailOutput = .{
        .response_stream = try aws.event_stream_reader.EventStreamReader.init(
            allocator,
            stream_resp.body,
        ),
    };
    stream_resp.deinitHeaders();
    return result;
}

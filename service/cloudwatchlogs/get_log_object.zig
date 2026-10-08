const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GetLogObjectResponseStream = @import("get_log_object_response_stream.zig").GetLogObjectResponseStream;

pub const GetLogObjectInput = struct {
    /// A pointer to the specific log object to retrieve. This is a required
    /// parameter that
    /// uniquely identifies the log object within CloudWatch Logs. The pointer is
    /// typically obtained
    /// from a previous query or filter operation.
    log_object_pointer: []const u8,

    /// A boolean flag that indicates whether to unmask sensitive log data. When set
    /// to true, any
    /// masked or redacted data in the log object will be displayed in its original
    /// form. Default is
    /// false.
    unmask: ?bool = null,

    pub const json_field_names = .{
        .log_object_pointer = "logObjectPointer",
        .unmask = "unmask",
    };
};

pub const GetLogObjectOutput = struct {
    field_stream: aws.event_stream_reader.EventStreamReader = undefined,

    pub fn deinit(self: *GetLogObjectOutput) void {
        self.field_stream.deinit();
    }

    pub const json_field_names = .{
        .field_stream = "fieldStream",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetLogObjectInput, options: CallOptions) !GetLogObjectOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetLogObjectInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.GetLogObject");

    return request;
}

fn deserializeStreamingResponse(allocator: std.mem.Allocator, stream_resp: *aws.http.StreamingResponse) !GetLogObjectOutput {
    const result: GetLogObjectOutput = .{
        .field_stream = try aws.event_stream_reader.EventStreamReader.init(
            allocator,
            stream_resp.body,
        ),
    };
    stream_resp.deinitHeaders();
    return result;
}

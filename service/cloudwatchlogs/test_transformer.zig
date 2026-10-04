const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Processor = @import("processor.zig").Processor;
const TransformedLogRecord = @import("transformed_log_record.zig").TransformedLogRecord;

pub const TestTransformerInput = struct {
    /// An array of the raw log events that you want to use to test this
    /// transformer.
    log_event_messages: []const []const u8,

    /// This structure contains the configuration of this log transformer that you
    /// want to test. A
    /// log transformer is an array of processors, where each processor applies one
    /// type of
    /// transformation to the log events that are ingested.
    transformer_config: []const Processor,

    pub const json_field_names = .{
        .log_event_messages = "logEventMessages",
        .transformer_config = "transformerConfig",
    };
};

pub const TestTransformerOutput = struct {
    /// An array where each member of the array includes both the original version
    /// and the
    /// transformed version of one of the log events that you input.
    transformed_logs: ?[]const TransformedLogRecord = null,

    pub const json_field_names = .{
        .transformed_logs = "transformedLogs",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: TestTransformerInput, options: CallOptions) !TestTransformerOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: TestTransformerInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.TestTransformer");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !TestTransformerOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(TestTransformerOutput, body, allocator);
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const TestEventPatternInput = struct {
    /// The event, in JSON format, to test against the event pattern. The JSON must
    /// follow the
    /// format specified in [Amazon Web Services
    /// Events](https://docs.aws.amazon.com/eventbridge/latest/userguide/aws-events.html), and
    /// the following fields are mandatory:
    ///
    /// * `id`
    ///
    /// * `account`
    ///
    /// * `source`
    ///
    /// * `time`
    ///
    /// * `region`
    ///
    /// * `resources`
    ///
    /// * `detail-type`
    event: []const u8,

    /// The event pattern. For more information, see [Events and Event
    /// Patterns](https://docs.aws.amazon.com/eventbridge/latest/userguide/eventbridge-and-event-patterns.html) in the *
    /// Amazon EventBridge User Guide*
    /// .
    event_pattern: []const u8,

    pub const json_field_names = .{
        .event = "Event",
        .event_pattern = "EventPattern",
    };
};

pub const TestEventPatternOutput = struct {
    /// Indicates whether the event matches the event pattern.
    result: ?bool = null,

    pub const json_field_names = .{
        .result = "Result",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: TestEventPatternInput, options: CallOptions) !TestEventPatternOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "events", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: TestEventPatternInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("events", "EventBridge", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSEvents.TestEventPattern");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !TestEventPatternOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(TestEventPatternOutput, body, allocator);
}

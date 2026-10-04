const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const IncreaseStreamRetentionPeriodInput = struct {
    /// The new retention period of the stream, in hours. Must be more than the
    /// current
    /// retention period.
    retention_period_hours: i32,

    /// The ARN of the stream.
    stream_arn: ?[]const u8 = null,

    /// Not Implemented. Reserved for future use.
    stream_id: ?[]const u8 = null,

    /// The name of the stream to modify.
    stream_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .retention_period_hours = "RetentionPeriodHours",
        .stream_arn = "StreamARN",
        .stream_id = "StreamId",
        .stream_name = "StreamName",
    };
};

pub const IncreaseStreamRetentionPeriodOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: IncreaseStreamRetentionPeriodInput, options: CallOptions) !IncreaseStreamRetentionPeriodOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kinesis", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: IncreaseStreamRetentionPeriodInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kinesis", "Kinesis", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Kinesis_20131202.IncreaseStreamRetentionPeriod");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !IncreaseStreamRetentionPeriodOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}

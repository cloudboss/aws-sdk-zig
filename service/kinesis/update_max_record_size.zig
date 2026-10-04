const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateMaxRecordSizeInput = struct {
    /// The maximum record size of a single record in KiB that you can write to, and
    /// read from a stream. Specify a value between 1024 and 10240 KiB (1 to 10
    /// MiB). If you specify a value that is out of this range,
    /// `UpdateMaxRecordSize` sends back an `ValidationException` message.
    max_record_size_in_ki_b: i32,

    /// The Amazon Resource Name (ARN) of the stream for the `MaxRecordSize` update.
    stream_arn: ?[]const u8 = null,

    /// Not Implemented. Reserved for future use.
    stream_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_record_size_in_ki_b = "MaxRecordSizeInKiB",
        .stream_arn = "StreamARN",
        .stream_id = "StreamId",
    };
};

pub const UpdateMaxRecordSizeOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateMaxRecordSizeInput, options: CallOptions) !UpdateMaxRecordSizeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateMaxRecordSizeInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Kinesis_20131202.UpdateMaxRecordSize");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateMaxRecordSizeOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WarmThroughputObject = @import("warm_throughput_object.zig").WarmThroughputObject;

pub const UpdateStreamWarmThroughputInput = struct {
    /// The ARN of the stream to be updated.
    stream_arn: ?[]const u8 = null,

    /// Not Implemented. Reserved for future use.
    stream_id: ?[]const u8 = null,

    /// The name of the stream to be updated.
    stream_name: ?[]const u8 = null,

    /// The target warm throughput in MB/s that the stream should be scaled to
    /// handle. This represents the throughput capacity that will be immediately
    /// available for write operations.
    warm_throughput_mi_bps: i32,

    pub const json_field_names = .{
        .stream_arn = "StreamARN",
        .stream_id = "StreamId",
        .stream_name = "StreamName",
        .warm_throughput_mi_bps = "WarmThroughputMiBps",
    };
};

pub const UpdateStreamWarmThroughputOutput = struct {
    /// The ARN of the stream that was updated.
    stream_arn: ?[]const u8 = null,

    /// The name of the stream that was updated.
    stream_name: ?[]const u8 = null,

    /// Specifies the updated warm throughput configuration for your data stream.
    warm_throughput: ?WarmThroughputObject = null,

    pub const json_field_names = .{
        .stream_arn = "StreamARN",
        .stream_name = "StreamName",
        .warm_throughput = "WarmThroughput",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateStreamWarmThroughputInput, options: CallOptions) !UpdateStreamWarmThroughputOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateStreamWarmThroughputInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Kinesis_20131202.UpdateStreamWarmThroughput");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateStreamWarmThroughputOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateStreamWarmThroughputOutput, body, allocator);
}

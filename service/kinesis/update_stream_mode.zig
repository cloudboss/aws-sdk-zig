const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StreamModeDetails = @import("stream_mode_details.zig").StreamModeDetails;

pub const UpdateStreamModeInput = struct {
    /// Specifies the ARN of the data stream whose capacity mode you want to update.
    stream_arn: []const u8,

    /// Not Implemented. Reserved for future use.
    stream_id: ?[]const u8 = null,

    /// Specifies the capacity mode to which you want to set your data stream.
    /// Currently, in
    /// Kinesis Data Streams, you can choose between an **on-demand** capacity mode
    /// and a **provisioned** capacity mode for your data streams.
    stream_mode_details: StreamModeDetails,

    /// The target warm throughput in MB/s that the stream should be scaled to
    /// handle. This represents the throughput capacity that will be immediately
    /// available for write operations. This field is only valid when the stream
    /// mode is being updated to on-demand.
    warm_throughput_mi_bps: ?i32 = null,

    pub const json_field_names = .{
        .stream_arn = "StreamARN",
        .stream_id = "StreamId",
        .stream_mode_details = "StreamModeDetails",
        .warm_throughput_mi_bps = "WarmThroughputMiBps",
    };
};

pub const UpdateStreamModeOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateStreamModeInput, options: CallOptions) !UpdateStreamModeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateStreamModeInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Kinesis_20131202.UpdateStreamMode");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateStreamModeOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}

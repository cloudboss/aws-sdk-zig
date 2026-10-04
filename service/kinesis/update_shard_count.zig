const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ScalingType = @import("scaling_type.zig").ScalingType;

pub const UpdateShardCountInput = struct {
    /// The scaling type. Uniform scaling creates shards of equal size.
    scaling_type: ScalingType,

    /// The ARN of the stream.
    stream_arn: ?[]const u8 = null,

    /// Not Implemented. Reserved for future use.
    stream_id: ?[]const u8 = null,

    /// The name of the stream.
    stream_name: ?[]const u8 = null,

    /// The new number of shards. This value has the following default limits. By
    /// default, you
    /// cannot do the following:
    ///
    /// * Set this value to more than double your current shard count for a
    /// stream.
    ///
    /// * Set this value below half your current shard count for a stream.
    ///
    /// * Set this value to more than 10000 shards in a stream (the default limit
    ///   for
    /// shard count per stream is 10000 per account per region), unless you request
    /// a
    /// limit increase.
    ///
    /// * Scale a stream with more than 10000 shards down unless you set this value
    ///   to
    /// less than 10000 shards.
    target_shard_count: i32,

    pub const json_field_names = .{
        .scaling_type = "ScalingType",
        .stream_arn = "StreamARN",
        .stream_id = "StreamId",
        .stream_name = "StreamName",
        .target_shard_count = "TargetShardCount",
    };
};

pub const UpdateShardCountOutput = struct {
    /// The current number of shards.
    current_shard_count: ?i32 = null,

    /// The ARN of the stream.
    stream_arn: ?[]const u8 = null,

    /// The name of the stream.
    stream_name: ?[]const u8 = null,

    /// The updated number of shards.
    target_shard_count: ?i32 = null,

    pub const json_field_names = .{
        .current_shard_count = "CurrentShardCount",
        .stream_arn = "StreamARN",
        .stream_name = "StreamName",
        .target_shard_count = "TargetShardCount",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateShardCountInput, options: CallOptions) !UpdateShardCountOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateShardCountInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Kinesis_20131202.UpdateShardCount");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateShardCountOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateShardCountOutput, body, allocator);
}

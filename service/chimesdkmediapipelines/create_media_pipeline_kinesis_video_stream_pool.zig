const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const KinesisVideoStreamConfiguration = @import("kinesis_video_stream_configuration.zig").KinesisVideoStreamConfiguration;
const Tag = @import("tag.zig").Tag;
const KinesisVideoStreamPoolConfiguration = @import("kinesis_video_stream_pool_configuration.zig").KinesisVideoStreamPoolConfiguration;

pub const CreateMediaPipelineKinesisVideoStreamPoolInput = struct {
    /// The token assigned to the client making the request.
    client_request_token: ?[]const u8 = null,

    /// The name of the pool.
    pool_name: []const u8,

    /// The configuration settings for the stream.
    stream_configuration: KinesisVideoStreamConfiguration,

    /// The tags assigned to the stream pool.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .pool_name = "PoolName",
        .stream_configuration = "StreamConfiguration",
        .tags = "Tags",
    };
};

pub const CreateMediaPipelineKinesisVideoStreamPoolOutput = struct {
    /// The configuration for applying the streams to the pool.
    kinesis_video_stream_pool_configuration: ?KinesisVideoStreamPoolConfiguration = null,

    pub const json_field_names = .{
        .kinesis_video_stream_pool_configuration = "KinesisVideoStreamPoolConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateMediaPipelineKinesisVideoStreamPoolInput, options: CallOptions) !CreateMediaPipelineKinesisVideoStreamPoolOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "chime", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateMediaPipelineKinesisVideoStreamPoolInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("media-pipelines-chime", "Chime SDK Media Pipelines", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/media-pipeline-kinesis-video-stream-pools";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_request_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientRequestToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PoolName\":");
    try aws.json.writeValue(@TypeOf(input.pool_name), input.pool_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"StreamConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.stream_configuration), input.stream_configuration, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateMediaPipelineKinesisVideoStreamPoolOutput {
    const result: CreateMediaPipelineKinesisVideoStreamPoolOutput = try aws.json.parseJsonObject(
        CreateMediaPipelineKinesisVideoStreamPoolOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

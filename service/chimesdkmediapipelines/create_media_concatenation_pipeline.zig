const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConcatenationSink = @import("concatenation_sink.zig").ConcatenationSink;
const ConcatenationSource = @import("concatenation_source.zig").ConcatenationSource;
const Tag = @import("tag.zig").Tag;
const MediaConcatenationPipeline = @import("media_concatenation_pipeline.zig").MediaConcatenationPipeline;

pub const CreateMediaConcatenationPipelineInput = struct {
    /// The unique identifier for the client request. The token makes the API
    /// request
    /// idempotent. Use a unique token for each media concatenation pipeline
    /// request.
    client_request_token: ?[]const u8 = null,

    /// An object that specifies the data sinks for the media concatenation
    /// pipeline.
    sinks: []const ConcatenationSink,

    /// An object that specifies the sources for the media concatenation pipeline.
    sources: []const ConcatenationSource,

    /// The tags associated with the media concatenation pipeline.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .sinks = "Sinks",
        .sources = "Sources",
        .tags = "Tags",
    };
};

pub const CreateMediaConcatenationPipelineOutput = struct {
    /// A media concatenation pipeline object, the ID, source type,
    /// `MediaPipelineARN`, and sink of a
    /// media concatenation pipeline object.
    media_concatenation_pipeline: ?MediaConcatenationPipeline = null,

    pub const json_field_names = .{
        .media_concatenation_pipeline = "MediaConcatenationPipeline",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateMediaConcatenationPipelineInput, options: CallOptions) !CreateMediaConcatenationPipelineOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateMediaConcatenationPipelineInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("media-pipelines-chime", "Chime SDK Media Pipelines", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/sdk-media-concatenation-pipelines";

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
    try body_buf.appendSlice(allocator, "\"Sinks\":");
    try aws.json.writeValue(@TypeOf(input.sinks), input.sinks, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Sources\":");
    try aws.json.writeValue(@TypeOf(input.sources), input.sources, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateMediaConcatenationPipelineOutput {
    var result: CreateMediaConcatenationPipelineOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateMediaConcatenationPipelineOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

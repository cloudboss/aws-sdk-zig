const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MediaCapturePipeline = @import("media_capture_pipeline.zig").MediaCapturePipeline;

pub const GetMediaCapturePipelineInput = struct {
    /// The ID of the pipeline that you want to get.
    media_pipeline_id: []const u8,

    pub const json_field_names = .{
        .media_pipeline_id = "MediaPipelineId",
    };
};

pub const GetMediaCapturePipelineOutput = struct {
    /// The media pipeline object.
    media_capture_pipeline: ?MediaCapturePipeline = null,

    pub const json_field_names = .{
        .media_capture_pipeline = "MediaCapturePipeline",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMediaCapturePipelineInput, options: CallOptions) !GetMediaCapturePipelineOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMediaCapturePipelineInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("media-pipelines-chime", "Chime SDK Media Pipelines", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/sdk-media-capture-pipelines/");
    try path_buf.appendSlice(allocator, input.media_pipeline_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMediaCapturePipelineOutput {
    var result: GetMediaCapturePipelineOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetMediaCapturePipelineOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

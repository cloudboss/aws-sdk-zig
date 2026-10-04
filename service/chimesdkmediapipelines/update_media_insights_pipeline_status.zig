const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MediaPipelineStatusUpdate = @import("media_pipeline_status_update.zig").MediaPipelineStatusUpdate;

pub const UpdateMediaInsightsPipelineStatusInput = struct {
    /// The unique identifier of the resource to be updated. Valid values include
    /// the ID and ARN of the media insights pipeline.
    identifier: []const u8,

    /// The requested status of the media insights pipeline.
    update_status: MediaPipelineStatusUpdate,

    pub const json_field_names = .{
        .identifier = "Identifier",
        .update_status = "UpdateStatus",
    };
};

pub const UpdateMediaInsightsPipelineStatusOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateMediaInsightsPipelineStatusInput, options: CallOptions) !UpdateMediaInsightsPipelineStatusOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateMediaInsightsPipelineStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("media-pipelines-chime", "Chime SDK Media Pipelines", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/media-insights-pipeline-status/");
    try path_buf.appendSlice(allocator, input.identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"UpdateStatus\":");
    try aws.json.writeValue(@TypeOf(input.update_status), input.update_status, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateMediaInsightsPipelineStatusOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateMediaInsightsPipelineStatusOutput = .{};

    return result;
}

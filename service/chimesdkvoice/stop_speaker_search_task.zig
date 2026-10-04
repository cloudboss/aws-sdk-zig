const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const StopSpeakerSearchTaskInput = struct {
    /// The speaker search task ID.
    speaker_search_task_id: []const u8,

    /// The Voice Connector ID.
    voice_connector_id: []const u8,

    pub const json_field_names = .{
        .speaker_search_task_id = "SpeakerSearchTaskId",
        .voice_connector_id = "VoiceConnectorId",
    };
};

pub const StopSpeakerSearchTaskOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StopSpeakerSearchTaskInput, options: CallOptions) !StopSpeakerSearchTaskOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StopSpeakerSearchTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("voice-chime", "Chime SDK Voice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/voice-connectors/");
    try path_buf.appendSlice(allocator, input.voice_connector_id);
    try path_buf.appendSlice(allocator, "/speaker-search-tasks/");
    try path_buf.appendSlice(allocator, input.speaker_search_task_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    try query_buf.appendSlice(allocator, "operation=stop");
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StopSpeakerSearchTaskOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: StopSpeakerSearchTaskOutput = .{};

    return result;
}

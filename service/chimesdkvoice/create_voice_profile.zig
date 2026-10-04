const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VoiceProfile = @import("voice_profile.zig").VoiceProfile;

pub const CreateVoiceProfileInput = struct {
    /// The ID of the speaker search task.
    speaker_search_task_id: []const u8,

    pub const json_field_names = .{
        .speaker_search_task_id = "SpeakerSearchTaskId",
    };
};

pub const CreateVoiceProfileOutput = struct {
    /// The requested voice profile.
    voice_profile: ?VoiceProfile = null,

    pub const json_field_names = .{
        .voice_profile = "VoiceProfile",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateVoiceProfileInput, options: CallOptions) !CreateVoiceProfileOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateVoiceProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("voice-chime", "Chime SDK Voice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/voice-profiles";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SpeakerSearchTaskId\":");
    try aws.json.writeValue(@TypeOf(input.speaker_search_task_id), input.speaker_search_task_id, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateVoiceProfileOutput {
    var result: CreateVoiceProfileOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateVoiceProfileOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

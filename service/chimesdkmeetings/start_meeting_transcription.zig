const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TranscriptionConfiguration = @import("transcription_configuration.zig").TranscriptionConfiguration;

pub const StartMeetingTranscriptionInput = struct {
    /// The unique ID of the meeting being transcribed.
    meeting_id: []const u8,

    /// The configuration for the current transcription operation. Must contain
    /// `EngineTranscribeSettings` or
    /// `EngineTranscribeMedicalSettings`.
    transcription_configuration: TranscriptionConfiguration,

    pub const json_field_names = .{
        .meeting_id = "MeetingId",
        .transcription_configuration = "TranscriptionConfiguration",
    };
};

pub const StartMeetingTranscriptionOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartMeetingTranscriptionInput, options: CallOptions) !StartMeetingTranscriptionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartMeetingTranscriptionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("meetings-chime", "Chime SDK Meetings", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/meetings/");
    try path_buf.appendSlice(allocator, input.meeting_id);
    try path_buf.appendSlice(allocator, "/transcription");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    try query_buf.appendSlice(allocator, "operation=start");
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TranscriptionConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.transcription_configuration), input.transcription_configuration, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartMeetingTranscriptionOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: StartMeetingTranscriptionOutput = .{};

    return result;
}

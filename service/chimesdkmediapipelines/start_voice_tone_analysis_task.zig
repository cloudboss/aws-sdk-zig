const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const KinesisVideoStreamSourceTaskConfiguration = @import("kinesis_video_stream_source_task_configuration.zig").KinesisVideoStreamSourceTaskConfiguration;
const VoiceAnalyticsLanguageCode = @import("voice_analytics_language_code.zig").VoiceAnalyticsLanguageCode;
const VoiceToneAnalysisTask = @import("voice_tone_analysis_task.zig").VoiceToneAnalysisTask;

pub const StartVoiceToneAnalysisTaskInput = struct {
    /// The unique identifier for the client request. Use a different token for
    /// different voice tone analysis tasks.
    client_request_token: ?[]const u8 = null,

    /// The unique identifier of the resource to be updated. Valid values include
    /// the ID and ARN of the media insights pipeline.
    identifier: []const u8,

    /// The task configuration for the Kinesis video stream source of the media
    /// insights
    /// pipeline.
    kinesis_video_stream_source_task_configuration: ?KinesisVideoStreamSourceTaskConfiguration = null,

    /// The language code.
    language_code: VoiceAnalyticsLanguageCode,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .identifier = "Identifier",
        .kinesis_video_stream_source_task_configuration = "KinesisVideoStreamSourceTaskConfiguration",
        .language_code = "LanguageCode",
    };
};

pub const StartVoiceToneAnalysisTaskOutput = struct {
    /// The details of the voice tone analysis task.
    voice_tone_analysis_task: ?VoiceToneAnalysisTask = null,

    pub const json_field_names = .{
        .voice_tone_analysis_task = "VoiceToneAnalysisTask",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartVoiceToneAnalysisTaskInput, options: CallOptions) !StartVoiceToneAnalysisTaskOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartVoiceToneAnalysisTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("media-pipelines-chime", "Chime SDK Media Pipelines", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/media-insights-pipelines/");
    try path_buf.appendSlice(allocator, input.identifier);
    try path_buf.appendSlice(allocator, "/voice-tone-analysis-tasks");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    try query_buf.appendSlice(allocator, "operation=start");
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_request_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientRequestToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kinesis_video_stream_source_task_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"KinesisVideoStreamSourceTaskConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"LanguageCode\":");
    try aws.json.writeValue(@TypeOf(input.language_code), input.language_code, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartVoiceToneAnalysisTaskOutput {
    var result: StartVoiceToneAnalysisTaskOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartVoiceToneAnalysisTaskOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

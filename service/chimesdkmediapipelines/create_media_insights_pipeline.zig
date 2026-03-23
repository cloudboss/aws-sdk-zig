const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const KinesisVideoStreamRecordingSourceRuntimeConfiguration = @import("kinesis_video_stream_recording_source_runtime_configuration.zig").KinesisVideoStreamRecordingSourceRuntimeConfiguration;
const KinesisVideoStreamSourceRuntimeConfiguration = @import("kinesis_video_stream_source_runtime_configuration.zig").KinesisVideoStreamSourceRuntimeConfiguration;
const S3RecordingSinkRuntimeConfiguration = @import("s3_recording_sink_runtime_configuration.zig").S3RecordingSinkRuntimeConfiguration;
const Tag = @import("tag.zig").Tag;
const MediaInsightsPipeline = @import("media_insights_pipeline.zig").MediaInsightsPipeline;

pub const CreateMediaInsightsPipelineInput = struct {
    /// The unique identifier for the media insights pipeline request.
    client_request_token: ?[]const u8 = null,

    /// The runtime configuration for the Kinesis video recording stream source.
    kinesis_video_stream_recording_source_runtime_configuration: ?KinesisVideoStreamRecordingSourceRuntimeConfiguration = null,

    /// The runtime configuration for the Kinesis video stream source of the media
    /// insights
    /// pipeline.
    kinesis_video_stream_source_runtime_configuration: ?KinesisVideoStreamSourceRuntimeConfiguration = null,

    /// The ARN of the pipeline's configuration.
    media_insights_pipeline_configuration_arn: []const u8,

    /// The runtime metadata for the media insights pipeline. Consists of a
    /// key-value map of strings.
    media_insights_runtime_metadata: ?[]const aws.map.StringMapEntry = null,

    /// The runtime configuration for the S3 recording sink. If specified, the
    /// settings in this structure override any settings in
    /// `S3RecordingSinkConfiguration`.
    s3_recording_sink_runtime_configuration: ?S3RecordingSinkRuntimeConfiguration = null,

    /// The tags assigned to the media insights pipeline.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .kinesis_video_stream_recording_source_runtime_configuration = "KinesisVideoStreamRecordingSourceRuntimeConfiguration",
        .kinesis_video_stream_source_runtime_configuration = "KinesisVideoStreamSourceRuntimeConfiguration",
        .media_insights_pipeline_configuration_arn = "MediaInsightsPipelineConfigurationArn",
        .media_insights_runtime_metadata = "MediaInsightsRuntimeMetadata",
        .s3_recording_sink_runtime_configuration = "S3RecordingSinkRuntimeConfiguration",
        .tags = "Tags",
    };
};

pub const CreateMediaInsightsPipelineOutput = struct {
    /// The media insights pipeline object.
    media_insights_pipeline: ?MediaInsightsPipeline = null,

    pub const json_field_names = .{
        .media_insights_pipeline = "MediaInsightsPipeline",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateMediaInsightsPipelineInput, options: CallOptions) !CreateMediaInsightsPipelineOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "chime");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateMediaInsightsPipelineInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("media-pipelines-chime", "Chime SDK Media Pipelines", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/media-insights-pipelines";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_request_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientRequestToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kinesis_video_stream_recording_source_runtime_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"KinesisVideoStreamRecordingSourceRuntimeConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kinesis_video_stream_source_runtime_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"KinesisVideoStreamSourceRuntimeConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"MediaInsightsPipelineConfigurationArn\":");
    try aws.json.writeValue(@TypeOf(input.media_insights_pipeline_configuration_arn), input.media_insights_pipeline_configuration_arn, allocator, &body_buf);
    has_prev = true;
    if (input.media_insights_runtime_metadata) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MediaInsightsRuntimeMetadata\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.s3_recording_sink_runtime_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"S3RecordingSinkRuntimeConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateMediaInsightsPipelineOutput {
    var result: CreateMediaInsightsPipelineOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateMediaInsightsPipelineOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ForbiddenException")) {
        return .{ .arena = arena, .kind = .{ .forbidden_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceFailureException")) {
        return .{ .arena = arena, .kind = .{ .service_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottledClientException")) {
        return .{ .arena = arena, .kind = .{ .throttled_client_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthorizedClientException")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_client_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}

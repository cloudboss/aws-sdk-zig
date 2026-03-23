const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ChimeSdkMeetingConfiguration = @import("chime_sdk_meeting_configuration.zig").ChimeSdkMeetingConfiguration;
const MediaPipelineSinkType = @import("media_pipeline_sink_type.zig").MediaPipelineSinkType;
const MediaPipelineSourceType = @import("media_pipeline_source_type.zig").MediaPipelineSourceType;
const SseAwsKeyManagementParams = @import("sse_aws_key_management_params.zig").SseAwsKeyManagementParams;
const Tag = @import("tag.zig").Tag;
const MediaCapturePipeline = @import("media_capture_pipeline.zig").MediaCapturePipeline;

pub const CreateMediaCapturePipelineInput = struct {
    /// The configuration for a specified media pipeline. `SourceType` must
    /// be `ChimeSdkMeeting`.
    chime_sdk_meeting_configuration: ?ChimeSdkMeetingConfiguration = null,

    /// The unique identifier for the client request. The token makes the API
    /// request idempotent. Use a unique token for each media pipeline request.
    client_request_token: ?[]const u8 = null,

    /// The ARN of the sink type.
    sink_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the sink role to be used with
    /// `AwsKmsKeyId`
    /// in `SseAwsKeyManagementParams`. Can only interact with `S3Bucket`
    /// sink type. The role must belong to the caller’s account and be able to act
    /// on behalf of the
    /// caller during the API call. All minimum policy permissions requirements for
    /// the caller to
    /// perform sink-related actions are the same for `SinkIamRoleArn`.
    ///
    /// Additionally, the role must have permission to `kms:GenerateDataKey` using
    /// KMS key supplied as `AwsKmsKeyId` in `SseAwsKeyManagementParams`. If
    /// media concatenation will be required later, the role must also have
    /// permission to
    /// `kms:Decrypt` for the same KMS key.
    sink_iam_role_arn: ?[]const u8 = null,

    /// Destination type to which the media artifacts are saved. You must use an S3
    /// bucket.
    sink_type: MediaPipelineSinkType,

    /// ARN of the source from which the media artifacts are captured.
    source_arn: []const u8,

    /// Source type from which the media artifacts are captured. A Chime SDK Meeting
    /// is the only
    /// supported source.
    source_type: MediaPipelineSourceType,

    /// An object that contains server side encryption parameters to be used by
    /// media capture
    /// pipeline. The parameters can also be used by media concatenation pipeline
    /// taking media
    /// capture pipeline as a media source.
    sse_aws_key_management_params: ?SseAwsKeyManagementParams = null,

    /// The tag key-value pairs.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .chime_sdk_meeting_configuration = "ChimeSdkMeetingConfiguration",
        .client_request_token = "ClientRequestToken",
        .sink_arn = "SinkArn",
        .sink_iam_role_arn = "SinkIamRoleArn",
        .sink_type = "SinkType",
        .source_arn = "SourceArn",
        .source_type = "SourceType",
        .sse_aws_key_management_params = "SseAwsKeyManagementParams",
        .tags = "Tags",
    };
};

pub const CreateMediaCapturePipelineOutput = struct {
    /// A media pipeline object, the ID, source type, source ARN, sink type, and
    /// sink
    /// ARN of a media pipeline object.
    media_capture_pipeline: ?MediaCapturePipeline = null,

    pub const json_field_names = .{
        .media_capture_pipeline = "MediaCapturePipeline",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateMediaCapturePipelineInput, options: CallOptions) !CreateMediaCapturePipelineOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateMediaCapturePipelineInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("media-pipelines-chime", "Chime SDK Media Pipelines", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/sdk-media-capture-pipelines";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.chime_sdk_meeting_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ChimeSdkMeetingConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_request_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientRequestToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SinkArn\":");
    try aws.json.writeValue(@TypeOf(input.sink_arn), input.sink_arn, allocator, &body_buf);
    has_prev = true;
    if (input.sink_iam_role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SinkIamRoleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SinkType\":");
    try aws.json.writeValue(@TypeOf(input.sink_type), input.sink_type, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SourceArn\":");
    try aws.json.writeValue(@TypeOf(input.source_arn), input.source_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SourceType\":");
    try aws.json.writeValue(@TypeOf(input.source_type), input.source_type, allocator, &body_buf);
    has_prev = true;
    if (input.sse_aws_key_management_params) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SseAwsKeyManagementParams\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateMediaCapturePipelineOutput {
    var result: CreateMediaCapturePipelineOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateMediaCapturePipelineOutput, body, allocator);
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

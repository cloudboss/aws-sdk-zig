const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const StreamStorageConfiguration = @import("stream_storage_configuration.zig").StreamStorageConfiguration;

pub const CreateStreamInput = struct {
    /// The number of hours that you want to retain the data in the stream. Kinesis
    /// Video Streams retains the data in a data store that is associated with the
    /// stream.
    ///
    /// The default value is 0, indicating that the stream does not persist data.
    /// The minimum
    /// is 1 hour.
    ///
    /// When the `DataRetentionInHours` value is 0, consumers can still consume
    /// the fragments that remain in the service host buffer, which has a retention
    /// time limit
    /// of 5 minutes and a retention memory limit of 200 MB. Fragments are removed
    /// from the
    /// buffer when either limit is reached.
    data_retention_in_hours: ?i32 = null,

    /// The name of the device that is writing to the stream.
    ///
    /// In the current implementation, Kinesis Video Streams doesn't use this name.
    device_name: ?[]const u8 = null,

    /// The ID of the Key Management Service (KMS) key that you want Kinesis Video
    /// Streams to use to encrypt stream data.
    ///
    /// If no key ID is specified, the default, Kinesis Video-managed key
    /// (`aws/kinesisvideo`) is used.
    ///
    /// For more information, see
    /// [DescribeKey](https://docs.aws.amazon.com/kms/latest/APIReference/API_DescribeKey.html#API_DescribeKey_RequestParameters).
    kms_key_id: ?[]const u8 = null,

    /// The media type of the stream. Consumers of the stream can use this
    /// information when
    /// processing the stream. For more information about media types, see [Media
    /// Types](http://www.iana.org/assignments/media-types/media-types.xhtml). If
    /// you choose to specify the `MediaType`, see [Naming
    /// Requirements](https://tools.ietf.org/html/rfc6838#section-4.2)
    /// for guidelines.
    ///
    /// Example valid values include "video/h264" and "video/h264,audio/aac".
    ///
    /// This parameter is optional; the default value is `null` (or empty in
    /// JSON).
    media_type: ?[]const u8 = null,

    /// A name for the stream that you are creating.
    ///
    /// The stream name is an identifier for the stream, and must be unique for each
    /// account and region.
    stream_name: []const u8,

    /// The configuration for the stream's storage, including the default storage
    /// tier for stream data. This configuration determines how stream data is
    /// stored and accessed, with different tiers offering varying levels of
    /// performance and cost optimization.
    ///
    /// If not specified, the stream will use the default storage configuration with
    /// HOT tier for optimal performance.
    stream_storage_configuration: ?StreamStorageConfiguration = null,

    /// A list of tags to associate with the specified stream. Each tag is a
    /// key-value pair
    /// (the value is optional).
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .data_retention_in_hours = "DataRetentionInHours",
        .device_name = "DeviceName",
        .kms_key_id = "KmsKeyId",
        .media_type = "MediaType",
        .stream_name = "StreamName",
        .stream_storage_configuration = "StreamStorageConfiguration",
        .tags = "Tags",
    };
};

pub const CreateStreamOutput = struct {
    /// The Amazon Resource Name (ARN) of the stream.
    stream_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .stream_arn = "StreamARN",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateStreamInput, options: CallOptions) !CreateStreamOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "kinesisvideo");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateStreamInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kinesisvideo", "Kinesis Video", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/createStream";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.data_retention_in_hours) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DataRetentionInHours\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.device_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DeviceName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kms_key_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"KmsKeyId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.media_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MediaType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"StreamName\":");
    try aws.json.writeValue(@TypeOf(input.stream_name), input.stream_name, allocator, &body_buf);
    has_prev = true;
    if (input.stream_storage_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"StreamStorageConfiguration\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateStreamOutput {
    var result: CreateStreamOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateStreamOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AccountChannelLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .account_channel_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AccountStreamLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .account_stream_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClientLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .client_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DeviceStreamLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .device_stream_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidArgumentException")) {
        return .{ .arena = arena, .kind = .{ .invalid_argument_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDeviceException")) {
        return .{ .arena = arena, .kind = .{ .invalid_device_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidResourceFormatException")) {
        return .{ .arena = arena, .kind = .{ .invalid_resource_format_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoDataRetentionException")) {
        return .{ .arena = arena, .kind = .{ .no_data_retention_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotAuthorizedException")) {
        return .{ .arena = arena, .kind = .{ .not_authorized_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StreamEdgeConfigurationNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .stream_edge_configuration_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TagsPerResourceExceededLimitException")) {
        return .{ .arena = arena, .kind = .{ .tags_per_resource_exceeded_limit_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "VersionMismatchException")) {
        return .{ .arena = arena, .kind = .{ .version_mismatch_exception = .{
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

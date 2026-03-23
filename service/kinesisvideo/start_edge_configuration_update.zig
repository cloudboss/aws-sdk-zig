const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const EdgeConfig = @import("edge_config.zig").EdgeConfig;
const SyncStatus = @import("sync_status.zig").SyncStatus;

pub const StartEdgeConfigurationUpdateInput = struct {
    /// The edge configuration details required to invoke the update process.
    edge_config: EdgeConfig,

    /// The Amazon Resource Name (ARN) of the stream. Specify either the
    /// `StreamName` or the `StreamARN`.
    stream_arn: ?[]const u8 = null,

    /// The name of the stream whose edge configuration you want to update. Specify
    /// either the `StreamName`
    /// or the `StreamARN`.
    stream_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .edge_config = "EdgeConfig",
        .stream_arn = "StreamARN",
        .stream_name = "StreamName",
    };
};

pub const StartEdgeConfigurationUpdateOutput = struct {
    /// The timestamp at which a stream’s edge configuration was first created.
    creation_time: ?i64 = null,

    /// A description of the stream's edge configuration that will be used to sync
    /// with the Edge Agent IoT Greengrass component. The Edge Agent component will
    /// run
    /// on an IoT Hub Device setup at your premise.
    edge_config: ?EdgeConfig = null,

    /// A description of the generated failure status.
    failed_status_details: ?[]const u8 = null,

    /// The timestamp at which a stream’s edge configuration was last updated.
    last_updated_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the stream.
    stream_arn: ?[]const u8 = null,

    /// The name of the stream from which the edge configuration was updated.
    stream_name: ?[]const u8 = null,

    /// The current sync status of the stream's edge configuration. When you invoke
    /// this API, the sync
    /// status will be set to the `SYNCING` state. Use the
    /// `DescribeEdgeConfiguration` API
    /// to get the latest status of the edge configuration.
    sync_status: ?SyncStatus = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .edge_config = "EdgeConfig",
        .failed_status_details = "FailedStatusDetails",
        .last_updated_time = "LastUpdatedTime",
        .stream_arn = "StreamARN",
        .stream_name = "StreamName",
        .sync_status = "SyncStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartEdgeConfigurationUpdateInput, options: CallOptions) !StartEdgeConfigurationUpdateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartEdgeConfigurationUpdateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kinesisvideo", "Kinesis Video", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/startEdgeConfigurationUpdate";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"EdgeConfig\":");
    try aws.json.writeValue(@TypeOf(input.edge_config), input.edge_config, allocator, &body_buf);
    has_prev = true;
    if (input.stream_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"StreamARN\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.stream_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"StreamName\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartEdgeConfigurationUpdateOutput {
    var result: StartEdgeConfigurationUpdateOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartEdgeConfigurationUpdateOutput, body, allocator);
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

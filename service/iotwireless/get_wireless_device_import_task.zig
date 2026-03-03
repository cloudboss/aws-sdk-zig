const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const PositioningConfigStatus = @import("positioning_config_status.zig").PositioningConfigStatus;
const SidewalkGetStartImportInfo = @import("sidewalk_get_start_import_info.zig").SidewalkGetStartImportInfo;
const ImportTaskStatus = @import("import_task_status.zig").ImportTaskStatus;

pub const GetWirelessDeviceImportTaskInput = struct {
    /// The identifier of the import task for which information is requested.
    id: []const u8,

    pub const json_field_names = .{
        .id = "Id",
    };
};

pub const GetWirelessDeviceImportTaskOutput = struct {
    /// The ARN (Amazon Resource Name) of the import task.
    arn: ?[]const u8 = null,

    /// The time at which the import task was created.
    creation_time: ?i64 = null,

    /// The name of the destination that's assigned to the wireless devices in the
    /// import
    /// task.
    destination_name: ?[]const u8 = null,

    /// The number of devices in the import task that failed to onboard to the
    /// import
    /// task.
    failed_imported_device_count: ?i64 = null,

    /// The identifier of the import task for which information is retrieved.
    id: ?[]const u8 = null,

    /// The number of devices in the import task that are waiting for the control
    /// log to start
    /// processing.
    initialized_imported_device_count: ?i64 = null,

    /// The number of devices in the import task that have been onboarded to the
    /// import
    /// task.
    onboarded_imported_device_count: ?i64 = null,

    /// The number of devices in the import task that are waiting in the import task
    /// queue to
    /// be onboarded.
    pending_imported_device_count: ?i64 = null,

    /// The integration status of the Device Location feature for LoRaWAN and
    /// Sidewalk devices.
    positioning: ?PositioningConfigStatus = null,

    /// The Sidewalk-related information about an import task.
    sidewalk: ?SidewalkGetStartImportInfo = null,

    /// The import task status.
    status: ?ImportTaskStatus = null,

    /// The reason for the provided status information, such as a validation error
    /// that causes
    /// the import task to fail.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_time = "CreationTime",
        .destination_name = "DestinationName",
        .failed_imported_device_count = "FailedImportedDeviceCount",
        .id = "Id",
        .initialized_imported_device_count = "InitializedImportedDeviceCount",
        .onboarded_imported_device_count = "OnboardedImportedDeviceCount",
        .pending_imported_device_count = "PendingImportedDeviceCount",
        .positioning = "Positioning",
        .sidewalk = "Sidewalk",
        .status = "Status",
        .status_reason = "StatusReason",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetWirelessDeviceImportTaskInput, options: CallOptions) !GetWirelessDeviceImportTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "iotwireless");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetWirelessDeviceImportTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotwireless", "IoT Wireless", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/wireless_device_import_task/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetWirelessDeviceImportTaskOutput {
    var result: GetWirelessDeviceImportTaskOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetWirelessDeviceImportTaskOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
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
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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

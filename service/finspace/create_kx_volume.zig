const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const KxAzMode = @import("kx_az_mode.zig").KxAzMode;
const KxNAS1Configuration = @import("kx_nas1_configuration.zig").KxNAS1Configuration;
const KxVolumeType = @import("kx_volume_type.zig").KxVolumeType;
const KxVolumeStatus = @import("kx_volume_status.zig").KxVolumeStatus;

pub const CreateKxVolumeInput = struct {
    /// The identifier of the availability zones.
    availability_zone_ids: []const []const u8,

    /// The number of availability zones you want to assign per volume. Currently,
    /// FinSpace only supports `SINGLE` for volumes. This places dataview in a
    /// single AZ.
    az_mode: KxAzMode,

    /// A token that ensures idempotency. This token expires in 10 minutes.
    client_token: ?[]const u8 = null,

    /// A description of the volume.
    description: ?[]const u8 = null,

    /// A unique identifier for the kdb environment, whose clusters can attach to
    /// the volume.
    environment_id: []const u8,

    /// Specifies the configuration for the Network attached storage (NAS_1) file
    /// system volume. This
    /// parameter is required when you choose `volumeType` as
    /// *NAS_1*.
    nas_1_configuration: ?KxNAS1Configuration = null,

    /// A list of key-value pairs to label the volume. You can add up to 50 tags to
    /// a volume.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// A unique identifier for the volume.
    volume_name: []const u8,

    /// The type of file system volume. Currently, FinSpace only supports `NAS_1`
    /// volume type. When you select `NAS_1` volume type, you must also provide
    /// `nas1Configuration`.
    volume_type: KxVolumeType,

    pub const json_field_names = .{
        .availability_zone_ids = "availabilityZoneIds",
        .az_mode = "azMode",
        .client_token = "clientToken",
        .description = "description",
        .environment_id = "environmentId",
        .nas_1_configuration = "nas1Configuration",
        .tags = "tags",
        .volume_name = "volumeName",
        .volume_type = "volumeType",
    };
};

pub const CreateKxVolumeOutput = struct {
    /// The identifier of the availability zones.
    availability_zone_ids: ?[]const []const u8 = null,

    /// The number of availability zones you want to assign per volume. Currently,
    /// FinSpace only supports `SINGLE` for volumes. This places dataview in a
    /// single AZ.
    az_mode: ?KxAzMode = null,

    /// The timestamp at which the volume was created in FinSpace. The value is
    /// determined as epoch time in milliseconds. For example, the value for Monday,
    /// November 1, 2021 12:00:00 PM UTC is specified as 1635768000000.
    created_timestamp: ?i64 = null,

    /// A description of the volume.
    description: ?[]const u8 = null,

    /// A unique identifier for the kdb environment, whose clusters can attach to
    /// the volume.
    environment_id: ?[]const u8 = null,

    /// Specifies the configuration for the Network attached storage (NAS_1) file
    /// system volume.
    nas_1_configuration: ?KxNAS1Configuration = null,

    /// The status of volume creation.
    ///
    /// * CREATING – The volume creation is in progress.
    ///
    /// * CREATE_FAILED – The volume creation has failed.
    ///
    /// * ACTIVE – The volume is active.
    ///
    /// * UPDATING – The volume is in the process of being updated.
    ///
    /// * UPDATE_FAILED – The update action failed.
    ///
    /// * UPDATED – The volume is successfully updated.
    ///
    /// * DELETING – The volume is in the process of being deleted.
    ///
    /// * DELETE_FAILED – The system failed to delete the volume.
    ///
    /// * DELETED – The volume is successfully deleted.
    status: ?KxVolumeStatus = null,

    /// The error message when a failed state occurs.
    status_reason: ?[]const u8 = null,

    /// The ARN identifier of the volume.
    volume_arn: ?[]const u8 = null,

    /// A unique identifier for the volume.
    volume_name: ?[]const u8 = null,

    /// The type of file system volume. Currently, FinSpace only supports `NAS_1`
    /// volume type.
    volume_type: ?KxVolumeType = null,

    pub const json_field_names = .{
        .availability_zone_ids = "availabilityZoneIds",
        .az_mode = "azMode",
        .created_timestamp = "createdTimestamp",
        .description = "description",
        .environment_id = "environmentId",
        .nas_1_configuration = "nas1Configuration",
        .status = "status",
        .status_reason = "statusReason",
        .volume_arn = "volumeArn",
        .volume_name = "volumeName",
        .volume_type = "volumeType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateKxVolumeInput, options: CallOptions) !CreateKxVolumeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "finspace");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateKxVolumeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("finspace", "finspace", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/kx/environments/");
    try path_buf.appendSlice(allocator, input.environment_id);
    try path_buf.appendSlice(allocator, "/kxvolumes");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"availabilityZoneIds\":");
    try aws.json.writeValue(@TypeOf(input.availability_zone_ids), input.availability_zone_ids, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"azMode\":");
    try aws.json.writeValue(@TypeOf(input.az_mode), input.az_mode, allocator, &body_buf);
    has_prev = true;
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.nas_1_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nas1Configuration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"volumeName\":");
    try aws.json.writeValue(@TypeOf(input.volume_name), input.volume_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"volumeType\":");
    try aws.json.writeValue(@TypeOf(input.volume_type), input.volume_type, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateKxVolumeOutput {
    var result: CreateKxVolumeOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateKxVolumeOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exists_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
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

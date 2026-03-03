const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const MaintenanceWindow = @import("maintenance_window.zig").MaintenanceWindow;
const SoftwareSetUpdateMode = @import("software_set_update_mode.zig").SoftwareSetUpdateMode;
const SoftwareSetUpdateSchedule = @import("software_set_update_schedule.zig").SoftwareSetUpdateSchedule;
const EnvironmentSummary = @import("environment_summary.zig").EnvironmentSummary;

pub const CreateEnvironmentInput = struct {
    /// Specifies a unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. This lets you safely retry the request without
    /// accidentally performing the same operation a second time. Passing the same
    /// value to a later call to an operation requires that you also pass the same
    /// value for all other parameters. We recommend that you use a [UUID type of
    /// value](https://wikipedia.org/wiki/Universally_unique_identifier).
    ///
    /// If you don't provide this value, then Amazon Web Services generates a random
    /// one for you.
    ///
    /// If you retry the operation with the same `ClientToken`, but with different
    /// parameters, the retry fails with an `IdempotentParameterMismatch` error.
    client_token: ?[]const u8 = null,

    /// The ID of the software set to apply.
    desired_software_set_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the desktop to stream from Amazon
    /// WorkSpaces, WorkSpaces Secure Browser, or AppStream 2.0.
    desktop_arn: []const u8,

    /// The URL for the identity provider login (only for environments that use
    /// AppStream 2.0).
    desktop_endpoint: ?[]const u8 = null,

    /// A map of the key-value pairs of the tag or tags to assign to the newly
    /// created devices for this environment.
    device_creation_tags: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon Resource Name (ARN) of the Key Management Service key to use to
    /// encrypt the environment.
    kms_key_arn: ?[]const u8 = null,

    /// A specification for a time window to apply software updates.
    maintenance_window: ?MaintenanceWindow = null,

    /// The name for the environment.
    name: ?[]const u8 = null,

    /// An option to define which software updates to apply.
    software_set_update_mode: ?SoftwareSetUpdateMode = null,

    /// An option to define if software updates should be applied within a
    /// maintenance window.
    software_set_update_schedule: ?SoftwareSetUpdateSchedule = null,

    /// A map of the key-value pairs of the tag or tags to assign to the resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .desired_software_set_id = "desiredSoftwareSetId",
        .desktop_arn = "desktopArn",
        .desktop_endpoint = "desktopEndpoint",
        .device_creation_tags = "deviceCreationTags",
        .kms_key_arn = "kmsKeyArn",
        .maintenance_window = "maintenanceWindow",
        .name = "name",
        .software_set_update_mode = "softwareSetUpdateMode",
        .software_set_update_schedule = "softwareSetUpdateSchedule",
        .tags = "tags",
    };
};

pub const CreateEnvironmentOutput = struct {
    /// Describes an environment.
    environment: ?EnvironmentSummary = null,

    pub const json_field_names = .{
        .environment = "environment",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEnvironmentInput, options: Options) !CreateEnvironmentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "workspacesthinclient");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEnvironmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workspacesthinclient", "WorkSpaces Thin Client", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/environments";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.desired_software_set_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"desiredSoftwareSetId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"desktopArn\":");
    try aws.json.writeValue(@TypeOf(input.desktop_arn), input.desktop_arn, allocator, &body_buf);
    has_prev = true;
    if (input.desktop_endpoint) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"desktopEndpoint\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.device_creation_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"deviceCreationTags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kms_key_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"kmsKeyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.maintenance_window) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maintenanceWindow\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.software_set_update_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"softwareSetUpdateMode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.software_set_update_schedule) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"softwareSetUpdateSchedule\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEnvironmentOutput {
    var result: CreateEnvironmentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateEnvironmentOutput, body, allocator);
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

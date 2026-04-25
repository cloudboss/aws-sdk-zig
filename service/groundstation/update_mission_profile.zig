const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const KmsKey = @import("kms_key.zig").KmsKey;

pub const UpdateMissionProfileInput = struct {
    /// Amount of time after a contact ends that you'd like to receive a Ground
    /// Station Contact State Change event indicating the pass has finished.
    contact_post_pass_duration_seconds: ?i32 = null,

    /// Amount of time after a contact ends that you'd like to receive a Ground
    /// Station Contact State Change event indicating the pass has finished.
    contact_pre_pass_duration_seconds: ?i32 = null,

    /// A list of lists of ARNs. Each list of ARNs is an edge, with a *from* `
    /// Config` and a *to* `Config`.
    dataflow_edges: ?[]const []const []const u8 = null,

    /// Smallest amount of time in seconds that you'd like to see for an available
    /// contact. AWS Ground Station will not present you with contacts shorter than
    /// this duration.
    minimum_viable_contact_duration_seconds: ?i32 = null,

    /// UUID of a mission profile.
    mission_profile_id: []const u8,

    /// Name of a mission profile.
    name: ?[]const u8 = null,

    /// KMS key to use for encrypting streams.
    streams_kms_key: ?KmsKey = null,

    /// Role to use for encrypting streams with KMS key.
    streams_kms_role: ?[]const u8 = null,

    /// ARN of a telemetry sink `Config`.
    telemetry_sink_config_arn: ?[]const u8 = null,

    /// ARN of a tracking `Config`.
    tracking_config_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .contact_post_pass_duration_seconds = "contactPostPassDurationSeconds",
        .contact_pre_pass_duration_seconds = "contactPrePassDurationSeconds",
        .dataflow_edges = "dataflowEdges",
        .minimum_viable_contact_duration_seconds = "minimumViableContactDurationSeconds",
        .mission_profile_id = "missionProfileId",
        .name = "name",
        .streams_kms_key = "streamsKmsKey",
        .streams_kms_role = "streamsKmsRole",
        .telemetry_sink_config_arn = "telemetrySinkConfigArn",
        .tracking_config_arn = "trackingConfigArn",
    };
};

pub const UpdateMissionProfileOutput = struct {
    /// UUID of a mission profile.
    mission_profile_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .mission_profile_id = "missionProfileId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateMissionProfileInput, options: CallOptions) !UpdateMissionProfileOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "groundstation");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateMissionProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("groundstation", "GroundStation", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/missionprofile/");
    try path_buf.appendSlice(allocator, input.mission_profile_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.contact_post_pass_duration_seconds) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"contactPostPassDurationSeconds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.contact_pre_pass_duration_seconds) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"contactPrePassDurationSeconds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.dataflow_edges) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"dataflowEdges\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.minimum_viable_contact_duration_seconds) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"minimumViableContactDurationSeconds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.streams_kms_key) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"streamsKmsKey\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.streams_kms_role) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"streamsKmsRole\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.telemetry_sink_config_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"telemetrySinkConfigArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tracking_config_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"trackingConfigArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateMissionProfileOutput {
    var result: UpdateMissionProfileOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateMissionProfileOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "DependencyException")) {
        return .{ .arena = arena, .kind = .{ .dependency_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded_exception = .{
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const SoftwareToUpdate = @import("software_to_update.zig").SoftwareToUpdate;
const UpdateAgentLogLevel = @import("update_agent_log_level.zig").UpdateAgentLogLevel;
const UpdateTargetsArchitecture = @import("update_targets_architecture.zig").UpdateTargetsArchitecture;
const UpdateTargetsOperatingSystem = @import("update_targets_operating_system.zig").UpdateTargetsOperatingSystem;

pub const CreateSoftwareUpdateJobInput = struct {
    /// A client token used to correlate requests and responses.
    amzn_client_token: ?[]const u8 = null,

    s3_url_signer_role: []const u8,

    software_to_update: SoftwareToUpdate,

    update_agent_log_level: ?UpdateAgentLogLevel = null,

    update_targets: []const []const u8,

    update_targets_architecture: UpdateTargetsArchitecture,

    update_targets_operating_system: UpdateTargetsOperatingSystem,

    pub const json_field_names = .{
        .amzn_client_token = "AmznClientToken",
        .s3_url_signer_role = "S3UrlSignerRole",
        .software_to_update = "SoftwareToUpdate",
        .update_agent_log_level = "UpdateAgentLogLevel",
        .update_targets = "UpdateTargets",
        .update_targets_architecture = "UpdateTargetsArchitecture",
        .update_targets_operating_system = "UpdateTargetsOperatingSystem",
    };
};

pub const CreateSoftwareUpdateJobOutput = struct {
    /// The IoT Job ARN corresponding to this update.
    iot_job_arn: ?[]const u8 = null,

    /// The IoT Job Id corresponding to this update.
    iot_job_id: ?[]const u8 = null,

    /// The software version installed on the device or devices after the update.
    platform_software_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .iot_job_arn = "IotJobArn",
        .iot_job_id = "IotJobId",
        .platform_software_version = "PlatformSoftwareVersion",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSoftwareUpdateJobInput, options: Options) !CreateSoftwareUpdateJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "greengrass");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateSoftwareUpdateJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("greengrass", "Greengrass", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/greengrass/updates";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"S3UrlSignerRole\":");
    try aws.json.writeValue(@TypeOf(input.s3_url_signer_role), input.s3_url_signer_role, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"SoftwareToUpdate\":");
    try aws.json.writeValue(@TypeOf(input.software_to_update), input.software_to_update, alloc, &body_buf);
    has_prev = true;
    if (input.update_agent_log_level) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"UpdateAgentLogLevel\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"UpdateTargets\":");
    try aws.json.writeValue(@TypeOf(input.update_targets), input.update_targets, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"UpdateTargetsArchitecture\":");
    try aws.json.writeValue(@TypeOf(input.update_targets_architecture), input.update_targets_architecture, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"UpdateTargetsOperatingSystem\":");
    try aws.json.writeValue(@TypeOf(input.update_targets_operating_system), input.update_targets_operating_system, alloc, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");
    if (input.amzn_client_token) |v| {
        try request.headers.put(alloc, "X-Amzn-Client-Token", v);
    }

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateSoftwareUpdateJobOutput {
    var result: CreateSoftwareUpdateJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateSoftwareUpdateJobOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
    if (std.mem.eql(u8, error_code, "InternalServerErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error_exception = .{
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

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSoftwareUpdateJobInput, options: CallOptions) !CreateSoftwareUpdateJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "greengrass", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSoftwareUpdateJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("greengrass", "Greengrass", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/greengrass/updates";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"S3UrlSignerRole\":");
    try aws.json.writeValue(@TypeOf(input.s3_url_signer_role), input.s3_url_signer_role, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SoftwareToUpdate\":");
    try aws.json.writeValue(@TypeOf(input.software_to_update), input.software_to_update, allocator, &body_buf);
    has_prev = true;
    if (input.update_agent_log_level) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"UpdateAgentLogLevel\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"UpdateTargets\":");
    try aws.json.writeValue(@TypeOf(input.update_targets), input.update_targets, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"UpdateTargetsArchitecture\":");
    try aws.json.writeValue(@TypeOf(input.update_targets_architecture), input.update_targets_architecture, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"UpdateTargetsOperatingSystem\":");
    try aws.json.writeValue(@TypeOf(input.update_targets_operating_system), input.update_targets_operating_system, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    if (input.amzn_client_token) |v| {
        try request.headers.put(allocator, "X-Amzn-Client-Token", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSoftwareUpdateJobOutput {
    const result: CreateSoftwareUpdateJobOutput = try aws.json.parseJsonObject(
        CreateSoftwareUpdateJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

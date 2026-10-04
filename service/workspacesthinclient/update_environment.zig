const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MaintenanceWindow = @import("maintenance_window.zig").MaintenanceWindow;
const SoftwareSetUpdateMode = @import("software_set_update_mode.zig").SoftwareSetUpdateMode;
const SoftwareSetUpdateSchedule = @import("software_set_update_schedule.zig").SoftwareSetUpdateSchedule;
const EnvironmentSummary = @import("environment_summary.zig").EnvironmentSummary;

pub const UpdateEnvironmentInput = struct {
    /// The ID of the software set to apply.
    desired_software_set_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the desktop to stream from Amazon
    /// WorkSpaces, WorkSpaces Secure Browser, or AppStream 2.0.
    desktop_arn: ?[]const u8 = null,

    /// The URL for the identity provider login (only for environments that use
    /// AppStream 2.0).
    desktop_endpoint: ?[]const u8 = null,

    /// A map of the key-value pairs of the tag or tags to assign to the newly
    /// created devices for this environment.
    device_creation_tags: ?[]const aws.map.StringMapEntry = null,

    /// The ID of the environment to update.
    id: []const u8,

    /// A specification for a time window to apply software updates.
    maintenance_window: ?MaintenanceWindow = null,

    /// The name of the environment to update.
    name: ?[]const u8 = null,

    /// An option to define which software updates to apply.
    software_set_update_mode: ?SoftwareSetUpdateMode = null,

    /// An option to define if software updates should be applied within a
    /// maintenance window.
    software_set_update_schedule: ?SoftwareSetUpdateSchedule = null,

    pub const json_field_names = .{
        .desired_software_set_id = "desiredSoftwareSetId",
        .desktop_arn = "desktopArn",
        .desktop_endpoint = "desktopEndpoint",
        .device_creation_tags = "deviceCreationTags",
        .id = "id",
        .maintenance_window = "maintenanceWindow",
        .name = "name",
        .software_set_update_mode = "softwareSetUpdateMode",
        .software_set_update_schedule = "softwareSetUpdateSchedule",
    };
};

pub const UpdateEnvironmentOutput = struct {
    /// Describes an environment.
    environment: ?EnvironmentSummary = null,

    pub const json_field_names = .{
        .environment = "environment",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateEnvironmentInput, options: CallOptions) !UpdateEnvironmentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "thinclient", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateEnvironmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("thinclient", "WorkSpaces Thin Client", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/environments/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.desired_software_set_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"desiredSoftwareSetId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.desktop_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"desktopArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateEnvironmentOutput {
    const result: UpdateEnvironmentOutput = try aws.json.parseJsonObject(
        UpdateEnvironmentOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

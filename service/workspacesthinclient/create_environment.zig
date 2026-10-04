const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEnvironmentInput, options: CallOptions) !CreateEnvironmentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEnvironmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("thinclient", "WorkSpaces Thin Client", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/environments";

    var body_buf: std.ArrayList(u8) = .empty;
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

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEnvironmentOutput {
    const result: CreateEnvironmentOutput = try aws.json.parseJsonObject(
        CreateEnvironmentOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

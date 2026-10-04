const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateEnvironmentInput = struct {
    /// Indicates whether to update the runtime environment during the maintenance
    /// window. The
    /// default is false. Currently, Amazon Web Services Mainframe Modernization
    /// accepts the `engineVersion` parameter
    /// only if `applyDuringMaintenanceWindow` is true. If any parameter other than
    /// `engineVersion` is provided in `UpdateEnvironmentRequest`, it will
    /// fail if `applyDuringMaintenanceWindow` is set to true.
    apply_during_maintenance_window: ?bool = null,

    /// The desired capacity for the runtime environment to update. The minimum
    /// possible value is 0 and the maximum is 100.
    desired_capacity: ?i32 = null,

    /// The version of the runtime engine for the runtime environment.
    engine_version: ?[]const u8 = null,

    /// The unique identifier of the runtime environment that you want to update.
    environment_id: []const u8,

    /// Forces the updates on the environment. This option is needed if the
    /// applications in the environment are not stopped or if there are ongoing
    /// application-related activities in the environment.
    ///
    /// If you use this option, be aware that it could lead to data corruption in
    /// the applications, and that you might need to perform repair and recovery
    /// procedures for the applications.
    ///
    /// This option is not needed if the attribute being updated is
    /// `preferredMaintenanceWindow`.
    force_update: ?bool = null,

    /// The instance type for the runtime environment to update.
    instance_type: ?[]const u8 = null,

    /// Configures the maintenance window that you want for the runtime environment.
    /// The maintenance window must have the format `ddd:hh24:mi-ddd:hh24:mi` and
    /// must be less than 24 hours. The following two examples are valid maintenance
    /// windows: `sun:23:45-mon:00:15` or `sat:01:00-sat:03:00`.
    ///
    /// If you do not provide a value, a random system-generated value will be
    /// assigned.
    preferred_maintenance_window: ?[]const u8 = null,

    pub const json_field_names = .{
        .apply_during_maintenance_window = "applyDuringMaintenanceWindow",
        .desired_capacity = "desiredCapacity",
        .engine_version = "engineVersion",
        .environment_id = "environmentId",
        .force_update = "forceUpdate",
        .instance_type = "instanceType",
        .preferred_maintenance_window = "preferredMaintenanceWindow",
    };
};

pub const UpdateEnvironmentOutput = struct {
    /// The unique identifier of the runtime environment that was updated.
    environment_id: []const u8,

    pub const json_field_names = .{
        .environment_id = "environmentId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateEnvironmentInput, options: CallOptions) !UpdateEnvironmentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "m2", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("m2", "m2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/environments/");
    try path_buf.appendSlice(allocator, input.environment_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.apply_during_maintenance_window) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"applyDuringMaintenanceWindow\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.desired_capacity) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"desiredCapacity\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.engine_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"engineVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.force_update) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"forceUpdate\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.instance_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"instanceType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.preferred_maintenance_window) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"preferredMaintenanceWindow\":");
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
    var result: UpdateEnvironmentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateEnvironmentOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

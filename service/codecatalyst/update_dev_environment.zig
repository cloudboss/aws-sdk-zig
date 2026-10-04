const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IdeConfiguration = @import("ide_configuration.zig").IdeConfiguration;
const InstanceType = @import("instance_type.zig").InstanceType;

pub const UpdateDevEnvironmentInput = struct {
    /// The user-specified alias for the Dev Environment. Changing this value will
    /// not cause a restart.
    alias: ?[]const u8 = null,

    /// A user-specified idempotency token. Idempotency ensures that an API request
    /// completes only once.
    /// With an idempotent request, if the original request completes successfully,
    /// the subsequent retries return the result from the original successful
    /// request and have no additional effect.
    client_token: ?[]const u8 = null,

    /// The system-generated unique ID of the Dev Environment.
    id: []const u8,

    /// Information about the integrated development environment (IDE) configured
    /// for a Dev Environment.
    ides: ?[]const IdeConfiguration = null,

    /// The amount of time the Dev Environment will run without any activity
    /// detected before stopping, in minutes.
    /// Only whole integers are allowed. Dev Environments consume compute minutes
    /// when running.
    ///
    /// Changing this value will cause a restart of the Dev Environment if it is
    /// running.
    inactivity_timeout_minutes: ?i32 = null,

    /// The Amazon EC2 instace type to use for the Dev Environment.
    ///
    /// Changing this value will cause a restart of the Dev Environment if it is
    /// running.
    instance_type: ?InstanceType = null,

    /// The name of the project in the space.
    project_name: []const u8,

    /// The name of the space.
    space_name: []const u8,

    pub const json_field_names = .{
        .alias = "alias",
        .client_token = "clientToken",
        .id = "id",
        .ides = "ides",
        .inactivity_timeout_minutes = "inactivityTimeoutMinutes",
        .instance_type = "instanceType",
        .project_name = "projectName",
        .space_name = "spaceName",
    };
};

pub const UpdateDevEnvironmentOutput = struct {
    /// The user-specified alias for the Dev Environment.
    alias: ?[]const u8 = null,

    /// A user-specified idempotency token. Idempotency ensures that an API request
    /// completes only once.
    /// With an idempotent request, if the original request completes successfully,
    /// the subsequent retries return the result from the original successful
    /// request and have no additional effect.
    client_token: ?[]const u8 = null,

    /// The system-generated unique ID of the Dev Environment.
    id: []const u8,

    /// Information about the integrated development environment (IDE) configured
    /// for the Dev Environment.
    ides: ?[]const IdeConfiguration = null,

    /// The amount of time the Dev Environment will run without any activity
    /// detected before stopping, in minutes.
    inactivity_timeout_minutes: ?i32 = null,

    /// The Amazon EC2 instace type to use for the Dev Environment.
    instance_type: ?InstanceType = null,

    /// The name of the project in the space.
    project_name: []const u8,

    /// The name of the space.
    space_name: []const u8,

    pub const json_field_names = .{
        .alias = "alias",
        .client_token = "clientToken",
        .id = "id",
        .ides = "ides",
        .inactivity_timeout_minutes = "inactivityTimeoutMinutes",
        .instance_type = "instanceType",
        .project_name = "projectName",
        .space_name = "spaceName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDevEnvironmentInput, options: CallOptions) !UpdateDevEnvironmentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codecatalyst", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDevEnvironmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codecatalyst", "CodeCatalyst", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/spaces/");
    try path_buf.appendSlice(allocator, input.space_name);
    try path_buf.appendSlice(allocator, "/projects/");
    try path_buf.appendSlice(allocator, input.project_name);
    try path_buf.appendSlice(allocator, "/devEnvironments/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.alias) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"alias\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.ides) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ides\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.inactivity_timeout_minutes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"inactivityTimeoutMinutes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.instance_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"instanceType\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDevEnvironmentOutput {
    const result: UpdateDevEnvironmentOutput = try aws.json.parseJsonObject(
        UpdateDevEnvironmentOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

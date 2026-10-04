const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CreateBackendStorageResourceConfig = @import("create_backend_storage_resource_config.zig").CreateBackendStorageResourceConfig;

pub const CreateBackendStorageInput = struct {
    /// The app ID.
    app_id: []const u8,

    /// The name of the backend environment.
    backend_environment_name: []const u8,

    /// The resource configuration for creating backend storage.
    resource_config: CreateBackendStorageResourceConfig,

    /// The name of the storage resource.
    resource_name: []const u8,

    pub const json_field_names = .{
        .app_id = "AppId",
        .backend_environment_name = "BackendEnvironmentName",
        .resource_config = "ResourceConfig",
        .resource_name = "ResourceName",
    };
};

pub const CreateBackendStorageOutput = struct {
    /// The app ID.
    app_id: ?[]const u8 = null,

    /// The name of the backend environment.
    backend_environment_name: ?[]const u8 = null,

    /// The ID for the job.
    job_id: ?[]const u8 = null,

    /// The current status of the request.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_id = "AppId",
        .backend_environment_name = "BackendEnvironmentName",
        .job_id = "JobId",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateBackendStorageInput, options: CallOptions) !CreateBackendStorageOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "amplifybackend", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateBackendStorageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("amplifybackend", "AmplifyBackend", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/backend/");
    try path_buf.appendSlice(allocator, input.app_id);
    try path_buf.appendSlice(allocator, "/storage");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"BackendEnvironmentName\":");
    try aws.json.writeValue(@TypeOf(input.backend_environment_name), input.backend_environment_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ResourceConfig\":");
    try aws.json.writeValue(@TypeOf(input.resource_config), input.resource_config, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ResourceName\":");
    try aws.json.writeValue(@TypeOf(input.resource_name), input.resource_name, allocator, &body_buf);
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

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateBackendStorageOutput {
    var result: CreateBackendStorageOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateBackendStorageOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

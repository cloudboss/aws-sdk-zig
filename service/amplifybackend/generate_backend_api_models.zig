const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GenerateBackendAPIModelsInput = struct {
    /// The app ID.
    app_id: []const u8,

    /// The name of the backend environment.
    backend_environment_name: []const u8,

    /// The name of this resource.
    resource_name: []const u8,

    pub const json_field_names = .{
        .app_id = "AppId",
        .backend_environment_name = "BackendEnvironmentName",
        .resource_name = "ResourceName",
    };
};

pub const GenerateBackendAPIModelsOutput = struct {
    /// The app ID.
    app_id: ?[]const u8 = null,

    /// The name of the backend environment.
    backend_environment_name: ?[]const u8 = null,

    /// If the request fails, this error is returned.
    @"error": ?[]const u8 = null,

    /// The ID for the job.
    job_id: ?[]const u8 = null,

    /// The name of the operation.
    operation: ?[]const u8 = null,

    /// The current status of the request.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_id = "AppId",
        .backend_environment_name = "BackendEnvironmentName",
        .@"error" = "Error",
        .job_id = "JobId",
        .operation = "Operation",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GenerateBackendAPIModelsInput, options: CallOptions) !GenerateBackendAPIModelsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GenerateBackendAPIModelsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("amplifybackend", "AmplifyBackend", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/backend/");
    try path_buf.appendSlice(allocator, input.app_id);
    try path_buf.appendSlice(allocator, "/api/");
    try path_buf.appendSlice(allocator, input.backend_environment_name);
    try path_buf.appendSlice(allocator, "/generateModels");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GenerateBackendAPIModelsOutput {
    const result: GenerateBackendAPIModelsOutput = try aws.json.parseJsonObject(
        GenerateBackendAPIModelsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

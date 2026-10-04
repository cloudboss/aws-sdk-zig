const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetBackendJobInput = struct {
    /// The app ID.
    app_id: []const u8,

    /// The name of the backend environment.
    backend_environment_name: []const u8,

    /// The ID for the job.
    job_id: []const u8,

    pub const json_field_names = .{
        .app_id = "AppId",
        .backend_environment_name = "BackendEnvironmentName",
        .job_id = "JobId",
    };
};

pub const GetBackendJobOutput = struct {
    /// The app ID.
    app_id: ?[]const u8 = null,

    /// The name of the backend environment.
    backend_environment_name: ?[]const u8 = null,

    /// The time when the job was created.
    create_time: ?[]const u8 = null,

    /// If the request fails, this error is returned.
    @"error": ?[]const u8 = null,

    /// The ID for the job.
    job_id: ?[]const u8 = null,

    /// The name of the operation.
    operation: ?[]const u8 = null,

    /// The current status of the request.
    status: ?[]const u8 = null,

    /// The time when the job was last updated.
    update_time: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_id = "AppId",
        .backend_environment_name = "BackendEnvironmentName",
        .create_time = "CreateTime",
        .@"error" = "Error",
        .job_id = "JobId",
        .operation = "Operation",
        .status = "Status",
        .update_time = "UpdateTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetBackendJobInput, options: CallOptions) !GetBackendJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetBackendJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("amplifybackend", "AmplifyBackend", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/backend/");
    try path_buf.appendSlice(allocator, input.app_id);
    try path_buf.appendSlice(allocator, "/job/");
    try path_buf.appendSlice(allocator, input.backend_environment_name);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.job_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetBackendJobOutput {
    const result: GetBackendJobOutput = try aws.json.parseJsonObject(
        GetBackendJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

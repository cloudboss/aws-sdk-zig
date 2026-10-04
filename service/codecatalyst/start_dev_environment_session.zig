const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DevEnvironmentSessionConfiguration = @import("dev_environment_session_configuration.zig").DevEnvironmentSessionConfiguration;
const DevEnvironmentAccessDetails = @import("dev_environment_access_details.zig").DevEnvironmentAccessDetails;

pub const StartDevEnvironmentSessionInput = struct {
    /// The system-generated unique ID of the Dev Environment.
    id: []const u8,

    /// The name of the project in the space.
    project_name: []const u8,

    session_configuration: DevEnvironmentSessionConfiguration,

    /// The name of the space.
    space_name: []const u8,

    pub const json_field_names = .{
        .id = "id",
        .project_name = "projectName",
        .session_configuration = "sessionConfiguration",
        .space_name = "spaceName",
    };
};

pub const StartDevEnvironmentSessionOutput = struct {
    access_details: ?DevEnvironmentAccessDetails = null,

    /// The system-generated unique ID of the Dev Environment.
    id: []const u8,

    /// The name of the project in the space.
    project_name: []const u8,

    /// The system-generated unique ID of the Dev Environment session.
    session_id: ?[]const u8 = null,

    /// The name of the space.
    space_name: []const u8,

    pub const json_field_names = .{
        .access_details = "accessDetails",
        .id = "id",
        .project_name = "projectName",
        .session_id = "sessionId",
        .space_name = "spaceName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartDevEnvironmentSessionInput, options: CallOptions) !StartDevEnvironmentSessionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartDevEnvironmentSessionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codecatalyst", "CodeCatalyst", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/spaces/");
    try path_buf.appendSlice(allocator, input.space_name);
    try path_buf.appendSlice(allocator, "/projects/");
    try path_buf.appendSlice(allocator, input.project_name);
    try path_buf.appendSlice(allocator, "/devEnvironments/");
    try path_buf.appendSlice(allocator, input.id);
    try path_buf.appendSlice(allocator, "/session");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"sessionConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.session_configuration), input.session_configuration, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartDevEnvironmentSessionOutput {
    const result: StartDevEnvironmentSessionOutput = try aws.json.parseJsonObject(
        StartDevEnvironmentSessionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

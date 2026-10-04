const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ApplicationVersionLifecycle = @import("application_version_lifecycle.zig").ApplicationVersionLifecycle;

pub const GetApplicationVersionInput = struct {
    /// The unique identifier of the application.
    application_id: []const u8,

    /// The specific version of the application.
    application_version: i32,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .application_version = "applicationVersion",
    };
};

pub const GetApplicationVersionOutput = struct {
    /// The specific version of the application.
    application_version: i32,

    /// The timestamp when the application version was created.
    creation_time: i64,

    /// The content of the application definition. This is a JSON object that
    /// contains the
    /// resource configuration and definitions that identify an application.
    definition_content: []const u8,

    /// The application description.
    description: ?[]const u8 = null,

    /// The name of the application version.
    name: []const u8,

    /// The status of the application version.
    status: ApplicationVersionLifecycle,

    /// The reason for the reported status.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_version = "applicationVersion",
        .creation_time = "creationTime",
        .definition_content = "definitionContent",
        .description = "description",
        .name = "name",
        .status = "status",
        .status_reason = "statusReason",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetApplicationVersionInput, options: CallOptions) !GetApplicationVersionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetApplicationVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("m2", "m2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/versions/");
    try path_buf.appendSlice(allocator, input.application_version);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetApplicationVersionOutput {
    const result: GetApplicationVersionOutput = try aws.json.parseJsonObject(
        GetApplicationVersionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

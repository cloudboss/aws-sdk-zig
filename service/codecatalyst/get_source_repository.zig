const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetSourceRepositoryInput = struct {
    /// The name of the source repository.
    name: []const u8,

    /// The name of the project in the space.
    project_name: []const u8,

    /// The name of the space.
    space_name: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .project_name = "projectName",
        .space_name = "spaceName",
    };
};

pub const GetSourceRepositoryOutput = struct {
    /// The time the source repository was created, in coordinated universal time
    /// (UTC) timestamp format as specified in [RFC
    /// 3339](https://www.rfc-editor.org/rfc/rfc3339#section-5.6).
    created_time: i64,

    /// The description of the source repository.
    description: ?[]const u8 = null,

    /// The time the source repository was last updated, in coordinated universal
    /// time (UTC) timestamp format as specified in [RFC
    /// 3339](https://www.rfc-editor.org/rfc/rfc3339#section-5.6).
    last_updated_time: i64,

    /// The name of the source repository.
    name: []const u8,

    /// The name of the project in the space.
    project_name: []const u8,

    /// The name of the space.
    space_name: []const u8,

    pub const json_field_names = .{
        .created_time = "createdTime",
        .description = "description",
        .last_updated_time = "lastUpdatedTime",
        .name = "name",
        .project_name = "projectName",
        .space_name = "spaceName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSourceRepositoryInput, options: CallOptions) !GetSourceRepositoryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSourceRepositoryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codecatalyst", "CodeCatalyst", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/spaces/");
    try path_buf.appendSlice(allocator, input.space_name);
    try path_buf.appendSlice(allocator, "/projects/");
    try path_buf.appendSlice(allocator, input.project_name);
    try path_buf.appendSlice(allocator, "/sourceRepositories/");
    try path_buf.appendSlice(allocator, input.name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSourceRepositoryOutput {
    var result: GetSourceRepositoryOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetSourceRepositoryOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

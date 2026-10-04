const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Build = @import("build.zig").Build;

pub const UpdateBuildInput = struct {
    /// A unique identifier for the build to update. You can use either the build ID
    /// or ARN value.
    build_id: []const u8,

    /// A descriptive label that is associated with a build. Build names do not need
    /// to be unique.
    name: ?[]const u8 = null,

    /// Version information that is associated with a build or script. Version
    /// strings do not need to be unique.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .build_id = "BuildId",
        .name = "Name",
        .version = "Version",
    };
};

pub const UpdateBuildOutput = struct {
    /// The updated build resource.
    build: ?Build = null,

    pub const json_field_names = .{
        .build = "Build",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateBuildInput, options: CallOptions) !UpdateBuildOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "gamelift", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateBuildInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("gamelift", "GameLift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.UpdateBuild");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateBuildOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateBuildOutput, body, allocator);
}

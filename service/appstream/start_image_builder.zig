const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ImageBuilder = @import("image_builder.zig").ImageBuilder;

pub const StartImageBuilderInput = struct {
    /// The version of the WorkSpaces Applications agent to use for this image
    /// builder. To use the latest version of the WorkSpaces Applications agent,
    /// specify [LATEST].
    appstream_agent_version: ?[]const u8 = null,

    /// The name of the image builder.
    name: []const u8,

    pub const json_field_names = .{
        .appstream_agent_version = "AppstreamAgentVersion",
        .name = "Name",
    };
};

pub const StartImageBuilderOutput = struct {
    /// Information about the image builder.
    image_builder: ?ImageBuilder = null,

    pub const json_field_names = .{
        .image_builder = "ImageBuilder",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartImageBuilderInput, options: CallOptions) !StartImageBuilderOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appstream", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartImageBuilderInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appstream2", "AppStream", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "PhotonAdminProxyService.StartImageBuilder");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartImageBuilderOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartImageBuilderOutput, body, allocator);
}

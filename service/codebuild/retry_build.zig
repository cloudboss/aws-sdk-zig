const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Build = @import("build.zig").Build;

pub const RetryBuildInput = struct {
    /// Specifies the identifier of the build to restart.
    id: ?[]const u8 = null,

    /// A unique, case sensitive identifier you provide to ensure the idempotency of
    /// the
    /// `RetryBuild` request. The token is included in the
    /// `RetryBuild` request and is valid for five minutes. If you repeat
    /// the `RetryBuild` request with the same token, but change a parameter,
    /// CodeBuild returns a parameter mismatch error.
    idempotency_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "id",
        .idempotency_token = "idempotencyToken",
    };
};

pub const RetryBuildOutput = struct {
    build: ?Build = null,

    pub const json_field_names = .{
        .build = "build",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RetryBuildInput, options: CallOptions) !RetryBuildOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codebuild", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RetryBuildInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codebuild", "CodeBuild", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CodeBuild_20161006.RetryBuild");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RetryBuildOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(RetryBuildOutput, body, allocator);
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TestGridSessionArtifactCategory = @import("test_grid_session_artifact_category.zig").TestGridSessionArtifactCategory;
const TestGridSessionArtifact = @import("test_grid_session_artifact.zig").TestGridSessionArtifact;

pub const ListTestGridSessionArtifactsInput = struct {
    /// The maximum number of results to be returned by a request.
    max_result: ?i32 = null,

    /// Pagination token.
    next_token: ?[]const u8 = null,

    /// The ARN of a TestGridSession.
    session_arn: []const u8,

    /// Limit results to a specified type of artifact.
    type: ?TestGridSessionArtifactCategory = null,

    pub const json_field_names = .{
        .max_result = "maxResult",
        .next_token = "nextToken",
        .session_arn = "sessionArn",
        .type = "type",
    };
};

pub const ListTestGridSessionArtifactsOutput = struct {
    /// A list of test grid session artifacts for a TestGridSession.
    artifacts: ?[]const TestGridSessionArtifact = null,

    /// Pagination token.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .artifacts = "artifacts",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTestGridSessionArtifactsInput, options: CallOptions) !ListTestGridSessionArtifactsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "devicefarm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTestGridSessionArtifactsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("devicefarm", "Device Farm", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "DeviceFarm_20150623.ListTestGridSessionArtifacts");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTestGridSessionArtifactsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListTestGridSessionArtifactsOutput, body, allocator);
}

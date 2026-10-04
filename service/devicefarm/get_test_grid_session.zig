const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TestGridSession = @import("test_grid_session.zig").TestGridSession;

pub const GetTestGridSessionInput = struct {
    /// The ARN for the project that this session belongs to. See
    /// CreateTestGridProject and ListTestGridProjects.
    project_arn: ?[]const u8 = null,

    /// An ARN that uniquely identifies a TestGridSession.
    session_arn: ?[]const u8 = null,

    /// An ID associated with this session.
    session_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .project_arn = "projectArn",
        .session_arn = "sessionArn",
        .session_id = "sessionId",
    };
};

pub const GetTestGridSessionOutput = struct {
    /// The TestGridSession that was requested.
    test_grid_session: ?TestGridSession = null,

    pub const json_field_names = .{
        .test_grid_session = "testGridSession",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTestGridSessionInput, options: CallOptions) !GetTestGridSessionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTestGridSessionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "DeviceFarm_20150623.GetTestGridSession");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTestGridSessionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetTestGridSessionOutput, body, allocator);
}

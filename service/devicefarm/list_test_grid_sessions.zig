const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TestGridSessionStatus = @import("test_grid_session_status.zig").TestGridSessionStatus;
const TestGridSession = @import("test_grid_session.zig").TestGridSession;

pub const ListTestGridSessionsInput = struct {
    /// Return only sessions created after this time.
    creation_time_after: ?i64 = null,

    /// Return only sessions created before this time.
    creation_time_before: ?i64 = null,

    /// Return only sessions that ended after this time.
    end_time_after: ?i64 = null,

    /// Return only sessions that ended before this time.
    end_time_before: ?i64 = null,

    /// Return only this many results at a time.
    max_result: ?i32 = null,

    /// Pagination token.
    next_token: ?[]const u8 = null,

    /// ARN of a TestGridProject.
    project_arn: []const u8,

    /// Return only sessions in this state.
    status: ?TestGridSessionStatus = null,

    pub const json_field_names = .{
        .creation_time_after = "creationTimeAfter",
        .creation_time_before = "creationTimeBefore",
        .end_time_after = "endTimeAfter",
        .end_time_before = "endTimeBefore",
        .max_result = "maxResult",
        .next_token = "nextToken",
        .project_arn = "projectArn",
        .status = "status",
    };
};

pub const ListTestGridSessionsOutput = struct {
    /// Pagination token.
    next_token: ?[]const u8 = null,

    /// The sessions that match the criteria in a ListTestGridSessionsRequest.
    test_grid_sessions: ?[]const TestGridSession = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .test_grid_sessions = "testGridSessions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTestGridSessionsInput, options: CallOptions) !ListTestGridSessionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTestGridSessionsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "DeviceFarm_20150623.ListTestGridSessions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTestGridSessionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListTestGridSessionsOutput, body, allocator);
}

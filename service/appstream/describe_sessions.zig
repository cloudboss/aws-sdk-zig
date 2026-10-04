const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthenticationType = @import("authentication_type.zig").AuthenticationType;
const Session = @import("session.zig").Session;

pub const DescribeSessionsInput = struct {
    /// The authentication method. Specify `API` for a user
    /// authenticated using a streaming URL or `SAML` for a SAML federated user.
    /// The default is to authenticate users using a streaming URL.
    authentication_type: ?AuthenticationType = null,

    /// The name of the fleet. This value is case-sensitive.
    fleet_name: []const u8,

    /// The identifier for the instance hosting the session.
    instance_id: ?[]const u8 = null,

    /// The size of each page of results. The default value is 20 and the maximum
    /// value is 50.
    limit: ?i32 = null,

    /// The pagination token to use to retrieve the next page of results for this
    /// operation. If this value is null, it retrieves the first page.
    next_token: ?[]const u8 = null,

    /// The name of the stack. This value is case-sensitive.
    stack_name: []const u8,

    /// The user identifier (ID). If you specify a user ID, you must also specify
    /// the authentication type.
    user_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .authentication_type = "AuthenticationType",
        .fleet_name = "FleetName",
        .instance_id = "InstanceId",
        .limit = "Limit",
        .next_token = "NextToken",
        .stack_name = "StackName",
        .user_id = "UserId",
    };
};

pub const DescribeSessionsOutput = struct {
    /// The pagination token to use to retrieve the next page of results for this
    /// operation. If there are no more pages, this value is null.
    next_token: ?[]const u8 = null,

    /// Information about the streaming sessions.
    sessions: ?[]const Session = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .sessions = "Sessions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeSessionsInput, options: CallOptions) !DescribeSessionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeSessionsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PhotonAdminProxyService.DescribeSessions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeSessionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeSessionsOutput, body, allocator);
}

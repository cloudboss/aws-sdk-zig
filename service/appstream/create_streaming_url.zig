const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateStreamingURLInput = struct {
    /// The name of the application to launch after the session starts. This is the
    /// name that you specified
    /// as **Name** in the Image Assistant. If your fleet is enabled for the
    /// **Desktop** stream view, you can also choose to launch directly to the
    /// operating system desktop. To do so, specify **Desktop**.
    application_id: ?[]const u8 = null,

    /// The name of the fleet.
    fleet_name: []const u8,

    /// The session context. For more information, see [Session
    /// Context](https://docs.aws.amazon.com/appstream2/latest/developerguide/managing-stacks-fleets.html#managing-stacks-fleets-parameters) in the *Amazon WorkSpaces Applications Administration Guide*.
    session_context: ?[]const u8 = null,

    /// The name of the stack.
    stack_name: []const u8,

    /// The identifier of the user.
    user_id: []const u8,

    /// The time that the streaming URL will be valid, in seconds.
    /// Specify a value between 1 and 604800 seconds. The default is 60 seconds.
    validity: ?i64 = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .fleet_name = "FleetName",
        .session_context = "SessionContext",
        .stack_name = "StackName",
        .user_id = "UserId",
        .validity = "Validity",
    };
};

pub const CreateStreamingURLOutput = struct {
    /// The elapsed time, in seconds after the Unix epoch, when this URL expires.
    expires: ?i64 = null,

    /// The URL to start the WorkSpaces Applications streaming session.
    streaming_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .expires = "Expires",
        .streaming_url = "StreamingURL",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateStreamingURLInput, options: CallOptions) !CreateStreamingURLOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateStreamingURLInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PhotonAdminProxyService.CreateStreamingURL");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateStreamingURLOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateStreamingURLOutput, body, allocator);
}

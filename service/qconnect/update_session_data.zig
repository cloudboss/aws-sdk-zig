const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RuntimeSessionData = @import("runtime_session_data.zig").RuntimeSessionData;
const SessionDataNamespace = @import("session_data_namespace.zig").SessionDataNamespace;

pub const UpdateSessionDataInput = struct {
    /// The identifier of the Amazon Q in Connect assistant. Can be either the ID or
    /// the ARN. URLs cannot contain the ARN.
    assistant_id: []const u8,

    /// The data stored on the Amazon Q in Connect Session.
    data: []const RuntimeSessionData,

    /// The namespace into which the session data is stored. Supported namespaces
    /// are: Custom
    namespace: ?SessionDataNamespace = null,

    /// The identifier of the session. Can be either the ID or the ARN. URLs cannot
    /// contain the ARN.
    session_id: []const u8,

    pub const json_field_names = .{
        .assistant_id = "assistantId",
        .data = "data",
        .namespace = "namespace",
        .session_id = "sessionId",
    };
};

pub const UpdateSessionDataOutput = struct {
    /// Data stored in the session.
    data: ?[]const RuntimeSessionData = null,

    /// The namespace into which the session data is stored. Supported namespaces
    /// are: Custom
    namespace: SessionDataNamespace,

    /// The Amazon Resource Name (ARN) of the session.
    session_arn: []const u8,

    /// The identifier of the session.
    session_id: []const u8,

    pub const json_field_names = .{
        .data = "data",
        .namespace = "namespace",
        .session_arn = "sessionArn",
        .session_id = "sessionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSessionDataInput, options: CallOptions) !UpdateSessionDataOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "wisdom", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSessionDataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wisdom", "QConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/assistants/");
    try path_buf.appendSlice(allocator, input.assistant_id);
    try path_buf.appendSlice(allocator, "/sessions/");
    try path_buf.appendSlice(allocator, input.session_id);
    try path_buf.appendSlice(allocator, "/data");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"data\":");
    try aws.json.writeValue(@TypeOf(input.data), input.data, allocator, &body_buf);
    has_prev = true;
    if (input.namespace) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"namespace\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSessionDataOutput {
    var result: UpdateSessionDataOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateSessionDataOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AllowMessages = @import("allow_messages.zig").AllowMessages;

pub const UpdateAppInstanceUserEndpointInput = struct {
    /// Boolean that controls whether the `AppInstanceUserEndpoint` is opted in to
    /// receive messages. `ALL` indicates the endpoint will receive all messages.
    /// `NONE` indicates the endpoint will receive no messages.
    allow_messages: ?AllowMessages = null,

    /// The ARN of the `AppInstanceUser`.
    app_instance_user_arn: []const u8,

    /// The unique identifier of the `AppInstanceUserEndpoint`.
    endpoint_id: []const u8,

    /// The name of the `AppInstanceUserEndpoint`.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .allow_messages = "AllowMessages",
        .app_instance_user_arn = "AppInstanceUserArn",
        .endpoint_id = "EndpointId",
        .name = "Name",
    };
};

pub const UpdateAppInstanceUserEndpointOutput = struct {
    /// The ARN of the `AppInstanceUser`.
    app_instance_user_arn: ?[]const u8 = null,

    /// The unique identifier of the `AppInstanceUserEndpoint`.
    endpoint_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_instance_user_arn = "AppInstanceUserArn",
        .endpoint_id = "EndpointId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAppInstanceUserEndpointInput, options: CallOptions) !UpdateAppInstanceUserEndpointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "chime", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAppInstanceUserEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("identity-chime", "Chime SDK Identity", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/app-instance-users/");
    try path_buf.appendSlice(allocator, input.app_instance_user_arn);
    try path_buf.appendSlice(allocator, "/endpoints/");
    try path_buf.appendSlice(allocator, input.endpoint_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.allow_messages) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AllowMessages\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAppInstanceUserEndpointOutput {
    var result: UpdateAppInstanceUserEndpointOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateAppInstanceUserEndpointOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

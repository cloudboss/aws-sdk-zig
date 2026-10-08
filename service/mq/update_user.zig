const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateUserInput = struct {
    /// The unique ID that Amazon MQ generates for the broker.
    broker_id: []const u8,

    /// Enables access to the the ActiveMQ Web Console for the ActiveMQ user.
    console_access: ?bool = null,

    /// The list of groups (20 maximum) to which the ActiveMQ user belongs. This
    /// value can contain only alphanumeric characters, dashes, periods,
    /// underscores, and tildes (- . _ ~). This value must be 2-100 characters long.
    groups: ?[]const []const u8 = null,

    /// The password of the user. This value must be at least 12 characters long,
    /// must contain at least 4 unique characters, and must not contain commas,
    /// colons, or equal signs (,:=).
    password: ?[]const u8 = null,

    /// Defines whether the user is intended for data replication.
    replication_user: ?bool = null,

    /// The username of the ActiveMQ user. This value can contain only alphanumeric
    /// characters, dashes, periods, underscores, and tildes (- . _ ~). This value
    /// must be 2-100 characters long.
    username: []const u8,

    pub const json_field_names = .{
        .broker_id = "BrokerId",
        .console_access = "ConsoleAccess",
        .groups = "Groups",
        .password = "Password",
        .replication_user = "ReplicationUser",
        .username = "Username",
    };
};

pub const UpdateUserOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateUserInput, options: CallOptions) !UpdateUserOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mq", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateUserInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mq", "mq", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/brokers/");
    try path_buf.appendSlice(allocator, input.broker_id);
    try path_buf.appendSlice(allocator, "/users/");
    try path_buf.appendSlice(allocator, input.username);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.console_access) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ConsoleAccess\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.groups) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Groups\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.password) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Password\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.replication_user) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ReplicationUser\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateUserOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateUserOutput = .{};

    return result;
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EventFilter = @import("event_filter.zig").EventFilter;
const LogConfiguration = @import("log_configuration.zig").LogConfiguration;
const SessionLogger = @import("session_logger.zig").SessionLogger;

pub const UpdateSessionLoggerInput = struct {
    /// The updated display name.
    display_name: ?[]const u8 = null,

    /// The updated eventFilter.
    event_filter: ?EventFilter = null,

    /// The updated logConfiguration.
    log_configuration: ?LogConfiguration = null,

    /// The ARN of the session logger to update.
    session_logger_arn: []const u8,

    pub const json_field_names = .{
        .display_name = "displayName",
        .event_filter = "eventFilter",
        .log_configuration = "logConfiguration",
        .session_logger_arn = "sessionLoggerArn",
    };
};

pub const UpdateSessionLoggerOutput = struct {
    /// The updated details of the session logger.
    session_logger: ?SessionLogger = null,

    pub const json_field_names = .{
        .session_logger = "sessionLogger",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSessionLoggerInput, options: CallOptions) !UpdateSessionLoggerOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workspaces-web", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSessionLoggerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workspaces-web", "WorkSpaces Web", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/sessionLoggers/");
    try path_buf.appendSlice(allocator, input.session_logger_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.display_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"displayName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.event_filter) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"eventFilter\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.log_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"logConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSessionLoggerOutput {
    var result: UpdateSessionLoggerOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateSessionLoggerOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LoggingDestination = @import("logging_destination.zig").LoggingDestination;
const QueryLoggingConfigurationStatus = @import("query_logging_configuration_status.zig").QueryLoggingConfigurationStatus;

pub const CreateQueryLoggingConfigurationInput = struct {
    /// (Optional) A unique, case-sensitive identifier that you can provide to
    /// ensure the idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The destinations where query logs will be sent. Only CloudWatch Logs
    /// destination is supported. The list must contain exactly one element.
    destinations: []const LoggingDestination,

    /// The ID of the workspace for which to create the query logging configuration.
    workspace_id: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .destinations = "destinations",
        .workspace_id = "workspaceId",
    };
};

pub const CreateQueryLoggingConfigurationOutput = struct {
    /// The current status of the query logging configuration.
    status: ?QueryLoggingConfigurationStatus = null,

    pub const json_field_names = .{
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateQueryLoggingConfigurationInput, options: CallOptions) !CreateQueryLoggingConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "aps", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateQueryLoggingConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("aps", "amp", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_id);
    try path_buf.appendSlice(allocator, "/logging/query");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"destinations\":");
    try aws.json.writeValue(@TypeOf(input.destinations), input.destinations, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateQueryLoggingConfigurationOutput {
    const result: CreateQueryLoggingConfigurationOutput = try aws.json.parseJsonObject(
        CreateQueryLoggingConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

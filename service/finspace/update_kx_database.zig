const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateKxDatabaseInput = struct {
    /// A token that ensures idempotency. This token expires in 10 minutes.
    client_token: []const u8,

    /// The name of the kdb database.
    database_name: []const u8,

    /// A description of the database.
    description: ?[]const u8 = null,

    /// A unique identifier for the kdb environment.
    environment_id: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .database_name = "databaseName",
        .description = "description",
        .environment_id = "environmentId",
    };
};

pub const UpdateKxDatabaseOutput = struct {
    /// The name of the kdb database.
    database_name: ?[]const u8 = null,

    /// A description of the database.
    description: ?[]const u8 = null,

    /// A unique identifier for the kdb environment.
    environment_id: ?[]const u8 = null,

    /// The last time that the database was modified. The value is determined as
    /// epoch time in milliseconds. For example, the value for Monday, November 1,
    /// 2021 12:00:00 PM UTC is specified as 1635768000000.
    last_modified_timestamp: ?i64 = null,

    pub const json_field_names = .{
        .database_name = "databaseName",
        .description = "description",
        .environment_id = "environmentId",
        .last_modified_timestamp = "lastModifiedTimestamp",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateKxDatabaseInput, options: CallOptions) !UpdateKxDatabaseOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "finspace", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateKxDatabaseInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("finspace", "finspace", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/kx/environments/");
    try path_buf.appendSlice(allocator, input.environment_id);
    try path_buf.appendSlice(allocator, "/databases/");
    try path_buf.appendSlice(allocator, input.database_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"clientToken\":");
    try aws.json.writeValue(@TypeOf(input.client_token), input.client_token, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateKxDatabaseOutput {
    var result: UpdateKxDatabaseOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateKxDatabaseOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

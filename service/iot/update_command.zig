const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateCommandInput = struct {
    /// The unique identifier of the command to be updated.
    command_id: []const u8,

    /// A boolean that you can use to specify whether to deprecate a command.
    deprecated: ?bool = null,

    /// A short text description of the command.
    description: ?[]const u8 = null,

    /// The new user-friendly name to use in the console for the command.
    display_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .command_id = "commandId",
        .deprecated = "deprecated",
        .description = "description",
        .display_name = "displayName",
    };
};

pub const UpdateCommandOutput = struct {
    /// The unique identifier of the command.
    command_id: ?[]const u8 = null,

    /// The boolean that indicates whether the command was deprecated.
    deprecated: ?bool = null,

    /// The updated text description of the command.
    description: ?[]const u8 = null,

    /// The updated user-friendly display name in the console for the command.
    display_name: ?[]const u8 = null,

    /// The date and time (epoch timestamp in seconds) when the command was last
    /// updated.
    last_updated_at: ?i64 = null,

    pub const json_field_names = .{
        .command_id = "commandId",
        .deprecated = "deprecated",
        .description = "description",
        .display_name = "displayName",
        .last_updated_at = "lastUpdatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateCommandInput, options: CallOptions) !UpdateCommandOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateCommandInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/commands/");
    try path_buf.appendSlice(allocator, input.command_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.deprecated) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"deprecated\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.display_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"displayName\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateCommandOutput {
    const result: UpdateCommandOutput = try aws.json.parseJsonObject(
        UpdateCommandOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

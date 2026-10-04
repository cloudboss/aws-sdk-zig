const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataRetentionActionType = @import("data_retention_action_type.zig").DataRetentionActionType;

pub const UpdateDataRetentionInput = struct {
    /// The action to perform. Valid values are 'ENABLE' (to enable the data
    /// retention service), 'DISABLE' (to disable the service), or 'PUBKEY_MSG_ACK'
    /// (to acknowledge the public key message).
    action_type: DataRetentionActionType,

    /// The ID of the Wickr network containing the data retention bot.
    network_id: []const u8,

    pub const json_field_names = .{
        .action_type = "actionType",
        .network_id = "networkId",
    };
};

pub const UpdateDataRetentionOutput = struct {
    /// A message indicating the result of the update operation.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "message",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDataRetentionInput, options: CallOptions) !UpdateDataRetentionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "wickr", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDataRetentionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("admin.wickr", "Wickr", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/networks/");
    try path_buf.appendSlice(allocator, input.network_id);
    try path_buf.appendSlice(allocator, "/data-retention-bots");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"actionType\":");
    try aws.json.writeValue(@TypeOf(input.action_type), input.action_type, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDataRetentionOutput {
    var result: UpdateDataRetentionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateDataRetentionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RetentionSettings = @import("retention_settings.zig").RetentionSettings;

pub const PutRetentionSettingsInput = struct {
    /// The Amazon Chime account ID.
    account_id: []const u8,

    /// The retention settings.
    retention_settings: RetentionSettings,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .retention_settings = "RetentionSettings",
    };
};

pub const PutRetentionSettingsOutput = struct {
    /// The timestamp representing the time at which the specified items are
    /// permanently deleted, in ISO 8601 format.
    initiate_deletion_timestamp: ?i64 = null,

    /// The retention settings.
    retention_settings: ?RetentionSettings = null,

    pub const json_field_names = .{
        .initiate_deletion_timestamp = "InitiateDeletionTimestamp",
        .retention_settings = "RetentionSettings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutRetentionSettingsInput, options: CallOptions) !PutRetentionSettingsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutRetentionSettingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("chime", "Chime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.account_id);
    try path_buf.appendSlice(allocator, "/retention-settings");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RetentionSettings\":");
    try aws.json.writeValue(@TypeOf(input.retention_settings), input.retention_settings, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutRetentionSettingsOutput {
    const result: PutRetentionSettingsOutput = try aws.json.parseJsonObject(
        PutRetentionSettingsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

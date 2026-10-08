const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssetFileBody = @import("asset_file_body.zig").AssetFileBody;
const AssetFile = @import("asset_file.zig").AssetFile;

pub const UpdateAssetFileInput = struct {
    /// The unique identifier for the agent space containing the asset
    agent_space_id: []const u8,

    /// The unique identifier of the asset containing the file
    asset_id: []const u8,

    /// A unique, case-sensitive identifier used for idempotent asset file update
    client_token: ?[]const u8 = null,

    /// Updated file content. If omitted, the existing content is unchanged.
    content: ?AssetFileBody = null,

    /// Metadata fields to update. Only the fields present in this document are
    /// updated. Omitted fields retain their current values.
    metadata: ?[]const u8 = null,

    /// The path of the file within the asset to update
    path: []const u8,

    pub const json_field_names = .{
        .agent_space_id = "agentSpaceId",
        .asset_id = "assetId",
        .client_token = "clientToken",
        .content = "content",
        .metadata = "metadata",
        .path = "path",
    };
};

pub const UpdateAssetFileOutput = struct {
    /// The asset file object
    file: ?AssetFile = null,

    pub const json_field_names = .{
        .file = "file",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAssetFileInput, options: CallOptions) !UpdateAssetFileOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "aidevops", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAssetFileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("aidevops", "DevOps Agent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/asset/agent-space/");
    try path_buf.appendSlice(allocator, input.agent_space_id);
    try path_buf.appendSlice(allocator, "/assets/");
    try path_buf.appendSlice(allocator, input.asset_id);
    try path_buf.appendSlice(allocator, "/files/");
    try path_buf.appendSlice(allocator, input.path);
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
    if (input.content) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"content\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.metadata) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"metadata\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAssetFileOutput {
    const result: UpdateAssetFileOutput = try aws.json.parseJsonObject(
        UpdateAssetFileOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

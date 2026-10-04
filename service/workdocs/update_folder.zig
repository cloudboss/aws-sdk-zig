const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceStateType = @import("resource_state_type.zig").ResourceStateType;

pub const UpdateFolderInput = struct {
    /// Amazon WorkDocs authentication token. Not required when using Amazon Web
    /// Services administrator credentials to access the API.
    authentication_token: ?[]const u8 = null,

    /// The ID of the folder.
    folder_id: []const u8,

    /// The name of the folder.
    name: ?[]const u8 = null,

    /// The ID of the parent folder.
    parent_folder_id: ?[]const u8 = null,

    /// The resource state of the folder. Only ACTIVE and RECYCLED are accepted
    /// values from
    /// the API.
    resource_state: ?ResourceStateType = null,

    pub const json_field_names = .{
        .authentication_token = "AuthenticationToken",
        .folder_id = "FolderId",
        .name = "Name",
        .parent_folder_id = "ParentFolderId",
        .resource_state = "ResourceState",
    };
};

pub const UpdateFolderOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateFolderInput, options: CallOptions) !UpdateFolderOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workdocs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateFolderInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workdocs", "WorkDocs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/api/v1/folders/");
    try path_buf.appendSlice(allocator, input.folder_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.parent_folder_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ParentFolderId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.resource_state) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ResourceState\":");
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
    if (input.authentication_token) |v| {
        try request.headers.put(allocator, "Authentication", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateFolderOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateFolderOutput = .{};

    return result;
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateWorkspaceInput = struct {
    /// The description of the workspace.
    description: ?[]const u8 = null,

    /// The ARN of the execution role associated with the workspace.
    role: ?[]const u8 = null,

    /// The ARN of the S3 bucket where resources associated with the workspace are
    /// stored.
    s_3_location: ?[]const u8 = null,

    /// The ID of the workspace.
    workspace_id: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .role = "role",
        .s_3_location = "s3Location",
        .workspace_id = "workspaceId",
    };
};

pub const UpdateWorkspaceOutput = struct {
    /// The date and time of the current update.
    update_date_time: i64,

    pub const json_field_names = .{
        .update_date_time = "updateDateTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateWorkspaceInput, options: CallOptions) !UpdateWorkspaceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "awsiottwinmaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateWorkspaceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iottwinmaker", "IoTTwinMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.role) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"role\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.s_3_location) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"s3Location\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateWorkspaceOutput {
    var result: UpdateWorkspaceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateWorkspaceOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

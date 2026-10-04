const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkspaceEncryptionConfiguration = @import("workspace_encryption_configuration.zig").WorkspaceEncryptionConfiguration;
const WorkspaceStatus = @import("workspace_status.zig").WorkspaceStatus;

pub const UpdateWorkspaceInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure that the
    /// request is
    /// idempotent. If you retry a request that completed successfully using the
    /// same client token,
    /// the retry succeeds without performing any further actions.
    client_token: ?[]const u8 = null,

    /// The encryption configuration for the workspace. Omit this field to leave
    /// encryption
    /// unchanged. After a customer managed key configuration becomes active, the
    /// key can't be
    /// changed; supplying the same key is accepted.
    encryption_configuration: ?WorkspaceEncryptionConfiguration = null,

    /// A new description for the workspace.
    workspace_description: ?[]const u8 = null,

    /// The name of the workspace to update.
    workspace_name: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .encryption_configuration = "encryptionConfiguration",
        .workspace_description = "workspaceDescription",
        .workspace_name = "workspaceName",
    };
};

pub const UpdateWorkspaceOutput = struct {
    /// The status of the workspace after the update, which is `UPDATING` when the
    /// operation returns.
    workspace_status: ?WorkspaceStatus = null,

    pub const json_field_names = .{
        .workspace_status = "workspaceStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateWorkspaceInput, options: CallOptions) !UpdateWorkspaceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotsitewise", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_name);
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
    if (input.encryption_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"encryptionConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.workspace_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"workspaceDescription\":");
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
    const result: UpdateWorkspaceOutput = try aws.json.parseJsonObject(
        UpdateWorkspaceOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

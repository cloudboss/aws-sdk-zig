const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PermissionInput = @import("permission_input.zig").PermissionInput;
const PermissionOutput = @import("permission_output.zig").PermissionOutput;

pub const UpdateQAppPermissionsInput = struct {
    /// The unique identifier of the Amazon Q App for which permissions are being
    /// updated.
    app_id: []const u8,

    /// The list of permissions to grant for the Amazon Q App.
    grant_permissions: ?[]const PermissionInput = null,

    /// The unique identifier of the Amazon Q Business application environment
    /// instance.
    instance_id: []const u8,

    /// The list of permissions to revoke for the Amazon Q App.
    revoke_permissions: ?[]const PermissionInput = null,

    pub const json_field_names = .{
        .app_id = "appId",
        .grant_permissions = "grantPermissions",
        .instance_id = "instanceId",
        .revoke_permissions = "revokePermissions",
    };
};

pub const UpdateQAppPermissionsOutput = struct {
    /// The unique identifier of the Amazon Q App for which permissions were
    /// updated.
    app_id: ?[]const u8 = null,

    /// The updated list of permissions for the Amazon Q App.
    permissions: ?[]const PermissionOutput = null,

    /// The Amazon Resource Name (ARN) of the Amazon Q App for which permissions
    /// were updated.
    resource_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_id = "appId",
        .permissions = "permissions",
        .resource_arn = "resourceArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateQAppPermissionsInput, options: CallOptions) !UpdateQAppPermissionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "qapps", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateQAppPermissionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("data.qapps", "QApps", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/apps.updateQAppPermissions";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"appId\":");
    try aws.json.writeValue(@TypeOf(input.app_id), input.app_id, allocator, &body_buf);
    has_prev = true;
    if (input.grant_permissions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"grantPermissions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.revoke_permissions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"revokePermissions\":");
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
    try request.headers.put(allocator, "instance-id", input.instance_id);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateQAppPermissionsOutput {
    const result: UpdateQAppPermissionsOutput = try aws.json.parseJsonObject(
        UpdateQAppPermissionsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

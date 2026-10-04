const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourcePermission = @import("resource_permission.zig").ResourcePermission;
const LinkSharingConfiguration = @import("link_sharing_configuration.zig").LinkSharingConfiguration;

pub const UpdateDashboardPermissionsInput = struct {
    /// The ID of the Amazon Web Services account that contains the dashboard whose
    /// permissions
    /// you're updating.
    aws_account_id: []const u8,

    /// The ID for the dashboard.
    dashboard_id: []const u8,

    /// Grants link permissions to all users in a defined namespace.
    grant_link_permissions: ?[]const ResourcePermission = null,

    /// The permissions that you want to grant on this resource.
    grant_permissions: ?[]const ResourcePermission = null,

    /// Revokes link permissions from all users in a defined namespace.
    revoke_link_permissions: ?[]const ResourcePermission = null,

    /// The permissions that you want to revoke from this resource.
    revoke_permissions: ?[]const ResourcePermission = null,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .dashboard_id = "DashboardId",
        .grant_link_permissions = "GrantLinkPermissions",
        .grant_permissions = "GrantPermissions",
        .revoke_link_permissions = "RevokeLinkPermissions",
        .revoke_permissions = "RevokePermissions",
    };
};

pub const UpdateDashboardPermissionsOutput = struct {
    /// The Amazon Resource Name (ARN) of the dashboard.
    dashboard_arn: ?[]const u8 = null,

    /// The ID for the dashboard.
    dashboard_id: ?[]const u8 = null,

    /// Updates the permissions of a shared link to an Quick Sight dashboard.
    link_sharing_configuration: ?LinkSharingConfiguration = null,

    /// Information about the permissions on the dashboard.
    permissions: ?[]const ResourcePermission = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: ?i32 = null,

    pub const json_field_names = .{
        .dashboard_arn = "DashboardArn",
        .dashboard_id = "DashboardId",
        .link_sharing_configuration = "LinkSharingConfiguration",
        .permissions = "Permissions",
        .request_id = "RequestId",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDashboardPermissionsInput, options: CallOptions) !UpdateDashboardPermissionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "quicksight", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDashboardPermissionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/dashboards/");
    try path_buf.appendSlice(allocator, input.dashboard_id);
    try path_buf.appendSlice(allocator, "/permissions");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.grant_link_permissions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"GrantLinkPermissions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.grant_permissions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"GrantPermissions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.revoke_link_permissions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RevokeLinkPermissions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.revoke_permissions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RevokePermissions\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDashboardPermissionsOutput {
    var result: UpdateDashboardPermissionsOutput = try aws.json.parseJsonObject(
        UpdateDashboardPermissionsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    result.status = @intCast(status);
    _ = headers;

    return result;
}

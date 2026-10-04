const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourcePermission = @import("resource_permission.zig").ResourcePermission;

pub const UpdateTemplatePermissionsInput = struct {
    /// The ID of the Amazon Web Services account that contains the template.
    aws_account_id: []const u8,

    /// A list of resource permissions to be granted on the template.
    grant_permissions: ?[]const ResourcePermission = null,

    /// A list of resource permissions to be revoked from the template.
    revoke_permissions: ?[]const ResourcePermission = null,

    /// The ID for the template.
    template_id: []const u8,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .grant_permissions = "GrantPermissions",
        .revoke_permissions = "RevokePermissions",
        .template_id = "TemplateId",
    };
};

pub const UpdateTemplatePermissionsOutput = struct {
    /// A list of resource permissions to be set on the template.
    permissions: ?[]const ResourcePermission = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: ?i32 = null,

    /// The Amazon Resource Name (ARN) of the template.
    template_arn: ?[]const u8 = null,

    /// The ID for the template.
    template_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .permissions = "Permissions",
        .request_id = "RequestId",
        .status = "Status",
        .template_arn = "TemplateArn",
        .template_id = "TemplateId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateTemplatePermissionsInput, options: CallOptions) !UpdateTemplatePermissionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateTemplatePermissionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/templates/");
    try path_buf.appendSlice(allocator, input.template_id);
    try path_buf.appendSlice(allocator, "/permissions");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.grant_permissions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"GrantPermissions\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateTemplatePermissionsOutput {
    var result: UpdateTemplatePermissionsOutput = try aws.json.parseJsonObject(
        UpdateTemplatePermissionsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    result.status = @intCast(status);
    _ = headers;

    return result;
}

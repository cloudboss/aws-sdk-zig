const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ApplicationPermission = @import("application_permission.zig").ApplicationPermission;

pub const CreatePermissionGroupInput = struct {
    /// The option to indicate FinSpace application permissions that are granted to
    /// a specific group.
    ///
    /// When assigning application permissions, be aware that the permission
    /// `ManageUsersAndGroups` allows users to grant themselves or others access to
    /// any functionality in their FinSpace environment's application. It should
    /// only be granted to trusted users.
    ///
    /// * `CreateDataset` – Group members can create new datasets.
    ///
    /// * `ManageClusters` – Group members can manage Apache Spark clusters from
    ///   FinSpace notebooks.
    ///
    /// * `ManageUsersAndGroups` – Group members can manage users and permission
    ///   groups. This is a privileged permission that allows users to grant
    ///   themselves or others access to any functionality in the application. It
    ///   should only be granted to trusted users.
    ///
    /// * `ManageAttributeSets` – Group members can manage attribute sets.
    ///
    /// * `ViewAuditData` – Group members can view audit data.
    ///
    /// * `AccessNotebooks` – Group members will have access to FinSpace notebooks.
    ///
    /// * `GetTemporaryCredentials` – Group members can get temporary API
    ///   credentials.
    application_permissions: []const ApplicationPermission,

    /// A token that ensures idempotency. This token expires in 10 minutes.
    client_token: ?[]const u8 = null,

    /// A brief description for the permission group.
    description: ?[]const u8 = null,

    /// The name of the permission group.
    name: []const u8,

    pub const json_field_names = .{
        .application_permissions = "applicationPermissions",
        .client_token = "clientToken",
        .description = "description",
        .name = "name",
    };
};

pub const CreatePermissionGroupOutput = struct {
    /// The unique identifier for the permission group.
    permission_group_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .permission_group_id = "permissionGroupId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePermissionGroupInput, options: CallOptions) !CreatePermissionGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "finspace-api", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePermissionGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("finspace-api", "finspace data", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/permission-group";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"applicationPermissions\":");
    try aws.json.writeValue(@TypeOf(input.application_permissions), input.application_permissions, allocator, &body_buf);
    has_prev = true;
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePermissionGroupOutput {
    const result: CreatePermissionGroupOutput = try aws.json.parseJsonObject(
        CreatePermissionGroupOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

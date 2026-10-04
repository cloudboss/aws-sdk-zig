const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Condition = @import("condition.zig").Condition;
const Permission = @import("permission.zig").Permission;
const DataLakePrincipal = @import("data_lake_principal.zig").DataLakePrincipal;
const Resource = @import("resource.zig").Resource;

pub const GrantPermissionsInput = struct {
    /// The identifier for the Data Catalog. By default, the account ID. The Data
    /// Catalog is the persistent metadata store. It contains database definitions,
    /// table definitions, and other control information to manage your Lake
    /// Formation environment.
    catalog_id: ?[]const u8 = null,

    condition: ?Condition = null,

    /// The permissions granted to the principal on the resource. Lake Formation
    /// defines privileges to grant and revoke access to metadata in the Data
    /// Catalog and data organized in underlying data storage such as Amazon S3.
    /// Lake Formation requires that each principal be authorized to perform a
    /// specific task on Lake Formation resources.
    permissions: []const Permission,

    /// Indicates a list of the granted permissions that the principal may pass to
    /// other users. These permissions may only be a subset of the permissions
    /// granted in the `Privileges`.
    permissions_with_grant_option: ?[]const Permission = null,

    /// The principal to be granted the permissions on the resource. Supported
    /// principals are IAM users or IAM roles, and they are defined by their
    /// principal type and their ARN.
    ///
    /// Note that if you define a resource with a particular ARN, then later delete,
    /// and recreate a resource with that same ARN, the resource maintains the
    /// permissions already granted.
    principal: DataLakePrincipal,

    /// The resource to which permissions are to be granted. Resources in Lake
    /// Formation are the Data Catalog, databases, and tables.
    resource: Resource,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .condition = "Condition",
        .permissions = "Permissions",
        .permissions_with_grant_option = "PermissionsWithGrantOption",
        .principal = "Principal",
        .resource = "Resource",
    };
};

pub const GrantPermissionsOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GrantPermissionsInput, options: CallOptions) !GrantPermissionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lakeformation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GrantPermissionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lakeformation", "LakeFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/GrantPermissions";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.catalog_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CatalogId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.condition) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Condition\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Permissions\":");
    try aws.json.writeValue(@TypeOf(input.permissions), input.permissions, allocator, &body_buf);
    has_prev = true;
    if (input.permissions_with_grant_option) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PermissionsWithGrantOption\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Principal\":");
    try aws.json.writeValue(@TypeOf(input.principal), input.principal, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Resource\":");
    try aws.json.writeValue(@TypeOf(input.resource), input.resource, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GrantPermissionsOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: GrantPermissionsOutput = .{};

    return result;
}

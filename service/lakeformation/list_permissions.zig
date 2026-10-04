const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataLakePrincipal = @import("data_lake_principal.zig").DataLakePrincipal;
const Resource = @import("resource.zig").Resource;
const DataLakeResourceType = @import("data_lake_resource_type.zig").DataLakeResourceType;
const PrincipalResourcePermissions = @import("principal_resource_permissions.zig").PrincipalResourcePermissions;

pub const ListPermissionsInput = struct {
    /// The identifier for the Data Catalog. By default, the account ID. The Data
    /// Catalog is the persistent metadata store. It contains database definitions,
    /// table definitions, and other control information to manage your Lake
    /// Formation environment.
    catalog_id: ?[]const u8 = null,

    /// Indicates that related permissions should be included in the results when
    /// listing permissions on a table resource.
    ///
    /// Set the field to `TRUE` to show the cell filters on a table resource.
    /// Default
    /// is `FALSE`. The Principal parameter must not be specified when requesting
    /// cell
    /// filter information.
    include_related: ?[]const u8 = null,

    /// The maximum number of results to return.
    max_results: ?i32 = null,

    /// A continuation token, if this is not the first call to retrieve this list.
    next_token: ?[]const u8 = null,

    /// Specifies a principal to filter the permissions returned.
    principal: ?DataLakePrincipal = null,

    /// A resource where you will get a list of the principal permissions.
    ///
    /// This operation does not support getting privileges on a table with columns.
    /// Instead, call this operation on the table, and the operation returns the
    /// table and the table w columns.
    resource: ?Resource = null,

    /// Specifies a resource type to filter the permissions returned.
    resource_type: ?DataLakeResourceType = null,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .include_related = "IncludeRelated",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .principal = "Principal",
        .resource = "Resource",
        .resource_type = "ResourceType",
    };
};

pub const ListPermissionsOutput = struct {
    /// A continuation token, if this is not the first call to retrieve this list.
    next_token: ?[]const u8 = null,

    /// A list of principals and their permissions on the resource for the specified
    /// principal and resource types.
    principal_resource_permissions: ?[]const PrincipalResourcePermissions = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .principal_resource_permissions = "PrincipalResourcePermissions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPermissionsInput, options: CallOptions) !ListPermissionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPermissionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lakeformation", "LakeFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ListPermissions";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.catalog_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CatalogId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.include_related) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IncludeRelated\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.principal) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Principal\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.resource) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Resource\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.resource_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ResourceType\":");
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

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPermissionsOutput {
    var result: ListPermissionsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListPermissionsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PackageScopeOperationEnum = @import("package_scope_operation_enum.zig").PackageScopeOperationEnum;

pub const UpdatePackageScopeInput = struct {
    /// The operation to perform on the package scope (e.g., add/remove/override
    /// users).
    operation: PackageScopeOperationEnum,

    /// ID of the package whose scope is being updated.
    package_id: []const u8,

    /// List of users to be added or removed from the package scope.
    package_user_list: []const []const u8,

    pub const json_field_names = .{
        .operation = "Operation",
        .package_id = "PackageID",
        .package_user_list = "PackageUserList",
    };
};

pub const UpdatePackageScopeOutput = struct {
    /// The operation that was performed on the package scope.
    operation: ?PackageScopeOperationEnum = null,

    /// ID of the package whose scope was updated.
    package_id: ?[]const u8 = null,

    /// List of users who have access to the package after the scope update.
    package_user_list: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .operation = "Operation",
        .package_id = "PackageID",
        .package_user_list = "PackageUserList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdatePackageScopeInput, options: CallOptions) !UpdatePackageScopeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "es", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdatePackageScopeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "OpenSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2021-01-01/packages/updateScope";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Operation\":");
    try aws.json.writeValue(@TypeOf(input.operation), input.operation, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PackageID\":");
    try aws.json.writeValue(@TypeOf(input.package_id), input.package_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PackageUserList\":");
    try aws.json.writeValue(@TypeOf(input.package_user_list), input.package_user_list, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdatePackageScopeOutput {
    var result: UpdatePackageScopeOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdatePackageScopeOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

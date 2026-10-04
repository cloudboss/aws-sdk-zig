const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceSharePermissionDetail = @import("resource_share_permission_detail.zig").ResourceSharePermissionDetail;

pub const GetPermissionInput = struct {
    /// Specifies the [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the permission whose contents you want to retrieve.
    /// To find the ARN for a permission, use either the ListPermissions operation
    /// or go to the [Permissions
    /// library](https://console.aws.amazon.com/ram/home#Permissions:) page in the
    /// RAM console and
    /// then choose the name of the permission. The ARN is displayed on the detail
    /// page.
    permission_arn: []const u8,

    /// Specifies the version number of the RAM permission to retrieve. If you don't
    /// specify
    /// this parameter, the operation retrieves the default version.
    ///
    /// To see the list of available versions, use ListPermissionVersions.
    permission_version: ?i32 = null,

    pub const json_field_names = .{
        .permission_arn = "permissionArn",
        .permission_version = "permissionVersion",
    };
};

pub const GetPermissionOutput = struct {
    /// An object with details about the permission.
    permission: ?ResourceSharePermissionDetail = null,

    pub const json_field_names = .{
        .permission = "permission",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPermissionInput, options: CallOptions) !GetPermissionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ram", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPermissionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ram", "RAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/getpermission";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"permissionArn\":");
    try aws.json.writeValue(@TypeOf(input.permission_arn), input.permission_arn, allocator, &body_buf);
    has_prev = true;
    if (input.permission_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"permissionVersion\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPermissionOutput {
    var result: GetPermissionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetPermissionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

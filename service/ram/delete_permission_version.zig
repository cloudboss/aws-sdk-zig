const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PermissionStatus = @import("permission_status.zig").PermissionStatus;

pub const DeletePermissionVersionInput = struct {
    /// Specifies a unique, case-sensitive identifier that you provide to
    /// ensure the idempotency of the request. This lets you safely retry the
    /// request without
    /// accidentally performing the same operation a second time. Passing the same
    /// value to a
    /// later call to an operation requires that you also pass the same value for
    /// all other
    /// parameters. We recommend that you use a [UUID type of
    /// value.](https://wikipedia.org/wiki/Universally_unique_identifier).
    ///
    /// If you don't provide this value, then Amazon Web Services generates a random
    /// one for
    /// you.
    ///
    /// If you retry the operation with the same `ClientToken`, but with
    /// different parameters, the retry fails with an `IdempotentParameterMismatch`
    /// error.
    client_token: ?[]const u8 = null,

    /// Specifies the [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the permission with the version you want to delete.
    permission_arn: []const u8,

    /// Specifies the version number to delete.
    ///
    /// You can't delete the default version for a customer managed permission.
    ///
    /// You can't delete a version if it's the only version of the permission. You
    /// must either
    /// first create another version, or delete the permission completely.
    ///
    /// You can't delete a version if it is attached to any resource shares. If the
    /// version is
    /// the default, you must first use SetDefaultPermissionVersion to set a
    /// different version as the default for the customer managed permission, and
    /// then use AssociateResourceSharePermission to update your resource shares to
    /// use
    /// the new default version.
    permission_version: i32,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .permission_arn = "permissionArn",
        .permission_version = "permissionVersion",
    };
};

pub const DeletePermissionVersionOutput = struct {
    /// The idempotency identifier associated with this request. If you
    /// want to repeat the same operation in an idempotent manner then you must
    /// include this
    /// value in the `clientToken` request parameter of that later call. All other
    /// parameters must also have the same values that you used in the first call.
    client_token: ?[]const u8 = null,

    /// This operation is performed asynchronously, and this response parameter
    /// indicates the
    /// current status.
    permission_status: ?PermissionStatus = null,

    /// A boolean value that indicates whether the operation is successful.
    return_value: ?bool = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .permission_status = "permissionStatus",
        .return_value = "returnValue",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeletePermissionVersionInput, options: CallOptions) !DeletePermissionVersionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeletePermissionVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ram", "RAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/deletepermissionversion";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.client_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "clientToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "permissionArn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.permission_arn);
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "permissionVersion=");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{input.permission_version}) catch "";
        try query_buf.appendSlice(allocator, num_str);
    }
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeletePermissionVersionOutput {
    var result: DeletePermissionVersionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DeletePermissionVersionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const AssociateResourceSharePermissionInput = struct {
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
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the RAM permission to associate with the resource share.
    /// To find the ARN for a permission, use either the ListPermissions operation
    /// or go to the [Permissions
    /// library](https://console.aws.amazon.com/ram/home#Permissions:) page in the
    /// RAM console and
    /// then choose the name of the permission. The ARN is displayed on the detail
    /// page.
    permission_arn: []const u8,

    /// Specifies the version of the RAM permission to associate with the resource
    /// share. You can
    /// specify *only* the version that is currently set as the default
    /// version for the permission. If you also set the `replace` pararameter to
    /// `true`, then this operation updates an outdated version of the permission
    /// to the current default version.
    ///
    /// You don't need to specify this parameter because the default behavior is to
    /// use
    /// the version that is currently set as the default version for the permission.
    /// This
    /// parameter is supported for backwards compatibility.
    permission_version: ?i32 = null,

    /// Specifies whether the specified permission should replace the existing
    /// permission
    /// associated with the resource share. Use `true` to replace the current
    /// permissions. Use
    /// `false` to add the permission to a resource share that currently doesn't
    /// have a permission. The default value is `false`.
    ///
    /// A resource share can have only one permission per resource type. If a
    /// resource share already has a
    /// permission for the specified resource type and you don't set `replace` to
    /// `true` then the operation returns an error. This helps prevent
    /// accidental overwriting of a permission.
    replace: ?bool = null,

    /// Specifies the [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the resource share to which you want to add or replace
    /// permissions.
    resource_share_arn: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .permission_arn = "permissionArn",
        .permission_version = "permissionVersion",
        .replace = "replace",
        .resource_share_arn = "resourceShareArn",
    };
};

pub const AssociateResourceSharePermissionOutput = struct {
    /// The idempotency identifier associated with this request. If you
    /// want to repeat the same operation in an idempotent manner then you must
    /// include this
    /// value in the `clientToken` request parameter of that later call. All other
    /// parameters must also have the same values that you used in the first call.
    client_token: ?[]const u8 = null,

    /// A return value of `true` indicates that the request succeeded.
    /// A value of `false` indicates that the request failed.
    return_value: ?bool = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .return_value = "returnValue",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateResourceSharePermissionInput, options: CallOptions) !AssociateResourceSharePermissionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateResourceSharePermissionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ram", "RAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/associateresourcesharepermission";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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
    if (input.replace) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"replace\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"resourceShareArn\":");
    try aws.json.writeValue(@TypeOf(input.resource_share_arn), input.resource_share_arn, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateResourceSharePermissionOutput {
    var result: AssociateResourceSharePermissionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(AssociateResourceSharePermissionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

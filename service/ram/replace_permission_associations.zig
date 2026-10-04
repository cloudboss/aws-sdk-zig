const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReplacePermissionAssociationsWork = @import("replace_permission_associations_work.zig").ReplacePermissionAssociationsWork;

pub const ReplacePermissionAssociationsInput = struct {
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
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the managed permission that you want to replace.
    from_permission_arn: []const u8,

    /// Specifies that you want to updated the permissions for only those resource
    /// shares that use the
    /// specified version of the managed permission.
    from_permission_version: ?i32 = null,

    /// Specifies the ARN of the managed permission that you want to associate with
    /// resource
    /// shares in place of the one specified by `fromPerssionArn` and
    /// `fromPermissionVersion`.
    ///
    /// The operation always associates the version that is currently the default
    /// for the
    /// specified managed permission.
    to_permission_arn: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .from_permission_arn = "fromPermissionArn",
        .from_permission_version = "fromPermissionVersion",
        .to_permission_arn = "toPermissionArn",
    };
};

pub const ReplacePermissionAssociationsOutput = struct {
    /// The idempotency identifier associated with this request. If you
    /// want to repeat the same operation in an idempotent manner then you must
    /// include this
    /// value in the `clientToken` request parameter of that later call. All other
    /// parameters must also have the same values that you used in the first call.
    client_token: ?[]const u8 = null,

    /// Specifies a data structure that you can use to track the asynchronous tasks
    /// that RAM
    /// performs to complete this operation. You can use the
    /// ListReplacePermissionAssociationsWork operation and pass the
    /// `id` value returned in this structure.
    replace_permission_associations_work: ?ReplacePermissionAssociationsWork = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .replace_permission_associations_work = "replacePermissionAssociationsWork",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ReplacePermissionAssociationsInput, options: CallOptions) !ReplacePermissionAssociationsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ReplacePermissionAssociationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ram", "RAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/replacepermissionassociations";

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
    try body_buf.appendSlice(allocator, "\"fromPermissionArn\":");
    try aws.json.writeValue(@TypeOf(input.from_permission_arn), input.from_permission_arn, allocator, &body_buf);
    has_prev = true;
    if (input.from_permission_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"fromPermissionVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"toPermissionArn\":");
    try aws.json.writeValue(@TypeOf(input.to_permission_arn), input.to_permission_arn, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ReplacePermissionAssociationsOutput {
    var result: ReplacePermissionAssociationsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ReplacePermissionAssociationsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

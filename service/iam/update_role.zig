const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateRoleInput = struct {
    /// The new description that you want to apply to the specified role.
    description: ?[]const u8 = null,

    /// The maximum session duration (in seconds) that you want to set for the
    /// specified role.
    /// If you do not specify a value for this setting, the default value of one
    /// hour is
    /// applied. This setting can have a value from 1 hour to 12 hours.
    ///
    /// Anyone who assumes the role from the CLI or API can use the
    /// `DurationSeconds` API parameter or the `duration-seconds`
    /// CLI parameter to request a longer session. The `MaxSessionDuration` setting
    /// determines the maximum duration that can be requested using the
    /// `DurationSeconds` parameter. If users don't specify a value for the
    /// `DurationSeconds` parameter, their security credentials are valid for one
    /// hour by default. This applies when you use the `AssumeRole*` API operations
    /// or the `assume-role*` CLI operations but does not apply when you use those
    /// operations to create a console URL. For more information, see [Using IAM
    /// roles](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use.html)
    /// in the *IAM User Guide*.
    ///
    /// IAM role credentials provided by Amazon EC2 instances assigned to the role
    /// are not
    /// subject to the specified maximum session duration.
    max_session_duration: ?i32 = null,

    /// The name of the role that you want to modify.
    role_name: []const u8,
};

pub const UpdateRoleOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateRoleInput, options: CallOptions) !UpdateRoleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iam", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateRoleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iam", "IAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=UpdateRole&Version=2010-05-08");
    if (input.description) |v| {
        try body_buf.appendSlice(allocator, "&Description=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.max_session_duration) |v| {
        try body_buf.appendSlice(allocator, "&MaxSessionDuration=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    try body_buf.appendSlice(allocator, "&RoleName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.role_name);

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateRoleOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: UpdateRoleOutput = .{};

    return result;
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ApiAccess = @import("api_access.zig").ApiAccess;
const UserStatus = @import("user_status.zig").UserStatus;
const UserType = @import("user_type.zig").UserType;

pub const GetUserInput = struct {
    /// The unique identifier of the user to get data for.
    user_id: []const u8,

    pub const json_field_names = .{
        .user_id = "userId",
    };
};

pub const GetUserOutput = struct {
    /// Indicates whether the user can use the `GetProgrammaticAccessCredentials`
    /// API to obtain credentials that can then be used to access other FinSpace
    /// Data API operations.
    ///
    /// * `ENABLED` – The user has permissions to use the APIs.
    ///
    /// * `DISABLED` – The user does not have permissions to use any APIs.
    api_access: ?ApiAccess = null,

    /// The ARN identifier of an AWS user or role that is allowed to call the
    /// `GetProgrammaticAccessCredentials` API to obtain a credentials token for a
    /// specific FinSpace user. This must be an IAM role within your FinSpace
    /// account.
    api_access_principal_arn: ?[]const u8 = null,

    /// The timestamp at which the user was created in FinSpace. The value is
    /// determined as epoch time in milliseconds.
    create_time: ?i64 = null,

    /// The email address that is associated with the user.
    email_address: ?[]const u8 = null,

    /// The first name of the user.
    first_name: ?[]const u8 = null,

    /// Describes the last time the user was deactivated. The value is determined as
    /// epoch time in milliseconds.
    last_disabled_time: ?i64 = null,

    /// Describes the last time the user was activated. The value is determined as
    /// epoch time in milliseconds.
    last_enabled_time: ?i64 = null,

    /// Describes the last time that the user logged into their account. The value
    /// is determined as epoch time in milliseconds.
    last_login_time: ?i64 = null,

    /// Describes the last time the user details were updated. The value is
    /// determined as epoch time in milliseconds.
    last_modified_time: ?i64 = null,

    /// The last name of the user.
    last_name: ?[]const u8 = null,

    /// The current status of the user.
    ///
    /// * `CREATING` – The creation is in progress.
    ///
    /// * `ENABLED` – The user is created and is currently active.
    ///
    /// * `DISABLED` – The user is currently inactive.
    status: ?UserStatus = null,

    /// Indicates the type of user.
    ///
    /// * `SUPER_USER` – A user with permission to all the functionality and data in
    ///   FinSpace.
    ///
    /// * `APP_USER` – A user with specific permissions in FinSpace. The users are
    ///   assigned permissions by adding them to a permission group.
    @"type": ?UserType = null,

    /// The unique identifier for the user that is retrieved.
    user_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .api_access = "apiAccess",
        .api_access_principal_arn = "apiAccessPrincipalArn",
        .create_time = "createTime",
        .email_address = "emailAddress",
        .first_name = "firstName",
        .last_disabled_time = "lastDisabledTime",
        .last_enabled_time = "lastEnabledTime",
        .last_login_time = "lastLoginTime",
        .last_modified_time = "lastModifiedTime",
        .last_name = "lastName",
        .status = "status",
        .@"type" = "type",
        .user_id = "userId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetUserInput, options: CallOptions) !GetUserOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetUserInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("finspace-api", "finspace data", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/user/");
    try path_buf.appendSlice(allocator, input.user_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetUserOutput {
    var result: GetUserOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetUserOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

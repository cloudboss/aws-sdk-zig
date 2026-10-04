const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MFAOptionType = @import("mfa_option_type.zig").MFAOptionType;
const AttributeType = @import("attribute_type.zig").AttributeType;
const UserStatusType = @import("user_status_type.zig").UserStatusType;

pub const AdminGetUserInput = struct {
    /// The name of the user that you want to query or modify. The value of this
    /// parameter
    /// is typically your user's username, but it can be any of their alias
    /// attributes. If
    /// `username` isn't an alias attribute in your user pool, this value
    /// must be the `sub` of a local user or the username of a user from a
    /// third-party IdP.
    username: []const u8,

    /// The ID of the user pool where you want to get information about the user.
    user_pool_id: []const u8,

    pub const json_field_names = .{
        .username = "Username",
        .user_pool_id = "UserPoolId",
    };
};

pub const AdminGetUserOutput = struct {
    /// Indicates whether the user is activated for sign-in.
    enabled: ?bool = null,

    /// *This response parameter is no longer supported.* It provides
    /// information only about SMS MFA configurations. It doesn't provide
    /// information about
    /// time-based one-time password (TOTP) software token MFA configurations. To
    /// look up
    /// information about either type of MFA configuration, use UserMFASettingList
    /// instead.
    mfa_options: ?[]const MFAOptionType = null,

    /// The user's preferred MFA. Users can prefer SMS message, email message, or
    /// TOTP
    /// MFA.
    preferred_mfa_setting: ?[]const u8 = null,

    /// An array of name-value pairs of user attributes and their values, for
    /// example
    /// `"email": "testuser@example.com"`.
    user_attributes: ?[]const AttributeType = null,

    /// The date and time when the item was created. Amazon Cognito returns this
    /// timestamp in UNIX epoch time format. Your SDK might render the output in a
    /// human-readable format like ISO 8601 or a Java `Date` object.
    user_create_date: ?i64 = null,

    /// The date and time when the item was modified. Amazon Cognito returns this
    /// timestamp in UNIX epoch time format. Your SDK might render the output in a
    /// human-readable format like ISO 8601 or a Java `Date` object.
    user_last_modified_date: ?i64 = null,

    /// The MFA options that are activated for the user. The possible values in this
    /// list are
    /// `SMS_MFA`, `EMAIL_OTP`, and
    /// `SOFTWARE_TOKEN_MFA`.
    user_mfa_setting_list: ?[]const []const u8 = null,

    /// The username of the user that you requested.
    username: []const u8,

    /// The user's status. Can be one of the following:
    ///
    /// * UNCONFIRMED - User has been created but not confirmed.
    ///
    /// * CONFIRMED - User has been confirmed.
    ///
    /// * UNKNOWN - User status isn't known.
    ///
    /// * RESET_REQUIRED - User is confirmed, but the user must request a code and
    ///   reset
    /// their password before they can sign in.
    ///
    /// * FORCE_CHANGE_PASSWORD - The user is confirmed and the user can sign in
    ///   using a
    /// temporary password, but on first sign-in, the user must change their
    /// password to
    /// a new value before doing anything else.
    ///
    /// * EXTERNAL_PROVIDER - The user signed in with a third-party identity
    /// provider.
    user_status: ?UserStatusType = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .mfa_options = "MFAOptions",
        .preferred_mfa_setting = "PreferredMfaSetting",
        .user_attributes = "UserAttributes",
        .user_create_date = "UserCreateDate",
        .user_last_modified_date = "UserLastModifiedDate",
        .user_mfa_setting_list = "UserMFASettingList",
        .username = "Username",
        .user_status = "UserStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AdminGetUserInput, options: CallOptions) !AdminGetUserOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cognito-idp", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AdminGetUserInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cognito-idp", "Cognito Identity Provider", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.AdminGetUser");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AdminGetUserOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(AdminGetUserOutput, body, allocator);
}

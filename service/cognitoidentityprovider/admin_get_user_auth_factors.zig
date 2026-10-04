const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthFactorType = @import("auth_factor_type.zig").AuthFactorType;

pub const AdminGetUserAuthFactorsInput = struct {
    /// The name of the user that you want to query or modify. The value of this
    /// parameter
    /// is typically your user's username, but it can be any of their alias
    /// attributes. If
    /// `username` isn't an alias attribute in your user pool, this value
    /// must be the `sub` of a local user or the username of a user from a
    /// third-party IdP.
    username: []const u8,

    /// The ID of the user pool where you want to get information about the user's
    /// authentication factors.
    user_pool_id: []const u8,

    pub const json_field_names = .{
        .username = "Username",
        .user_pool_id = "UserPoolId",
    };
};

pub const AdminGetUserAuthFactorsOutput = struct {
    /// The authentication types that are available to the user with `USER_AUTH`
    /// sign-in, for example `["PASSWORD", "WEB_AUTHN"]`.
    ///
    /// `PASSWORD` can only be used as a first authentication factor.
    /// `SOFTWARE_TOKEN` can only be used as an MFA factor.
    /// `EMAIL_OTP`, `SMS_OTP`, and `WEB_AUTHN` can be
    /// used as either a first authentication factor or an MFA factor. `WEB_AUTHN`
    /// is available as an MFA factor only when passkey MFA is enabled at the user
    /// pool
    /// level.
    configured_user_auth_factors: ?[]const AuthFactorType = null,

    /// The challenge method that Amazon Cognito returns to the user in response to
    /// sign-in requests.
    /// Users can prefer SMS message, email message, or TOTP MFA.
    preferred_mfa_setting: ?[]const u8 = null,

    /// The MFA options that are activated for the user. The possible values in this
    /// list are
    /// `SMS_MFA`, `EMAIL_OTP`, and
    /// `SOFTWARE_TOKEN_MFA`.
    user_mfa_setting_list: ?[]const []const u8 = null,

    /// The name of the user who is eligible for the authentication factors in the
    /// response.
    username: []const u8,

    pub const json_field_names = .{
        .configured_user_auth_factors = "ConfiguredUserAuthFactors",
        .preferred_mfa_setting = "PreferredMfaSetting",
        .user_mfa_setting_list = "UserMFASettingList",
        .username = "Username",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AdminGetUserAuthFactorsInput, options: CallOptions) !AdminGetUserAuthFactorsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AdminGetUserAuthFactorsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.AdminGetUserAuthFactors");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AdminGetUserAuthFactorsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(AdminGetUserAuthFactorsOutput, body, allocator);
}

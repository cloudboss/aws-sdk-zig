const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MFAOptionType = @import("mfa_option_type.zig").MFAOptionType;
const AttributeType = @import("attribute_type.zig").AttributeType;

pub const GetUserInput = struct {
    /// A valid access token that Amazon Cognito issued to the currently signed-in
    /// user. Must include a scope claim for
    /// `aws.cognito.signin.user.admin`.
    access_token: []const u8,

    pub const json_field_names = .{
        .access_token = "AccessToken",
    };
};

pub const GetUserOutput = struct {
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

    /// An array of name-value pairs representing user attributes.
    ///
    /// Custom attributes are prepended with the `custom:` prefix.
    user_attributes: ?[]const AttributeType = null,

    /// The MFA options that are activated for the user. The possible values in this
    /// list are
    /// `SMS_MFA`, `EMAIL_OTP`, and
    /// `SOFTWARE_TOKEN_MFA`.
    user_mfa_setting_list: ?[]const []const u8 = null,

    /// The name of the user that you requested.
    username: []const u8,

    pub const json_field_names = .{
        .mfa_options = "MFAOptions",
        .preferred_mfa_setting = "PreferredMfaSetting",
        .user_attributes = "UserAttributes",
        .user_mfa_setting_list = "UserMFASettingList",
        .username = "Username",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetUserInput, options: CallOptions) !GetUserOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetUserInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.GetUser");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetUserOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetUserOutput, body, allocator);
}

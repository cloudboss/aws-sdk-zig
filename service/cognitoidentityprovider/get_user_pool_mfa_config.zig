const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EmailMfaConfigType = @import("email_mfa_config_type.zig").EmailMfaConfigType;
const UserPoolMfaType = @import("user_pool_mfa_type.zig").UserPoolMfaType;
const SmsMfaConfigType = @import("sms_mfa_config_type.zig").SmsMfaConfigType;
const SoftwareTokenMfaConfigType = @import("software_token_mfa_config_type.zig").SoftwareTokenMfaConfigType;
const WebAuthnConfigurationType = @import("web_authn_configuration_type.zig").WebAuthnConfigurationType;

pub const GetUserPoolMfaConfigInput = struct {
    /// The ID of the user pool where you want to query WebAuthn and MFA
    /// configuration.
    user_pool_id: []const u8,

    pub const json_field_names = .{
        .user_pool_id = "UserPoolId",
    };
};

pub const GetUserPoolMfaConfigOutput = struct {
    /// Shows configuration for user pool email message MFA and sign-in with
    /// one-time
    /// passwords (OTPs). Includes the subject and body of the email message
    /// template for
    /// sign-in and MFA messages. To activate this setting, your user pool must be
    /// in the [
    /// Essentials
    /// tier](https://docs.aws.amazon.com/cognito/latest/developerguide/feature-plans-features-essentials.html) or higher.
    email_mfa_configuration: ?EmailMfaConfigType = null,

    /// Displays the state of multi-factor authentication (MFA) as on, off, or
    /// optional. When
    /// `ON`, all users must set up MFA before they can sign in. When
    /// `OPTIONAL`, your application must make a client-side determination of
    /// whether a user wants to register an MFA device. For user pools with adaptive
    /// authentication with threat protection, choose `OPTIONAL`.
    ///
    /// When `MfaConfiguration` is `OPTIONAL`, managed login
    /// doesn't automatically prompt users to set up MFA. Amazon Cognito generates
    /// MFA prompts in
    /// API responses and in managed login for users who have chosen and configured
    /// a preferred
    /// MFA factor.
    mfa_configuration: ?UserPoolMfaType = null,

    /// Shows user pool configuration for SMS message MFA. Includes the message
    /// template and
    /// the SMS message sending configuration for Amazon SNS.
    sms_mfa_configuration: ?SmsMfaConfigType = null,

    /// Shows user pool configuration for time-based one-time password (TOTP) MFA.
    /// Includes
    /// TOTP enabled or disabled state.
    software_token_mfa_configuration: ?SoftwareTokenMfaConfigType = null,

    /// Shows user pool configuration for sign-in with passkey authenticators such
    /// as
    /// biometric devices and security keys. Includes relying-party configuration,
    /// user-verification requirements, and whether passkeys can satisfy MFA
    /// requirements.
    web_authn_configuration: ?WebAuthnConfigurationType = null,

    pub const json_field_names = .{
        .email_mfa_configuration = "EmailMfaConfiguration",
        .mfa_configuration = "MfaConfiguration",
        .sms_mfa_configuration = "SmsMfaConfiguration",
        .software_token_mfa_configuration = "SoftwareTokenMfaConfiguration",
        .web_authn_configuration = "WebAuthnConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetUserPoolMfaConfigInput, options: CallOptions) !GetUserPoolMfaConfigOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetUserPoolMfaConfigInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.GetUserPoolMfaConfig");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetUserPoolMfaConfigOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetUserPoolMfaConfigOutput, body, allocator);
}

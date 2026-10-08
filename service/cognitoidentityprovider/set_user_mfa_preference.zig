const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EmailMfaSettingsType = @import("email_mfa_settings_type.zig").EmailMfaSettingsType;
const SMSMfaSettingsType = @import("sms_mfa_settings_type.zig").SMSMfaSettingsType;
const SoftwareTokenMfaSettingsType = @import("software_token_mfa_settings_type.zig").SoftwareTokenMfaSettingsType;
const WebAuthnMfaSettingsType = @import("web_authn_mfa_settings_type.zig").WebAuthnMfaSettingsType;

pub const SetUserMFAPreferenceInput = struct {
    /// A valid access token that Amazon Cognito issued to the currently signed-in
    /// user. Must include a scope claim for
    /// `aws.cognito.signin.user.admin`.
    access_token: []const u8,

    /// User preferences for email message MFA. Activates or deactivates email MFA
    /// and sets it
    /// as the preferred MFA method when multiple methods are available.
    /// To activate this setting, your user pool must be in the [
    /// Essentials
    /// tier](https://docs.aws.amazon.com/cognito/latest/developerguide/feature-plans-features-essentials.html) or higher.
    email_mfa_settings: ?EmailMfaSettingsType = null,

    /// User preferences for SMS message MFA. Activates or deactivates SMS MFA and
    /// sets it as
    /// the preferred MFA method when multiple methods are available.
    sms_mfa_settings: ?SMSMfaSettingsType = null,

    /// User preferences for time-based one-time password (TOTP) MFA. Activates or
    /// deactivates
    /// TOTP MFA and sets it as the preferred MFA method when multiple methods are
    /// available.
    /// Users must register a TOTP authenticator before they set this as their
    /// preferred MFA
    /// method.
    software_token_mfa_settings: ?SoftwareTokenMfaSettingsType = null,

    /// User preferences for passkey MFA. Activates or deactivates passkey MFA for
    /// the user.
    /// When activated, passkey authentication requires user verification, and
    /// passkey sign-in
    /// is available when MFA is required. To activate this setting, the
    /// `FactorConfiguration` of your user pool `WebAuthnConfiguration`
    /// must be `MULTI_FACTOR_WITH_USER_VERIFICATION`.
    /// To activate this setting, your user pool must be in the [
    /// Essentials
    /// tier](https://docs.aws.amazon.com/cognito/latest/developerguide/feature-plans-features-essentials.html) or higher.
    web_authn_mfa_settings: ?WebAuthnMfaSettingsType = null,

    pub const json_field_names = .{
        .access_token = "AccessToken",
        .email_mfa_settings = "EmailMfaSettings",
        .sms_mfa_settings = "SMSMfaSettings",
        .software_token_mfa_settings = "SoftwareTokenMfaSettings",
        .web_authn_mfa_settings = "WebAuthnMfaSettings",
    };
};

pub const SetUserMFAPreferenceOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SetUserMFAPreferenceInput, options: CallOptions) !SetUserMFAPreferenceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SetUserMFAPreferenceInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.SetUserMFAPreference");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SetUserMFAPreferenceOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}

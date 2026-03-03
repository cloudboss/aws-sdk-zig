const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AnalyticsMetadataType = @import("analytics_metadata_type.zig").AnalyticsMetadataType;
const ChallengeNameType = @import("challenge_name_type.zig").ChallengeNameType;
const UserContextDataType = @import("user_context_data_type.zig").UserContextDataType;
const AuthenticationResultType = @import("authentication_result_type.zig").AuthenticationResultType;

pub const RespondToAuthChallengeInput = struct {
    /// Information that supports analytics outcomes with Amazon Pinpoint, including
    /// the
    /// user's endpoint ID. The endpoint ID is a destination for Amazon Pinpoint
    /// push notifications, for example a device identifier,
    /// email address, or phone number.
    analytics_metadata: ?AnalyticsMetadataType = null,

    /// The name of the challenge that you are responding to.
    ///
    /// You can't respond to an `ADMIN_NO_SRP_AUTH` challenge with this
    /// operation.
    ///
    /// Possible challenges include the following:
    ///
    /// All of the following challenges require `USERNAME` and, when the app
    /// client has a client secret, `SECRET_HASH` in the parameters. Include a
    /// `DEVICE_KEY` for device authentication.
    ///
    /// * `WEB_AUTHN`: Respond to the challenge with the results of a
    /// successful authentication with a WebAuthn authenticator, or passkey, as
    /// `CREDENTIAL`. Examples of WebAuthn authenticators include
    /// biometric devices and security keys.
    ///
    /// * `PASSWORD`: Respond with the user's password as `PASSWORD`.
    ///
    /// * `PASSWORD_SRP`: Respond with the initial SRP secret as `SRP_A`.
    ///
    /// * `SELECT_CHALLENGE`: Respond with a challenge selection as `ANSWER`.
    /// It must be one of the challenge types in the `AvailableChallenges` response
    /// parameter. Add the parameters of the selected challenge, for example
    /// `USERNAME`
    /// and `SMS_OTP`.
    ///
    /// * `SMS_MFA`: Respond with the code that your user pool delivered in an SMS
    /// message, as `SMS_MFA_CODE`
    ///
    /// * `EMAIL_MFA`: Respond with the code that your user pool delivered in an
    ///   email
    /// message, as `EMAIL_MFA_CODE`
    ///
    /// * `EMAIL_OTP`: Respond with the code that your user pool delivered in an
    ///   email
    /// message, as `EMAIL_OTP_CODE` .
    ///
    /// * `SMS_OTP`: Respond with the code that your user pool delivered in an SMS
    /// message, as `SMS_OTP_CODE`.
    ///
    /// * `PASSWORD_VERIFIER`: Respond with the second stage of SRP secrets as
    /// `PASSWORD_CLAIM_SIGNATURE`, `PASSWORD_CLAIM_SECRET_BLOCK`,
    /// and `TIMESTAMP`.
    ///
    /// * `CUSTOM_CHALLENGE`: This is returned if your custom authentication
    /// flow determines that the user should pass another challenge before tokens
    /// are
    /// issued. The parameters of the challenge are determined by your Lambda
    /// function
    /// and issued in the `ChallengeParameters` of a challenge response.
    ///
    /// * `DEVICE_SRP_AUTH`: Respond with the initial parameters of device SRP
    /// authentication. For more information, see [Signing in with a
    /// device](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-device-tracking.html#user-pools-remembered-devices-signing-in-with-a-device).
    ///
    /// * `DEVICE_PASSWORD_VERIFIER`: Respond with
    /// `PASSWORD_CLAIM_SIGNATURE`,
    /// `PASSWORD_CLAIM_SECRET_BLOCK`, and `TIMESTAMP` after
    /// client-side SRP calculations. For more information, see [Signing in with a
    /// device](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-device-tracking.html#user-pools-remembered-devices-signing-in-with-a-device).
    ///
    /// * `NEW_PASSWORD_REQUIRED`: For users who are required to change their
    /// passwords after successful first login. Respond to this challenge with
    /// `NEW_PASSWORD` and any required attributes that Amazon Cognito returned in
    /// the `requiredAttributes` parameter. You can also set values for
    /// attributes that aren't required by your user pool and that your app client
    /// can write.
    ///
    /// Amazon Cognito only returns this challenge for users who have temporary
    /// passwords.
    /// When you create passwordless users, you must provide values for all required
    /// attributes.
    ///
    /// In a `NEW_PASSWORD_REQUIRED` challenge response, you can't modify a required
    /// attribute that already has a value.
    /// In `AdminRespondToAuthChallenge` or `RespondToAuthChallenge`, set a value
    /// for any keys that Amazon Cognito returned in the
    /// `requiredAttributes` parameter, then use the `AdminUpdateUserAttributes` or
    /// `UpdateUserAttributes` API
    /// operation to modify the value of any additional attributes.
    ///
    /// * `MFA_SETUP`: For users who are required to setup an MFA factor
    /// before they can sign in. The MFA types activated for the user pool will be
    /// listed in the challenge parameters `MFAS_CAN_SETUP` value.
    ///
    /// To set up time-based one-time password (TOTP) MFA, use the session returned
    /// in this challenge from `InitiateAuth` or `AdminInitiateAuth`
    /// as an input to `AssociateSoftwareToken`. Then, use the session returned
    /// by `VerifySoftwareToken` as an input to
    /// `RespondToAuthChallenge` or `AdminRespondToAuthChallenge`
    /// with challenge name `MFA_SETUP` to complete sign-in.
    ///
    /// To set up SMS or email MFA, collect a `phone_number` or
    /// `email` attribute for the user. Then restart the authentication
    /// flow with an `InitiateAuth` or `AdminInitiateAuth` request.
    challenge_name: ChallengeNameType,

    /// The responses to the challenge that you received in the previous request.
    /// Each
    /// challenge has its own required response parameters. The following examples
    /// are partial
    /// JSON request bodies that highlight challenge-response parameters.
    ///
    /// You must provide a SECRET_HASH parameter in all challenge responses to an
    /// app
    /// client that has a client secret. Include a `DEVICE_KEY` for device
    /// authentication.
    ///
    /// **SELECT_CHALLENGE**
    ///
    /// `"ChallengeName": "SELECT_CHALLENGE", "ChallengeResponses": {
    /// "USERNAME": "[username]",
    /// "ANSWER": "[Challenge name]"}`
    ///
    /// Available challenges are `PASSWORD`, `PASSWORD_SRP`,
    /// `EMAIL_OTP`, `SMS_OTP`, and `WEB_AUTHN`.
    ///
    /// Complete authentication in the `SELECT_CHALLENGE` response for
    /// `PASSWORD`, `PASSWORD_SRP`, and `WEB_AUTHN`:
    ///
    /// * `"ChallengeName": "SELECT_CHALLENGE", "ChallengeResponses": {
    /// "ANSWER": "WEB_AUTHN",
    /// "USERNAME": "[username]",
    /// "CREDENTIAL": "[AuthenticationResponseJSON]"}`
    ///
    /// See [
    /// AuthenticationResponseJSON](https://www.w3.org/TR/WebAuthn-3/#dictdef-authenticationresponsejson).
    ///
    /// * `"ChallengeName": "SELECT_CHALLENGE", "ChallengeResponses": {
    /// "ANSWER": "PASSWORD",
    /// "USERNAME": "[username]",
    /// "PASSWORD": "[password]"}`
    ///
    /// * `"ChallengeName": "SELECT_CHALLENGE", "ChallengeResponses": {
    /// "ANSWER": "PASSWORD_SRP",
    /// "USERNAME": "[username]",
    /// "SRP_A": "[SRP_A]"}`
    ///
    /// For `SMS_OTP` and `EMAIL_OTP`, respond with the
    /// username and answer. Your user pool will send a code for the user to submit
    /// in
    /// the next challenge response.
    ///
    /// * `"ChallengeName": "SELECT_CHALLENGE", "ChallengeResponses": {
    /// "ANSWER": "SMS_OTP",
    /// "USERNAME": "[username]"}`
    ///
    /// * `"ChallengeName": "SELECT_CHALLENGE", "ChallengeResponses": {
    /// "ANSWER": "EMAIL_OTP",
    /// "USERNAME": "[username]"}`
    ///
    /// **WEB_AUTHN**
    ///
    /// `"ChallengeName": "WEB_AUTHN", "ChallengeResponses": {
    /// "USERNAME": "[username]",
    /// "CREDENTIAL": "[AuthenticationResponseJSON]"}`
    ///
    /// See [
    /// AuthenticationResponseJSON](https://www.w3.org/TR/WebAuthn-3/#dictdef-authenticationresponsejson).
    ///
    /// **PASSWORD**
    ///
    /// `"ChallengeName": "PASSWORD", "ChallengeResponses": {
    /// "USERNAME": "[username]",
    /// "PASSWORD": "[password]"}`
    ///
    /// **PASSWORD_SRP**
    ///
    /// `"ChallengeName": "PASSWORD_SRP", "ChallengeResponses": {
    /// "USERNAME": "[username]",
    /// "SRP_A": "[SRP_A]"}`
    ///
    /// **SMS_OTP**
    ///
    /// `"ChallengeName": "SMS_OTP", "ChallengeResponses":
    /// {"SMS_OTP_CODE": "[code]", "USERNAME": "[username]"}`
    ///
    /// **EMAIL_OTP**
    ///
    /// `"ChallengeName": "EMAIL_OTP", "ChallengeResponses": {"EMAIL_OTP_CODE":
    /// "[code]", "USERNAME": "[username]"}`
    ///
    /// **SMS_MFA**
    ///
    /// `"ChallengeName": "SMS_MFA", "ChallengeResponses": {"SMS_MFA_CODE":
    /// "[code]", "USERNAME": "[username]"}`
    ///
    /// **PASSWORD_VERIFIER**
    ///
    /// This challenge response is part of the SRP flow. Amazon Cognito requires
    /// that your application respond to this challenge within a few seconds. When
    /// the response time exceeds this period, your user pool returns a
    /// `NotAuthorizedException` error.
    ///
    /// `"ChallengeName": "PASSWORD_VERIFIER", "ChallengeResponses":
    /// {"PASSWORD_CLAIM_SIGNATURE": "[claim_signature]",
    /// "PASSWORD_CLAIM_SECRET_BLOCK": "[secret_block]", "TIMESTAMP":
    /// [timestamp], "USERNAME": "[username]"}`
    ///
    /// **CUSTOM_CHALLENGE**
    ///
    /// `"ChallengeName": "CUSTOM_CHALLENGE", "ChallengeResponses":
    /// {"USERNAME": "[username]", "ANSWER": "[challenge_answer]"}`
    ///
    /// **NEW_PASSWORD_REQUIRED**
    ///
    /// `"ChallengeName": "NEW_PASSWORD_REQUIRED", "ChallengeResponses":
    /// {"NEW_PASSWORD": "[new_password]", "USERNAME":
    /// "[username]"}`
    ///
    /// To set any required attributes that `InitiateAuth` returned in
    /// an `requiredAttributes` parameter, add
    /// `"userAttributes.[attribute_name]": "[attribute_value]"`.
    /// This parameter can also set values for writable attributes that aren't
    /// required by your user pool.
    ///
    /// In a `NEW_PASSWORD_REQUIRED` challenge response, you can't modify a required
    /// attribute that already has a value.
    /// In `AdminRespondToAuthChallenge` or `RespondToAuthChallenge`, set a value
    /// for any keys that Amazon Cognito returned in the
    /// `requiredAttributes` parameter, then use the `AdminUpdateUserAttributes` or
    /// `UpdateUserAttributes` API
    /// operation to modify the value of any additional attributes.
    ///
    /// **SOFTWARE_TOKEN_MFA**
    ///
    /// `"ChallengeName": "SOFTWARE_TOKEN_MFA", "ChallengeResponses":
    /// {"USERNAME": "[username]", "SOFTWARE_TOKEN_MFA_CODE":
    /// [authenticator_code]}`
    ///
    /// **DEVICE_SRP_AUTH**
    ///
    /// `"ChallengeName": "DEVICE_SRP_AUTH", "ChallengeResponses": {"USERNAME":
    /// "[username]", "DEVICE_KEY": "[device_key]", "SRP_A":
    /// "[srp_a]"}`
    ///
    /// **DEVICE_PASSWORD_VERIFIER**
    ///
    /// `"ChallengeName": "DEVICE_PASSWORD_VERIFIER", "ChallengeResponses":
    /// {"DEVICE_KEY": "[device_key]", "PASSWORD_CLAIM_SIGNATURE":
    /// "[claim_signature]", "PASSWORD_CLAIM_SECRET_BLOCK": "[secret_block]",
    /// "TIMESTAMP": [timestamp], "USERNAME": "[username]"}`
    ///
    /// **MFA_SETUP**
    ///
    /// `"ChallengeName": "MFA_SETUP", "ChallengeResponses": {"USERNAME":
    /// "[username]"}, "SESSION": "[Session ID from
    /// VerifySoftwareToken]"`
    ///
    /// **SELECT_MFA_TYPE**
    ///
    /// `"ChallengeName": "SELECT_MFA_TYPE", "ChallengeResponses": {"USERNAME":
    /// "[username]", "ANSWER": "[SMS_MFA|EMAIL_MFA|SOFTWARE_TOKEN_MFA]"}`
    ///
    /// For more information about `SECRET_HASH`, see [Computing secret hash
    /// values](https://docs.aws.amazon.com/cognito/latest/developerguide/signing-up-users-in-your-app.html#cognito-user-pools-computing-secret-hash). For information about
    /// `DEVICE_KEY`, see [Working with user devices in your user
    /// pool](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-device-tracking.html).
    challenge_responses: ?[]const aws.map.StringMapEntry = null,

    /// The ID of the app client where the user is signing in.
    client_id: []const u8,

    /// A map of custom key-value pairs that you can provide as input for any custom
    /// workflows
    /// that this action triggers.
    ///
    /// You create custom workflows by assigning Lambda functions to user pool
    /// triggers. When you use the RespondToAuthChallenge API action, Amazon Cognito
    /// invokes any
    /// functions that are assigned to the following triggers: *post
    /// authentication*, *pre token generation*,
    /// *define auth challenge*, *create auth
    /// challenge*, and *verify auth challenge*. When Amazon Cognito
    /// invokes any of these functions, it passes a JSON payload, which the function
    /// receives as
    /// input. This payload contains a `clientMetadata` attribute, which provides
    /// the
    /// data that you assigned to the ClientMetadata parameter in your
    /// RespondToAuthChallenge
    /// request. In your function code in Lambda, you can process the
    /// `clientMetadata` value to enhance your workflow for your specific
    /// needs.
    ///
    /// For more information, see [
    /// Using Lambda
    /// triggers](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools-working-with-aws-lambda-triggers.html) in the *Amazon Cognito Developer Guide*.
    ///
    /// When you use the `ClientMetadata` parameter, note that Amazon Cognito won't
    /// do the
    /// following:
    ///
    /// * Store the `ClientMetadata` value. This data is available only
    /// to Lambda triggers that are assigned to a user pool to support custom
    /// workflows. If your user pool configuration doesn't include triggers, the
    /// `ClientMetadata` parameter serves no purpose.
    ///
    /// * Validate the `ClientMetadata` value.
    ///
    /// * Encrypt the `ClientMetadata` value. Don't send sensitive
    /// information in this parameter.
    client_metadata: ?[]const aws.map.StringMapEntry = null,

    /// The session identifier that maintains the state of authentication requests
    /// and
    /// challenge responses. If an `AdminInitiateAuth` or
    /// `AdminRespondToAuthChallenge` API request results in a determination that
    /// your application must pass another challenge, Amazon Cognito returns a
    /// session with other
    /// challenge parameters. Send this session identifier, unmodified, to the next
    /// `AdminRespondToAuthChallenge` request.
    session: ?[]const u8 = null,

    /// Contextual data about your user session like the device fingerprint, IP
    /// address, or location. Amazon Cognito threat
    /// protection evaluates the risk of an authentication event based on the
    /// context that your app generates and passes to Amazon Cognito
    /// when it makes API requests.
    ///
    /// For more information, see [Collecting data for threat protection in
    /// applications](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-viewing-threat-protection-app.html).
    user_context_data: ?UserContextDataType = null,

    pub const json_field_names = .{
        .analytics_metadata = "AnalyticsMetadata",
        .challenge_name = "ChallengeName",
        .challenge_responses = "ChallengeResponses",
        .client_id = "ClientId",
        .client_metadata = "ClientMetadata",
        .session = "Session",
        .user_context_data = "UserContextData",
    };
};

pub const RespondToAuthChallengeOutput = struct {
    /// The outcome of a successful authentication process. After your application
    /// has passed
    /// all challenges, Amazon Cognito returns an `AuthenticationResult` with the
    /// JSON web
    /// tokens (JWTs) that indicate successful sign-in.
    authentication_result: ?AuthenticationResultType = null,

    /// The name of the next challenge that you must respond to.
    ///
    /// Possible challenges include the following:
    ///
    /// All of the following challenges require `USERNAME` and, when the app
    /// client has a client secret, `SECRET_HASH` in the parameters. Include a
    /// `DEVICE_KEY` for device authentication.
    ///
    /// * `WEB_AUTHN`: Respond to the challenge with the results of a
    /// successful authentication with a WebAuthn authenticator, or passkey, as
    /// `CREDENTIAL`. Examples of WebAuthn authenticators include
    /// biometric devices and security keys.
    ///
    /// * `PASSWORD`: Respond with the user's password as `PASSWORD`.
    ///
    /// * `PASSWORD_SRP`: Respond with the initial SRP secret as `SRP_A`.
    ///
    /// * `SELECT_CHALLENGE`: Respond with a challenge selection as `ANSWER`.
    /// It must be one of the challenge types in the `AvailableChallenges` response
    /// parameter. Add the parameters of the selected challenge, for example
    /// `USERNAME`
    /// and `SMS_OTP`.
    ///
    /// * `SMS_MFA`: Respond with the code that your user pool delivered in an SMS
    /// message, as `SMS_MFA_CODE`
    ///
    /// * `EMAIL_MFA`: Respond with the code that your user pool delivered in an
    ///   email
    /// message, as `EMAIL_MFA_CODE`
    ///
    /// * `EMAIL_OTP`: Respond with the code that your user pool delivered in an
    ///   email
    /// message, as `EMAIL_OTP_CODE` .
    ///
    /// * `SMS_OTP`: Respond with the code that your user pool delivered in an SMS
    /// message, as `SMS_OTP_CODE`.
    ///
    /// * `PASSWORD_VERIFIER`: Respond with the second stage of SRP secrets as
    /// `PASSWORD_CLAIM_SIGNATURE`, `PASSWORD_CLAIM_SECRET_BLOCK`,
    /// and `TIMESTAMP`.
    ///
    /// * `CUSTOM_CHALLENGE`: This is returned if your custom authentication
    /// flow determines that the user should pass another challenge before tokens
    /// are
    /// issued. The parameters of the challenge are determined by your Lambda
    /// function
    /// and issued in the `ChallengeParameters` of a challenge response.
    ///
    /// * `DEVICE_SRP_AUTH`: Respond with the initial parameters of device SRP
    /// authentication. For more information, see [Signing in with a
    /// device](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-device-tracking.html#user-pools-remembered-devices-signing-in-with-a-device).
    ///
    /// * `DEVICE_PASSWORD_VERIFIER`: Respond with
    /// `PASSWORD_CLAIM_SIGNATURE`,
    /// `PASSWORD_CLAIM_SECRET_BLOCK`, and `TIMESTAMP` after
    /// client-side SRP calculations. For more information, see [Signing in with a
    /// device](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-device-tracking.html#user-pools-remembered-devices-signing-in-with-a-device).
    ///
    /// * `NEW_PASSWORD_REQUIRED`: For users who are required to change their
    /// passwords after successful first login. Respond to this challenge with
    /// `NEW_PASSWORD` and any required attributes that Amazon Cognito returned in
    /// the `requiredAttributes` parameter. You can also set values for
    /// attributes that aren't required by your user pool and that your app client
    /// can write.
    ///
    /// Amazon Cognito only returns this challenge for users who have temporary
    /// passwords.
    /// When you create passwordless users, you must provide values for all required
    /// attributes.
    ///
    /// In a `NEW_PASSWORD_REQUIRED` challenge response, you can't modify a required
    /// attribute that already has a value.
    /// In `AdminRespondToAuthChallenge` or `RespondToAuthChallenge`, set a value
    /// for any keys that Amazon Cognito returned in the
    /// `requiredAttributes` parameter, then use the `AdminUpdateUserAttributes` or
    /// `UpdateUserAttributes` API
    /// operation to modify the value of any additional attributes.
    ///
    /// * `MFA_SETUP`: For users who are required to setup an MFA factor
    /// before they can sign in. The MFA types activated for the user pool will be
    /// listed in the challenge parameters `MFAS_CAN_SETUP` value.
    ///
    /// To set up time-based one-time password (TOTP) MFA, use the session returned
    /// in this challenge from `InitiateAuth` or `AdminInitiateAuth`
    /// as an input to `AssociateSoftwareToken`. Then, use the session returned
    /// by `VerifySoftwareToken` as an input to
    /// `RespondToAuthChallenge` or `AdminRespondToAuthChallenge`
    /// with challenge name `MFA_SETUP` to complete sign-in.
    ///
    /// To set up SMS or email MFA, collect a `phone_number` or
    /// `email` attribute for the user. Then restart the authentication
    /// flow with an `InitiateAuth` or `AdminInitiateAuth` request.
    challenge_name: ?ChallengeNameType = null,

    /// The parameters that define your response to the next challenge.
    challenge_parameters: ?[]const aws.map.StringMapEntry = null,

    /// The session identifier that maintains the state of authentication requests
    /// and
    /// challenge responses. If an `InitiateAuth` or
    /// `RespondToAuthChallenge` API request results in a determination that your
    /// application must pass another challenge, Amazon Cognito returns a session
    /// with other challenge
    /// parameters. Send this session identifier, unmodified, to the next
    /// `RespondToAuthChallenge` request.
    session: ?[]const u8 = null,

    pub const json_field_names = .{
        .authentication_result = "AuthenticationResult",
        .challenge_name = "ChallengeName",
        .challenge_parameters = "ChallengeParameters",
        .session = "Session",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RespondToAuthChallengeInput, options: Options) !RespondToAuthChallengeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "cognitoidentityprovider");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: RespondToAuthChallengeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cognitoidentityprovider", "Cognito Identity Provider", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.RespondToAuthChallenge");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RespondToAuthChallengeOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(RespondToAuthChallengeOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AliasExistsException")) {
        return .{ .arena = arena, .kind = .{ .alias_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CodeDeliveryFailureException")) {
        return .{ .arena = arena, .kind = .{ .code_delivery_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CodeMismatchException")) {
        return .{ .arena = arena, .kind = .{ .code_mismatch_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DeviceKeyExistsException")) {
        return .{ .arena = arena, .kind = .{ .device_key_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateProviderException")) {
        return .{ .arena = arena, .kind = .{ .duplicate_provider_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EnableSoftwareTokenMFAException")) {
        return .{ .arena = arena, .kind = .{ .enable_software_token_mfa_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ExpiredCodeException")) {
        return .{ .arena = arena, .kind = .{ .expired_code_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FeatureUnavailableInTierException")) {
        return .{ .arena = arena, .kind = .{ .feature_unavailable_in_tier_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ForbiddenException")) {
        return .{ .arena = arena, .kind = .{ .forbidden_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "GroupExistsException")) {
        return .{ .arena = arena, .kind = .{ .group_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidEmailRoleAccessPolicyException")) {
        return .{ .arena = arena, .kind = .{ .invalid_email_role_access_policy_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidLambdaResponseException")) {
        return .{ .arena = arena, .kind = .{ .invalid_lambda_response_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidOAuthFlowException")) {
        return .{ .arena = arena, .kind = .{ .invalid_o_auth_flow_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPasswordException")) {
        return .{ .arena = arena, .kind = .{ .invalid_password_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSmsRoleAccessPolicyException")) {
        return .{ .arena = arena, .kind = .{ .invalid_sms_role_access_policy_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSmsRoleTrustRelationshipException")) {
        return .{ .arena = arena, .kind = .{ .invalid_sms_role_trust_relationship_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidUserPoolConfigurationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_user_pool_configuration_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ManagedLoginBrandingExistsException")) {
        return .{ .arena = arena, .kind = .{ .managed_login_branding_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MFAMethodNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .mfa_method_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotAuthorizedException")) {
        return .{ .arena = arena, .kind = .{ .not_authorized_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PasswordHistoryPolicyViolationException")) {
        return .{ .arena = arena, .kind = .{ .password_history_policy_violation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PasswordResetRequiredException")) {
        return .{ .arena = arena, .kind = .{ .password_reset_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PreconditionNotMetException")) {
        return .{ .arena = arena, .kind = .{ .precondition_not_met_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RefreshTokenReuseException")) {
        return .{ .arena = arena, .kind = .{ .refresh_token_reuse_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ScopeDoesNotExistException")) {
        return .{ .arena = arena, .kind = .{ .scope_does_not_exist_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SoftwareTokenMFANotFoundException")) {
        return .{ .arena = arena, .kind = .{ .software_token_mfa_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TermsExistsException")) {
        return .{ .arena = arena, .kind = .{ .terms_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TierChangeNotAllowedException")) {
        return .{ .arena = arena, .kind = .{ .tier_change_not_allowed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyFailedAttemptsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_failed_attempts_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthorizedException")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnexpectedLambdaException")) {
        return .{ .arena = arena, .kind = .{ .unexpected_lambda_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedIdentityProviderException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_identity_provider_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedOperationException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_operation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedTokenTypeException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_token_type_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedUserStateException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_user_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UserImportInProgressException")) {
        return .{ .arena = arena, .kind = .{ .user_import_in_progress_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UserLambdaValidationException")) {
        return .{ .arena = arena, .kind = .{ .user_lambda_validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UserNotConfirmedException")) {
        return .{ .arena = arena, .kind = .{ .user_not_confirmed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UserNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .user_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UserPoolAddOnNotEnabledException")) {
        return .{ .arena = arena, .kind = .{ .user_pool_add_on_not_enabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UserPoolTaggingException")) {
        return .{ .arena = arena, .kind = .{ .user_pool_tagging_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UsernameExistsException")) {
        return .{ .arena = arena, .kind = .{ .username_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WebAuthnChallengeNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .web_authn_challenge_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WebAuthnClientMismatchException")) {
        return .{ .arena = arena, .kind = .{ .web_authn_client_mismatch_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WebAuthnConfigurationMissingException")) {
        return .{ .arena = arena, .kind = .{ .web_authn_configuration_missing_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WebAuthnCredentialNotSupportedException")) {
        return .{ .arena = arena, .kind = .{ .web_authn_credential_not_supported_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WebAuthnNotEnabledException")) {
        return .{ .arena = arena, .kind = .{ .web_authn_not_enabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WebAuthnOriginNotAllowedException")) {
        return .{ .arena = arena, .kind = .{ .web_authn_origin_not_allowed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WebAuthnRelyingPartyMismatchException")) {
        return .{ .arena = arena, .kind = .{ .web_authn_relying_party_mismatch_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}

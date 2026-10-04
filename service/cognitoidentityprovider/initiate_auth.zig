const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AnalyticsMetadataType = @import("analytics_metadata_type.zig").AnalyticsMetadataType;
const AuthFlowType = @import("auth_flow_type.zig").AuthFlowType;
const UserContextDataType = @import("user_context_data_type.zig").UserContextDataType;
const AuthenticationResultType = @import("authentication_result_type.zig").AuthenticationResultType;
const ChallengeNameType = @import("challenge_name_type.zig").ChallengeNameType;

pub const InitiateAuthInput = struct {
    /// Information that supports analytics outcomes with Amazon Pinpoint, including
    /// the
    /// user's endpoint ID. The endpoint ID is a destination for Amazon Pinpoint
    /// push notifications, for example a device identifier,
    /// email address, or phone number.
    analytics_metadata: ?AnalyticsMetadataType = null,

    /// The authentication flow that you want to initiate. Each `AuthFlow` has
    /// linked `AuthParameters` that you must submit. The following are some example
    /// flows.
    ///
    /// **USER_AUTH**
    ///
    /// The entry point for [choice-based
    /// authentication](https://docs.aws.amazon.com/cognito/latest/developerguide/authentication-flows-selection-sdk.html#authentication-flows-selection-choice) with passwords,
    /// one-time passwords, and WebAuthn authenticators. Request a preferred
    /// authentication type or review available authentication types. From the
    /// offered authentication types, select one in a challenge response and then
    /// authenticate with that method in an additional challenge response.
    /// To activate this setting, your user pool must be in the [
    /// Essentials
    /// tier](https://docs.aws.amazon.com/cognito/latest/developerguide/feature-plans-features-essentials.html) or higher.
    ///
    /// **USER_SRP_AUTH**
    ///
    /// Username-password authentication with the Secure Remote Password (SRP)
    /// protocol. For more information, see [Use SRP password verification in custom
    /// authentication
    /// flow](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-authentication-flow.html#Using-SRP-password-verification-in-custom-authentication-flow).
    ///
    /// **REFRESH_TOKEN_AUTH and REFRESH_TOKEN**
    ///
    /// Receive new ID and access tokens when you pass a
    /// `REFRESH_TOKEN` parameter with a valid refresh token as the
    /// value. For more information, see [Using the refresh
    /// token](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-using-the-refresh-token.html).
    ///
    /// **CUSTOM_AUTH**
    ///
    /// Custom authentication with Lambda triggers. For more information, see
    /// [Custom authentication challenge Lambda
    /// triggers](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-challenge.html).
    ///
    /// **USER_PASSWORD_AUTH**
    ///
    /// Client-side username-password authentication with the password sent
    /// directly in the request. For more information about client-side and
    /// server-side authentication, see [SDK authorization
    /// models](https://docs.aws.amazon.com/cognito/latest/developerguide/authentication-flows-public-server-side.html).
    ///
    /// `ADMIN_USER_PASSWORD_AUTH` is a flow type of `AdminInitiateAuth`
    /// and isn't valid for InitiateAuth. `ADMIN_NO_SRP_AUTH` is a legacy
    /// server-side
    /// username-password flow and isn't valid for InitiateAuth.
    auth_flow: AuthFlowType,

    /// The authentication parameters. These are inputs corresponding to the
    /// `AuthFlow` that you're invoking.
    ///
    /// The following are some authentication flows and their parameters. Add a
    /// `SECRET_HASH` parameter if your app client has a client secret. Add
    /// `DEVICE_KEY` if you want to bypass multi-factor authentication with a
    /// remembered device.
    ///
    /// **USER_AUTH**
    ///
    /// * `USERNAME` (required)
    ///
    /// * `PREFERRED_CHALLENGE`. If you don't provide a
    /// value for `PREFERRED_CHALLENGE`, Amazon Cognito responds with the
    /// `AvailableChallenges` parameter that specifies the
    /// available sign-in methods.
    ///
    /// **USER_SRP_AUTH**
    ///
    /// * `USERNAME` (required)
    ///
    /// * `SRP_A` (required)
    ///
    /// **USER_PASSWORD_AUTH**
    ///
    /// * `USERNAME` (required)
    ///
    /// * `PASSWORD` (required)
    ///
    /// **REFRESH_TOKEN_AUTH/REFRESH_TOKEN**
    ///
    /// * `REFRESH_TOKEN`(required)
    ///
    /// **CUSTOM_AUTH**
    ///
    /// * `USERNAME` (required)
    ///
    /// * `ChallengeName: SRP_A` (when doing SRP authentication
    /// before custom challenges)
    ///
    /// * `SRP_A: (An SRP_A value)` (when doing SRP
    /// authentication before custom challenges)
    ///
    /// For more information about `SECRET_HASH`, see [Computing secret hash
    /// values](https://docs.aws.amazon.com/cognito/latest/developerguide/signing-up-users-in-your-app.html#cognito-user-pools-computing-secret-hash). For information about
    /// `DEVICE_KEY`, see [Working with user devices in your user
    /// pool](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-device-tracking.html).
    auth_parameters: ?[]const aws.map.StringMapEntry = null,

    /// The ID of the app client that your user wants to sign in to.
    client_id: []const u8,

    /// A map of custom key-value pairs that you can provide as input for any custom
    /// workflows
    /// that this action triggers. You create custom workflows by assigning Lambda
    /// functions
    /// to user pool triggers.
    ///
    /// When Amazon Cognito invokes any of these functions, it passes a JSON
    /// payload, which the
    /// function receives as input. This payload contains a `clientMetadata`
    /// attribute that provides the data that you assigned to the ClientMetadata
    /// parameter in
    /// your request. In your function code, you can process the `clientMetadata`
    /// value to enhance your workflow for your specific needs.
    ///
    /// To review the Lambda trigger types that Amazon Cognito invokes at runtime
    /// with API requests, see [
    /// Connecting API actions to Lambda
    /// triggers](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-working-with-lambda-triggers.html#lambda-triggers-by-event) in the *Amazon Cognito Developer Guide*.
    ///
    /// The `ClientMetadata` value is passed as input to the functions for only the
    /// following triggers:
    ///
    /// * Pre signup
    ///
    /// * Pre authentication
    ///
    /// * User migration
    ///
    /// This request also invokes the functions for the following triggers, but
    /// doesn't pass
    /// `ClientMetadata`:
    ///
    /// * Post authentication
    ///
    /// * Custom message
    ///
    /// * Pre token generation
    ///
    /// * Create auth challenge
    ///
    /// * Define auth challenge
    ///
    /// * Custom email sender
    ///
    /// * Custom SMS sender
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

    /// The optional session ID from a `ConfirmSignUp` API request. You can sign in
    /// a user directly from the sign-up process with the `USER_AUTH` authentication
    /// flow. When you pass the session ID to `InitiateAuth`, Amazon Cognito assumes
    /// the SMS
    /// or email message one-time verification password from `ConfirmSignUp` as the
    /// primary authentication factor. You're not required to submit this code a
    /// second
    /// time. This option is only valid for users who have confirmed their sign-up
    /// and are
    /// signing in for the first time within the authentication flow session
    /// duration of the
    /// session ID.
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
        .auth_flow = "AuthFlow",
        .auth_parameters = "AuthParameters",
        .client_id = "ClientId",
        .client_metadata = "ClientMetadata",
        .session = "Session",
        .user_context_data = "UserContextData",
    };
};

pub const InitiateAuthOutput = struct {
    /// The result of a successful and complete authentication request. This result
    /// is only
    /// returned if the user doesn't need to pass another challenge. If they must
    /// pass another
    /// challenge before they get tokens, Amazon Cognito returns a challenge in
    /// `ChallengeName`, `ChallengeParameters`, and
    /// `Session` response parameters.
    authentication_result: ?AuthenticationResultType = null,

    /// This response parameter lists the available authentication challenges that
    /// users can
    /// select from in [choice-based
    /// authentication](https://docs.aws.amazon.com/cognito/latest/developerguide/authentication-flows-selection-sdk.html#authentication-flows-selection-choice). For example, they might be
    /// able to choose between passkey authentication, a one-time password from an
    /// SMS message,
    /// and a traditional password.
    available_challenges: ?[]const ChallengeNameType = null,

    /// The name of an additional authentication challenge that you must respond to.
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

    /// The required parameters of the `ChallengeName` challenge.
    ///
    /// All challenges require `USERNAME`. They also require
    /// `SECRET_HASH` if your app client has a client secret.
    challenge_parameters: ?[]const aws.map.StringMapEntry = null,

    /// The session identifier that links a challenge response to the initial
    /// authentication
    /// request. If the user must pass another challenge, Amazon Cognito returns a
    /// session ID and
    /// challenge parameters.
    session: ?[]const u8 = null,

    pub const json_field_names = .{
        .authentication_result = "AuthenticationResult",
        .available_challenges = "AvailableChallenges",
        .challenge_name = "ChallengeName",
        .challenge_parameters = "ChallengeParameters",
        .session = "Session",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: InitiateAuthInput, options: CallOptions) !InitiateAuthOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: InitiateAuthInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.InitiateAuth");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !InitiateAuthOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(InitiateAuthOutput, body, allocator);
}

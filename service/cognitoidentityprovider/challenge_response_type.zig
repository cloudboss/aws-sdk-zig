const ChallengeName = @import("challenge_name.zig").ChallengeName;
const ChallengeResponse = @import("challenge_response.zig").ChallengeResponse;

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
pub const ChallengeResponseType = struct {
    /// The type of challenge that your previous authentication request returned in
    /// the
    /// parameter `ChallengeName`, for example `SMS_MFA`.
    challenge_name: ?ChallengeName,

    /// The set of key-value pairs that provides a response to the requested
    /// challenge.
    challenge_response: ?ChallengeResponse,

    pub const json_field_names = .{
        .challenge_name = "ChallengeName",
        .challenge_response = "ChallengeResponse",
    };
};

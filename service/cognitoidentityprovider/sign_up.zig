const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AnalyticsMetadataType = @import("analytics_metadata_type.zig").AnalyticsMetadataType;
const AttributeType = @import("attribute_type.zig").AttributeType;
const UserContextDataType = @import("user_context_data_type.zig").UserContextDataType;
const CodeDeliveryDetailsType = @import("code_delivery_details_type.zig").CodeDeliveryDetailsType;

pub const SignUpInput = struct {
    /// Information that supports analytics outcomes with Amazon Pinpoint, including
    /// the
    /// user's endpoint ID. The endpoint ID is a destination for Amazon Pinpoint
    /// push notifications, for example a device identifier,
    /// email address, or phone number.
    analytics_metadata: ?AnalyticsMetadataType = null,

    /// The ID of the app client where the user wants to sign up.
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

    /// The user's proposed password. The password must comply with the [password
    /// requirements](https://docs.aws.amazon.com/cognito/latest/developerguide/managing-users-passwords.html) of your user pool.
    ///
    /// Users can sign up without a password when your user pool supports
    /// passwordless sign-in
    /// with email or SMS OTPs. To create a user with no password, omit this
    /// parameter or submit
    /// a blank value. You can only create a passwordless user when passwordless
    /// sign-in is
    /// available.
    password: ?[]const u8 = null,

    /// A keyed-hash message authentication code (HMAC) calculated using the secret
    /// key of a
    /// user pool client and username plus the client ID in the message. For more
    /// information
    /// about `SecretHash`, see [Computing secret hash
    /// values](https://docs.aws.amazon.com/cognito/latest/developerguide/signing-up-users-in-your-app.html#cognito-user-pools-computing-secret-hash).
    secret_hash: ?[]const u8 = null,

    /// An array of name-value pairs representing user attributes.
    ///
    /// For custom attributes, include a `custom:` prefix in the attribute name,
    /// for example `custom:department`.
    user_attributes: ?[]const AttributeType = null,

    /// Contextual data about your user session like the device fingerprint, IP
    /// address, or location. Amazon Cognito threat
    /// protection evaluates the risk of an authentication event based on the
    /// context that your app generates and passes to Amazon Cognito
    /// when it makes API requests.
    ///
    /// For more information, see [Collecting data for threat protection in
    /// applications](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-viewing-threat-protection-app.html).
    user_context_data: ?UserContextDataType = null,

    /// The username of the user that you want to sign up. The value of this
    /// parameter is
    /// typically a username, but can be any alias attribute in your user pool.
    username: []const u8,

    /// Temporary user attributes that contribute to the outcomes of your pre
    /// sign-up Lambda
    /// trigger. This set of key-value pairs are for custom validation of
    /// information that you
    /// collect from your users but don't need to retain.
    ///
    /// Your Lambda function can analyze this additional data and act on it. Your
    /// function
    /// can automatically confirm and verify select users or perform external API
    /// operations
    /// like logging user attributes and validation data to Amazon CloudWatch Logs.
    ///
    /// For more information about the pre sign-up Lambda trigger, see [Pre sign-up
    /// Lambda
    /// trigger](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-pre-sign-up.html).
    validation_data: ?[]const AttributeType = null,

    pub const json_field_names = .{
        .analytics_metadata = "AnalyticsMetadata",
        .client_id = "ClientId",
        .client_metadata = "ClientMetadata",
        .password = "Password",
        .secret_hash = "SecretHash",
        .user_attributes = "UserAttributes",
        .user_context_data = "UserContextData",
        .username = "Username",
        .validation_data = "ValidationData",
    };
};

pub const SignUpOutput = struct {
    /// In user pools that automatically verify and confirm new users, Amazon
    /// Cognito sends users a
    /// message with a code or link that confirms ownership of the phone number or
    /// email address
    /// that they entered. The `CodeDeliveryDetails` object is information about the
    /// delivery destination for that link or code.
    code_delivery_details: ?CodeDeliveryDetailsType = null,

    /// A session Id that you can pass to `ConfirmSignUp` when you want to
    /// immediately sign in your user with the `USER_AUTH` flow after they complete
    /// sign-up.
    session: ?[]const u8 = null,

    /// Indicates whether the user was automatically confirmed. You can auto-confirm
    /// users
    /// with a [pre sign-up Lambda
    /// trigger](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-pre-sign-up.html).
    user_confirmed: ?bool = null,

    /// The unique identifier of the new user, for example
    /// `a1b2c3d4-5678-90ab-cdef-EXAMPLE11111`.
    user_sub: []const u8,

    pub const json_field_names = .{
        .code_delivery_details = "CodeDeliveryDetails",
        .session = "Session",
        .user_confirmed = "UserConfirmed",
        .user_sub = "UserSub",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SignUpInput, options: CallOptions) !SignUpOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SignUpInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.SignUp");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SignUpOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(SignUpOutput, body, allocator);
}

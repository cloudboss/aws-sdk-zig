const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AnalyticsMetadataType = @import("analytics_metadata_type.zig").AnalyticsMetadataType;
const UserContextDataType = @import("user_context_data_type.zig").UserContextDataType;

pub const ConfirmSignUpInput = struct {
    /// Information that supports analytics outcomes with Amazon Pinpoint, including
    /// the
    /// user's endpoint ID. The endpoint ID is a destination for Amazon Pinpoint
    /// push notifications, for example a device identifier,
    /// email address, or phone number.
    analytics_metadata: ?AnalyticsMetadataType = null,

    /// The ID of the app client associated with the user pool.
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

    /// The confirmation code that your user pool sent in response to the `SignUp`
    /// request.
    confirmation_code: []const u8,

    /// When `true`, forces user confirmation despite any existing aliases.
    /// Defaults to `false`. A value of `true` migrates the alias from an
    /// existing user to the new user if an existing user already has the phone
    /// number or email
    /// address as an alias.
    ///
    /// Say, for example, that an existing user has an `email` attribute of
    /// `bob@example.com` and email is an alias in your user pool. If the new
    /// user also has an email of `bob@example.com` and your
    /// `ConfirmSignUp` response sets `ForceAliasCreation` to
    /// `true`, the new user can sign in with a username of
    /// `bob@example.com` and the existing user can no longer do so.
    ///
    /// If `false` and an attribute belongs to an existing alias, this request
    /// returns an **AliasExistsException** error.
    ///
    /// For more information about sign-in aliases, see [Customizing sign-in
    /// attributes](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-attributes.html#user-pool-settings-aliases).
    force_alias_creation: ?bool = null,

    /// A keyed-hash message authentication code (HMAC) calculated using the secret
    /// key of a
    /// user pool client and username plus the client ID in the message. For more
    /// information
    /// about `SecretHash`, see [Computing secret hash
    /// values](https://docs.aws.amazon.com/cognito/latest/developerguide/signing-up-users-in-your-app.html#cognito-user-pools-computing-secret-hash).
    secret_hash: ?[]const u8 = null,

    /// The optional session ID from a `SignUp` API request. You can sign in a user
    /// directly from the sign-up process with the `USER_AUTH` authentication
    /// flow.
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

    /// The name of the user that you want to query or modify. The value of this
    /// parameter
    /// is typically your user's username, but it can be any of their alias
    /// attributes. If
    /// `username` isn't an alias attribute in your user pool, this value
    /// must be the `sub` of a local user or the username of a user from a
    /// third-party IdP.
    username: []const u8,

    pub const json_field_names = .{
        .analytics_metadata = "AnalyticsMetadata",
        .client_id = "ClientId",
        .client_metadata = "ClientMetadata",
        .confirmation_code = "ConfirmationCode",
        .force_alias_creation = "ForceAliasCreation",
        .secret_hash = "SecretHash",
        .session = "Session",
        .user_context_data = "UserContextData",
        .username = "Username",
    };
};

pub const ConfirmSignUpOutput = struct {
    /// A session identifier that you can use to immediately sign in the confirmed
    /// user. You
    /// can automatically sign users in with the one-time password that they
    /// provided in a
    /// successful `ConfirmSignUp` request.
    session: ?[]const u8 = null,

    pub const json_field_names = .{
        .session = "Session",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ConfirmSignUpInput, options: CallOptions) !ConfirmSignUpOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ConfirmSignUpInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.ConfirmSignUp");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ConfirmSignUpOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ConfirmSignUpOutput, body, allocator);
}

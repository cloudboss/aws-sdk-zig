const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeliveryMediumType = @import("delivery_medium_type.zig").DeliveryMediumType;
const MessageActionType = @import("message_action_type.zig").MessageActionType;
const AttributeType = @import("attribute_type.zig").AttributeType;
const UserType = @import("user_type.zig").UserType;

pub const AdminCreateUserInput = struct {
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

    /// Specify `EMAIL` if email will be used to send the welcome message. Specify
    /// `SMS` if the phone number will be used. The default value is
    /// `SMS`. You can specify more than one value.
    desired_delivery_mediums: ?[]const DeliveryMediumType = null,

    /// This parameter is used only if the `phone_number_verified` or
    /// `email_verified` attribute is set to `True`. Otherwise, it is
    /// ignored.
    ///
    /// If this parameter is set to `True` and the phone number or email address
    /// specified in the `UserAttributes` parameter already exists as an alias with
    /// a
    /// different user, this request migrates the alias from the previous user to
    /// the
    /// newly-created user. The previous user will no longer be able to log in using
    /// that
    /// alias.
    ///
    /// If this parameter is set to `False`, the API throws an
    /// `AliasExistsException` error if the alias already exists. The default
    /// value is `False`.
    force_alias_creation: ?bool = null,

    /// Set to `RESEND` to resend the invitation message to a user that already
    /// exists, and to reset the temporary-password duration with a new temporary
    /// password. Set
    /// to `SUPPRESS` to suppress sending the message. You can specify only one
    /// value.
    message_action: ?MessageActionType = null,

    /// The user's temporary password. This password must conform to the password
    /// policy that
    /// you specified when you created the user pool.
    ///
    /// The exception to the requirement for a password is when your user pool
    /// supports
    /// passwordless sign-in with email or SMS OTPs. To create a user with no
    /// password, omit
    /// this parameter or submit a blank value. You can only create a passwordless
    /// user when
    /// passwordless sign-in is available.
    ///
    /// The temporary password is valid only once. To complete the Admin Create User
    /// flow, the
    /// user must enter the temporary password in the sign-in page, along with a new
    /// password to
    /// be used in all future sign-ins.
    ///
    /// If you don't specify a value, Amazon Cognito generates one for you unless
    /// you have passwordless
    /// options active for your user pool.
    ///
    /// The temporary password can only be used until the user account expiration
    /// limit that
    /// you set for your user pool. To reset the account after that time limit, you
    /// must call
    /// `AdminCreateUser` again and specify `RESEND` for the
    /// `MessageAction` parameter.
    temporary_password: ?[]const u8 = null,

    /// An array of name-value pairs that contain user attributes and attribute
    /// values to be
    /// set for the user to be created. You can create a user without specifying any
    /// attributes
    /// other than `Username`. However, any attributes that you specify as required
    /// (when creating a user pool or in the **Attributes** tab of
    /// the console) either you should supply (in your call to `AdminCreateUser`) or
    /// the user should supply (when they sign up in response to your welcome
    /// message).
    ///
    /// For custom attributes, you must prepend the `custom:` prefix to the
    /// attribute name.
    ///
    /// To send a message inviting the user to sign up, you must specify the user's
    /// email
    /// address or phone number. You can do this in your call to AdminCreateUser or
    /// in the
    /// **Users** tab of the Amazon Cognito console for managing your
    /// user pools.
    ///
    /// You must also provide an email address or phone number when you expect the
    /// user to do
    /// passwordless sign-in with an email or SMS OTP. These attributes must be
    /// provided when
    /// passwordless options are the only available, or when you don't submit a
    /// `TemporaryPassword`.
    ///
    /// In your `AdminCreateUser` request, you can set the
    /// `email_verified` and `phone_number_verified` attributes to
    /// `true`. The following conditions apply:
    ///
    /// **email**
    ///
    /// The email address where you want the user to receive their confirmation
    /// code and username. You must provide a value for `email` when you
    /// want to set `email_verified` to `true`, or if you set
    /// `EMAIL` in the `DesiredDeliveryMediums`
    /// parameter.
    ///
    /// **phone_number**
    ///
    /// The phone number where you want the user to receive their confirmation
    /// code and username. You must provide a value for `phone_number`
    /// when you want to set `phone_number_verified` to
    /// `true`, or if you set `SMS` in the
    /// `DesiredDeliveryMediums` parameter.
    user_attributes: ?[]const AttributeType = null,

    /// The value that you want to set as the username sign-in attribute. The
    /// following
    /// conditions apply to the username parameter.
    ///
    /// * The username can't be a duplicate of another username in the same user
    /// pool.
    ///
    /// * You can't change the value of a username after you create it.
    ///
    /// * You can only provide a value if usernames are a valid sign-in attribute
    ///   for
    /// your user pool. If your user pool only supports phone numbers or email
    /// addresses
    /// as sign-in attributes, Amazon Cognito automatically generates a username
    /// value. For more
    /// information, see [Customizing sign-in
    /// attributes](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-attributes.html#user-pool-settings-aliases).
    username: []const u8,

    /// The ID of the user pool where you want to create a user.
    user_pool_id: []const u8,

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
        .client_metadata = "ClientMetadata",
        .desired_delivery_mediums = "DesiredDeliveryMediums",
        .force_alias_creation = "ForceAliasCreation",
        .message_action = "MessageAction",
        .temporary_password = "TemporaryPassword",
        .user_attributes = "UserAttributes",
        .username = "Username",
        .user_pool_id = "UserPoolId",
        .validation_data = "ValidationData",
    };
};

pub const AdminCreateUserOutput = struct {
    /// The new user's profile details.
    user: ?UserType = null,

    pub const json_field_names = .{
        .user = "User",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AdminCreateUserInput, options: CallOptions) !AdminCreateUserOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AdminCreateUserInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.AdminCreateUser");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AdminCreateUserOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(AdminCreateUserOutput, body, allocator);
}

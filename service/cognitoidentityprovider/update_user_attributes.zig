const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AttributeType = @import("attribute_type.zig").AttributeType;
const CodeDeliveryDetailsType = @import("code_delivery_details_type.zig").CodeDeliveryDetailsType;

pub const UpdateUserAttributesInput = struct {
    /// A valid access token that Amazon Cognito issued to the currently signed-in
    /// user. Must include a scope claim for
    /// `aws.cognito.signin.user.admin`.
    access_token: []const u8,

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

    /// An array of name-value pairs representing user attributes.
    ///
    /// For custom attributes, you must add a `custom:` prefix to the attribute
    /// name.
    ///
    /// If you have set an attribute to require verification before Amazon Cognito
    /// updates its value,
    /// this request doesn’t immediately update the value of that attribute. After
    /// your user
    /// receives and responds to a verification message to verify the new value,
    /// Amazon Cognito updates
    /// the attribute value. Your user can sign in and receive messages with the
    /// original
    /// attribute value until they verify the new value.
    user_attributes: []const AttributeType,

    pub const json_field_names = .{
        .access_token = "AccessToken",
        .client_metadata = "ClientMetadata",
        .user_attributes = "UserAttributes",
    };
};

pub const UpdateUserAttributesOutput = struct {
    /// When the attribute-update request includes an email address or phone number
    /// attribute,
    /// Amazon Cognito sends a message to users with a code that confirms ownership
    /// of the new value that
    /// they entered. The `CodeDeliveryDetails` object is information about the
    /// delivery destination for that link or code. This behavior happens in user
    /// pools
    /// configured to automatically verify changes to those attributes. For more
    /// information,
    /// see [Verifying when users change their email or phone
    /// number](https://docs.aws.amazon.com/cognito/latest/developerguide/signing-up-users-in-your-app.html#verifying-when-users-change-their-email-or-phone-number).
    code_delivery_details_list: ?[]const CodeDeliveryDetailsType = null,

    pub const json_field_names = .{
        .code_delivery_details_list = "CodeDeliveryDetailsList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateUserAttributesInput, options: CallOptions) !UpdateUserAttributesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateUserAttributesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.UpdateUserAttributes");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateUserAttributesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateUserAttributesOutput, body, allocator);
}

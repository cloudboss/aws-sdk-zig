const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SchemaAttributeType = @import("schema_attribute_type.zig").SchemaAttributeType;

pub const AddCustomAttributesInput = struct {
    /// An array of custom attribute names and other properties. Sets the following
    /// characteristics:
    ///
    /// **AttributeDataType**
    ///
    /// The expected data type. Can be a string, a number, a date and time, or a
    /// boolean.
    ///
    /// **Mutable**
    ///
    /// If true, you can grant app clients write access to the attribute value. If
    /// false, the attribute value can only be set up on sign-up or administrator
    /// creation of users.
    ///
    /// **Name**
    ///
    /// The attribute name. For an attribute like `custom:myAttribute`,
    /// enter `myAttribute` for this field.
    ///
    /// **Required**
    ///
    /// When true, users who sign up or are created must set a value for the
    /// attribute.
    ///
    /// **NumberAttributeConstraints**
    ///
    /// The minimum and maximum length of accepted values for a
    /// `Number`-type attribute.
    ///
    /// **StringAttributeConstraints**
    ///
    /// The minimum and maximum length of accepted values for a
    /// `String`-type attribute.
    ///
    /// **DeveloperOnlyAttribute**
    ///
    /// This legacy option creates an attribute with a `dev:` prefix.
    /// You can only set the value of a developer-only attribute with administrative
    /// IAM credentials.
    custom_attributes: []const SchemaAttributeType,

    /// The ID of the user pool where you want to add custom attributes.
    user_pool_id: []const u8,

    pub const json_field_names = .{
        .custom_attributes = "CustomAttributes",
        .user_pool_id = "UserPoolId",
    };
};

pub const AddCustomAttributesOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AddCustomAttributesInput, options: CallOptions) !AddCustomAttributesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AddCustomAttributesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.AddCustomAttributes");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AddCustomAttributesOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}

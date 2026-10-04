const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ClientSecretDescriptorType = @import("client_secret_descriptor_type.zig").ClientSecretDescriptorType;

pub const AddUserPoolClientSecretInput = struct {
    /// The ID of the app client for which you want to create a new secret.
    client_id: []const u8,

    /// The client secret value you want to use. If you don't provide this
    /// parameter, Amazon Cognito generates a secure secret for you.
    client_secret: ?[]const u8 = null,

    /// The ID of the user pool that contains the app client.
    user_pool_id: []const u8,

    pub const json_field_names = .{
        .client_id = "ClientId",
        .client_secret = "ClientSecret",
        .user_pool_id = "UserPoolId",
    };
};

pub const AddUserPoolClientSecretOutput = struct {
    /// The details of the newly created client secret, including its unique
    /// identifier and creation timestamp. The ClientSecretValue is only returned
    /// when Amazon Cognito generates the secret. For custom secrets that you
    /// provide, the ClientSecretValue is not included in the response.
    client_secret_descriptor: ?ClientSecretDescriptorType = null,

    pub const json_field_names = .{
        .client_secret_descriptor = "ClientSecretDescriptor",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AddUserPoolClientSecretInput, options: CallOptions) !AddUserPoolClientSecretOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AddUserPoolClientSecretInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.AddUserPoolClientSecret");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AddUserPoolClientSecretOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(AddUserPoolClientSecretOutput, body, allocator);
}

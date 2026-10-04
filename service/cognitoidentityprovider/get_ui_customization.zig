const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UICustomizationType = @import("ui_customization_type.zig").UICustomizationType;

pub const GetUICustomizationInput = struct {
    /// The ID of the app client that you want to query for branding settings.
    client_id: ?[]const u8 = null,

    /// The ID of the user pool that you want to query for branding settings.
    user_pool_id: []const u8,

    pub const json_field_names = .{
        .client_id = "ClientId",
        .user_pool_id = "UserPoolId",
    };
};

pub const GetUICustomizationOutput = struct {
    /// Information about the classic hosted UI custom CSS and logo-image branding
    /// that you
    /// applied to the user pool or app client.
    ui_customization: ?UICustomizationType = null,

    pub const json_field_names = .{
        .ui_customization = "UICustomization",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetUICustomizationInput, options: CallOptions) !GetUICustomizationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetUICustomizationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.GetUICustomization");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetUICustomizationOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetUICustomizationOutput, body, allocator);
}

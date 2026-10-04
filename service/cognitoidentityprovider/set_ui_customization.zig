const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UICustomizationType = @import("ui_customization_type.zig").UICustomizationType;

pub const SetUICustomizationInput = struct {
    /// The ID of the app client that you want to customize. To apply a default
    /// style to all
    /// app clients not configured with client-level branding, set this parameter
    /// value to
    /// `ALL`.
    client_id: ?[]const u8 = null,

    /// A plaintext CSS file that contains the custom fields that you want to apply
    /// to your
    /// user pool or app client. To download a template, go to the Amazon Cognito
    /// console. Navigate to
    /// your user pool *App clients* tab, select *Login
    /// pages*, edit *Hosted UI (classic) style*, and select
    /// the link to `CSS template.css`.
    css: ?[]const u8 = null,

    /// The image that you want to set as your login in the classic hosted UI, as a
    /// Base64-formatted binary object.
    image_file: ?[]const u8 = null,

    /// The ID of the user pool where you want to apply branding to the classic
    /// hosted
    /// UI.
    user_pool_id: []const u8,

    pub const json_field_names = .{
        .client_id = "ClientId",
        .css = "CSS",
        .image_file = "ImageFile",
        .user_pool_id = "UserPoolId",
    };
};

pub const SetUICustomizationOutput = struct {
    /// Information about the hosted UI branding that you applied.
    ui_customization: ?UICustomizationType = null,

    pub const json_field_names = .{
        .ui_customization = "UICustomization",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SetUICustomizationInput, options: CallOptions) !SetUICustomizationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SetUICustomizationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.SetUICustomization");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SetUICustomizationOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(SetUICustomizationOutput, body, allocator);
}

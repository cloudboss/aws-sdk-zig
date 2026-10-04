const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssetType = @import("asset_type.zig").AssetType;
const ManagedLoginBrandingType = @import("managed_login_branding_type.zig").ManagedLoginBrandingType;

pub const UpdateManagedLoginBrandingInput = struct {
    /// An array of image files that you want to apply to roles like backgrounds,
    /// logos, and
    /// icons. Each object must also indicate whether it is for dark mode, light
    /// mode, or
    /// browser-adaptive mode.
    assets: ?[]const AssetType = null,

    /// The ID of the managed login branding style that you want to update.
    managed_login_branding_id: ?[]const u8 = null,

    /// A JSON file, encoded as a `Document` type, with the the settings that you
    /// want to apply to your style.
    ///
    /// The following components are not currently implemented and reserved for
    /// future
    /// use:
    ///
    /// * `signUp`
    ///
    /// * `instructions`
    ///
    /// * `sessionTimerDisplay`
    ///
    /// * `languageSelector` (for localization, see [Managed login
    ///   localization)](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-managed-login.html#managed-login-localization)
    settings: ?[]const u8 = null,

    /// When `true`, applies the default branding style options. This option
    /// reverts to default style options that are managed by Amazon Cognito. You can
    /// modify them later in
    /// the branding editor.
    ///
    /// When you specify `true` for this option, you must also omit values for
    /// `Settings` and `Assets` in the request.
    use_cognito_provided_values: ?bool = null,

    /// The ID of the user pool that contains the managed login branding style that
    /// you want
    /// to update.
    user_pool_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .assets = "Assets",
        .managed_login_branding_id = "ManagedLoginBrandingId",
        .settings = "Settings",
        .use_cognito_provided_values = "UseCognitoProvidedValues",
        .user_pool_id = "UserPoolId",
    };
};

pub const UpdateManagedLoginBrandingOutput = struct {
    /// The details of the branding style that you updated.
    managed_login_branding: ?ManagedLoginBrandingType = null,

    pub const json_field_names = .{
        .managed_login_branding = "ManagedLoginBranding",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateManagedLoginBrandingInput, options: CallOptions) !UpdateManagedLoginBrandingOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateManagedLoginBrandingInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.UpdateManagedLoginBranding");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateManagedLoginBrandingOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateManagedLoginBrandingOutput, body, allocator);
}

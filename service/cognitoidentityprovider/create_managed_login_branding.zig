const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssetType = @import("asset_type.zig").AssetType;
const ManagedLoginBrandingType = @import("managed_login_branding_type.zig").ManagedLoginBrandingType;

pub const CreateManagedLoginBrandingInput = struct {
    /// An array of image files that you want to apply to functions like
    /// backgrounds, logos,
    /// and icons. Each object must also indicate whether it is for dark mode, light
    /// mode, or
    /// browser-adaptive mode.
    assets: ?[]const AssetType = null,

    /// The app client that you want to create the branding style for. Each style is
    /// linked to
    /// an app client until you delete it.
    client_id: []const u8,

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

    /// When true, applies the default branding style options. These default options
    /// are
    /// managed by Amazon Cognito. You can modify them later in the branding editor.
    ///
    /// When you specify `true` for this option, you must also omit values for
    /// `Settings` and `Assets` in the request.
    use_cognito_provided_values: ?bool = null,

    /// The ID of the user pool where you want to create a new branding style.
    user_pool_id: []const u8,

    pub const json_field_names = .{
        .assets = "Assets",
        .client_id = "ClientId",
        .settings = "Settings",
        .use_cognito_provided_values = "UseCognitoProvidedValues",
        .user_pool_id = "UserPoolId",
    };
};

pub const CreateManagedLoginBrandingOutput = struct {
    /// The details of the branding style that you created.
    managed_login_branding: ?ManagedLoginBrandingType = null,

    pub const json_field_names = .{
        .managed_login_branding = "ManagedLoginBranding",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateManagedLoginBrandingInput, options: CallOptions) !CreateManagedLoginBrandingOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateManagedLoginBrandingInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.CreateManagedLoginBranding");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateManagedLoginBrandingOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateManagedLoginBrandingOutput, body, allocator);
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CustomDomainConfigType = @import("custom_domain_config_type.zig").CustomDomainConfigType;

pub const CreateUserPoolDomainInput = struct {
    /// The configuration for a custom domain. Configures your domain with an
    /// Certificate Manager
    /// certificate in the `us-east-1` Region.
    ///
    /// Provide this parameter only if you want to use a [custom
    /// domain](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-add-custom-domain.html) for your user pool. Otherwise, you can
    /// omit this parameter and use a [prefix
    /// domain](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-assign-domain-prefix.html) instead.
    ///
    /// When you create a custom domain, the passkey RP ID defaults to the custom
    /// domain. If
    /// you had a prefix domain active, this will cause passkey integration for your
    /// prefix
    /// domain to stop working due to a mismatch in RP ID. To keep the prefix domain
    /// passkey
    /// integration working, you can explicitly set RP ID to the prefix domain.
    custom_domain_config: ?CustomDomainConfigType = null,

    /// The domain string. For custom domains, this is the fully-qualified domain
    /// name, such
    /// as `auth.example.com`. For prefix domains, this is the prefix alone, such as
    /// `myprefix`. A prefix value of `myprefix` for a user pool in
    /// the `us-east-1` Region results in a domain of
    /// `myprefix.auth.us-east-1.amazoncognito.com`.
    domain: []const u8,

    /// The version of managed login branding that you want to apply to your domain.
    /// A value
    /// of `1` indicates hosted UI (classic) and a version of `2`
    /// indicates managed login.
    ///
    /// Managed login requires that your user pool be configured for any [feature
    /// plan](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-sign-in-feature-plans.html) other than `Lite`.
    managed_login_version: ?i32 = null,

    /// The ID of the user pool where you want to add a domain.
    user_pool_id: []const u8,

    pub const json_field_names = .{
        .custom_domain_config = "CustomDomainConfig",
        .domain = "Domain",
        .managed_login_version = "ManagedLoginVersion",
        .user_pool_id = "UserPoolId",
    };
};

pub const CreateUserPoolDomainOutput = struct {
    /// The fully-qualified domain name (FQDN) of the Amazon CloudFront distribution
    /// that hosts your
    /// managed login or classic hosted UI pages. Your domain-name authority must
    /// have an alias
    /// record that points requests for your custom domain to this FQDN. Amazon
    /// Cognito returns this
    /// value if you set a custom domain with `CustomDomainConfig`. If you set an
    /// Amazon Cognito prefix domain, this parameter returns null.
    cloud_front_domain: ?[]const u8 = null,

    /// The version of managed login branding applied your domain. A value of `1`
    /// indicates hosted UI (classic) and a version of `2` indicates managed
    /// login.
    managed_login_version: ?i32 = null,

    pub const json_field_names = .{
        .cloud_front_domain = "CloudFrontDomain",
        .managed_login_version = "ManagedLoginVersion",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateUserPoolDomainInput, options: CallOptions) !CreateUserPoolDomainOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateUserPoolDomainInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.CreateUserPoolDomain");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateUserPoolDomainOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateUserPoolDomainOutput, body, allocator);
}

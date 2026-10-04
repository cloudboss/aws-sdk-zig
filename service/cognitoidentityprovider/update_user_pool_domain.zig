const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CustomDomainConfigType = @import("custom_domain_config_type.zig").CustomDomainConfigType;

pub const UpdateUserPoolDomainInput = struct {
    /// The configuration for a custom domain that hosts managed login for your
    /// application.
    /// In an `UpdateUserPoolDomain` request, this parameter specifies an SSL
    /// certificate for the managed login hosted webserver. The certificate must be
    /// an ACM ARN
    /// in `us-east-1`.
    ///
    /// When you create a custom domain, the passkey RP ID defaults to the custom
    /// domain. If
    /// you had a prefix domain active, this will cause passkey integration for your
    /// prefix
    /// domain to stop working due to a mismatch in RP ID. To keep the prefix domain
    /// passkey
    /// integration working, you can explicitly set RP ID to the prefix domain.
    custom_domain_config: ?CustomDomainConfigType = null,

    /// The name of the domain that you want to update. For custom domains, this is
    /// the
    /// fully-qualified domain name, for example `auth.example.com`. For prefix
    /// domains, this is the prefix alone, such as `myprefix`.
    domain: []const u8,

    /// A version number that indicates the state of managed login for your domain.
    /// Version
    /// `1` is hosted UI (classic). Version `2` is the newer managed
    /// login with the branding editor. For more information, see [Managed
    /// login](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-managed-login.html).
    managed_login_version: ?i32 = null,

    /// The ID of the user pool that is associated with the domain you're updating.
    user_pool_id: []const u8,

    pub const json_field_names = .{
        .custom_domain_config = "CustomDomainConfig",
        .domain = "Domain",
        .managed_login_version = "ManagedLoginVersion",
        .user_pool_id = "UserPoolId",
    };
};

pub const UpdateUserPoolDomainOutput = struct {
    /// The fully-qualified domain name (FQDN) of the Amazon CloudFront distribution
    /// that hosts your
    /// managed login or classic hosted UI pages. You domain-name authority must
    /// have an alias
    /// record that points requests for your custom domain to this FQDN. Amazon
    /// Cognito returns this
    /// value if you set a custom domain with `CustomDomainConfig`. If you set an
    /// Amazon Cognito prefix domain, this operation returns a blank response.
    cloud_front_domain: ?[]const u8 = null,

    /// A version number that indicates the state of managed login for your domain.
    /// Version
    /// `1` is hosted UI (classic). Version `2` is the newer managed
    /// login with the branding editor. For more information, see [Managed
    /// login](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-managed-login.html).
    managed_login_version: ?i32 = null,

    pub const json_field_names = .{
        .cloud_front_domain = "CloudFrontDomain",
        .managed_login_version = "ManagedLoginVersion",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateUserPoolDomainInput, options: CallOptions) !UpdateUserPoolDomainOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateUserPoolDomainInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.UpdateUserPoolDomain");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateUserPoolDomainOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateUserPoolDomainOutput, body, allocator);
}

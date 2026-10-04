const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ManagedLoginBrandingType = @import("managed_login_branding_type.zig").ManagedLoginBrandingType;

pub const DescribeManagedLoginBrandingByClientInput = struct {
    /// The app client that's assigned to the branding style that you want more
    /// information
    /// about.
    client_id: []const u8,

    /// When `true`, returns values for branding options that are unchanged from
    /// Amazon Cognito defaults. When `false` or when you omit this parameter,
    /// returns only
    /// values that you customized in your branding style.
    return_merged_resources: ?bool = null,

    /// The ID of the user pool that contains the app client where you want more
    /// information
    /// about the managed login branding style.
    user_pool_id: []const u8,

    pub const json_field_names = .{
        .client_id = "ClientId",
        .return_merged_resources = "ReturnMergedResources",
        .user_pool_id = "UserPoolId",
    };
};

pub const DescribeManagedLoginBrandingByClientOutput = struct {
    /// The details of the requested branding style.
    managed_login_branding: ?ManagedLoginBrandingType = null,

    pub const json_field_names = .{
        .managed_login_branding = "ManagedLoginBranding",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeManagedLoginBrandingByClientInput, options: CallOptions) !DescribeManagedLoginBrandingByClientOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeManagedLoginBrandingByClientInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.DescribeManagedLoginBrandingByClient");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeManagedLoginBrandingByClientOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeManagedLoginBrandingByClientOutput, body, allocator);
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const SetPrincipalTagAttributeMapInput = struct {
    /// The ID of the Identity Pool you want to set attribute mappings for.
    identity_pool_id: []const u8,

    /// The provider name you want to use for attribute mappings.
    identity_provider_name: []const u8,

    /// You can use this operation to add principal tags.
    principal_tags: ?[]const aws.map.StringMapEntry = null,

    /// You can use this operation to use default (username and clientID) attribute
    /// mappings.
    use_defaults: ?bool = null,

    pub const json_field_names = .{
        .identity_pool_id = "IdentityPoolId",
        .identity_provider_name = "IdentityProviderName",
        .principal_tags = "PrincipalTags",
        .use_defaults = "UseDefaults",
    };
};

pub const SetPrincipalTagAttributeMapOutput = struct {
    /// The ID of the Identity Pool you want to set attribute mappings for.
    identity_pool_id: ?[]const u8 = null,

    /// The provider name you want to use for attribute mappings.
    identity_provider_name: ?[]const u8 = null,

    /// You can use this operation to add principal tags. The
    /// `PrincipalTags`operation enables you to reference user attributes in your
    /// IAM permissions policy.
    principal_tags: ?[]const aws.map.StringMapEntry = null,

    /// You can use this operation to select default (username and clientID)
    /// attribute
    /// mappings.
    use_defaults: ?bool = null,

    pub const json_field_names = .{
        .identity_pool_id = "IdentityPoolId",
        .identity_provider_name = "IdentityProviderName",
        .principal_tags = "PrincipalTags",
        .use_defaults = "UseDefaults",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SetPrincipalTagAttributeMapInput, options: CallOptions) !SetPrincipalTagAttributeMapOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cognito-identity", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SetPrincipalTagAttributeMapInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cognito-identity", "Cognito Identity", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityService.SetPrincipalTagAttributeMap");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SetPrincipalTagAttributeMapOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(SetPrincipalTagAttributeMapOutput, body, allocator);
}

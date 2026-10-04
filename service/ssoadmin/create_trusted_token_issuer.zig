const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const TrustedTokenIssuerConfiguration = @import("trusted_token_issuer_configuration.zig").TrustedTokenIssuerConfiguration;
const TrustedTokenIssuerType = @import("trusted_token_issuer_type.zig").TrustedTokenIssuerType;

pub const CreateTrustedTokenIssuerInput = struct {
    /// Specifies a unique, case-sensitive ID that you provide to ensure the
    /// idempotency of the request. This lets you safely retry the request without
    /// accidentally performing the same operation a second time. Passing the same
    /// value to a later call to an operation requires that you also pass the same
    /// value for all other parameters. We recommend that you use a [UUID type of
    /// value.](https://wikipedia.org/wiki/Universally_unique_identifier).
    ///
    /// If you don't provide this value, then Amazon Web Services generates a random
    /// one for you.
    ///
    /// If you retry the operation with the same `ClientToken`, but with different
    /// parameters, the retry fails with an `IdempotentParameterMismatch` error.
    client_token: ?[]const u8 = null,

    /// Specifies the ARN of the instance of IAM Identity Center to contain the new
    /// trusted token issuer configuration.
    instance_arn: []const u8,

    /// Specifies the name of the new trusted token issuer configuration.
    name: []const u8,

    /// Specifies tags to be attached to the new trusted token issuer configuration.
    tags: ?[]const Tag = null,

    /// Specifies settings that apply to the new trusted token issuer configuration.
    /// The settings that are available depend on what `TrustedTokenIssuerType` you
    /// specify.
    trusted_token_issuer_configuration: TrustedTokenIssuerConfiguration,

    /// Specifies the type of the new trusted token issuer.
    trusted_token_issuer_type: TrustedTokenIssuerType,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .instance_arn = "InstanceArn",
        .name = "Name",
        .tags = "Tags",
        .trusted_token_issuer_configuration = "TrustedTokenIssuerConfiguration",
        .trusted_token_issuer_type = "TrustedTokenIssuerType",
    };
};

pub const CreateTrustedTokenIssuerOutput = struct {
    /// The ARN of the new trusted token issuer configuration.
    trusted_token_issuer_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .trusted_token_issuer_arn = "TrustedTokenIssuerArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTrustedTokenIssuerInput, options: CallOptions) !CreateTrustedTokenIssuerOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sso", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTrustedTokenIssuerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sso", "SSO Admin", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SWBExternalService.CreateTrustedTokenIssuer");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTrustedTokenIssuerOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateTrustedTokenIssuerOutput, body, allocator);
}

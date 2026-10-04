const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TrustedTokenIssuerConfiguration = @import("trusted_token_issuer_configuration.zig").TrustedTokenIssuerConfiguration;
const TrustedTokenIssuerType = @import("trusted_token_issuer_type.zig").TrustedTokenIssuerType;

pub const DescribeTrustedTokenIssuerInput = struct {
    /// Specifies the ARN of the trusted token issuer configuration that you want
    /// details about.
    trusted_token_issuer_arn: []const u8,

    pub const json_field_names = .{
        .trusted_token_issuer_arn = "TrustedTokenIssuerArn",
    };
};

pub const DescribeTrustedTokenIssuerOutput = struct {
    /// The name of the trusted token issuer configuration.
    name: ?[]const u8 = null,

    /// The ARN of the trusted token issuer configuration.
    trusted_token_issuer_arn: ?[]const u8 = null,

    /// A structure the describes the settings that apply of this trusted token
    /// issuer.
    trusted_token_issuer_configuration: ?TrustedTokenIssuerConfiguration = null,

    /// The type of the trusted token issuer.
    trusted_token_issuer_type: ?TrustedTokenIssuerType = null,

    pub const json_field_names = .{
        .name = "Name",
        .trusted_token_issuer_arn = "TrustedTokenIssuerArn",
        .trusted_token_issuer_configuration = "TrustedTokenIssuerConfiguration",
        .trusted_token_issuer_type = "TrustedTokenIssuerType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeTrustedTokenIssuerInput, options: CallOptions) !DescribeTrustedTokenIssuerOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeTrustedTokenIssuerInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SWBExternalService.DescribeTrustedTokenIssuer");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeTrustedTokenIssuerOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeTrustedTokenIssuerOutput, body, allocator);
}

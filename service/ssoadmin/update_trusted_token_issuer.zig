const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TrustedTokenIssuerUpdateConfiguration = @import("trusted_token_issuer_update_configuration.zig").TrustedTokenIssuerUpdateConfiguration;

pub const UpdateTrustedTokenIssuerInput = struct {
    /// Specifies the updated name to be applied to the trusted token issuer
    /// configuration.
    name: ?[]const u8 = null,

    /// Specifies the ARN of the trusted token issuer configuration that you want to
    /// update.
    trusted_token_issuer_arn: []const u8,

    /// Specifies a structure with settings to apply to the specified trusted token
    /// issuer. The settings that you can provide are determined by the type of the
    /// trusted token issuer that you are updating.
    trusted_token_issuer_configuration: ?TrustedTokenIssuerUpdateConfiguration = null,

    pub const json_field_names = .{
        .name = "Name",
        .trusted_token_issuer_arn = "TrustedTokenIssuerArn",
        .trusted_token_issuer_configuration = "TrustedTokenIssuerConfiguration",
    };
};

pub const UpdateTrustedTokenIssuerOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateTrustedTokenIssuerInput, options: CallOptions) !UpdateTrustedTokenIssuerOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateTrustedTokenIssuerInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SWBExternalService.UpdateTrustedTokenIssuer");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateTrustedTokenIssuerOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}

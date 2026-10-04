const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TokenType = @import("token_type.zig").TokenType;

pub const CreateTokenInput = struct {
    /// Idempotency token, valid for 10 minutes.
    client_token: []const u8,

    /// Token expiration, in days, counted from token creation. The default is 365
    /// days.
    expiration_in_days: ?i32 = null,

    /// Amazon Resource Name (ARN) of the license. The ARN is mapped to the aud
    /// claim of the
    /// JWT token.
    license_arn: []const u8,

    /// Amazon Resource Name (ARN) of the IAM roles to embed in the token.
    /// License Manager does not check whether the roles are in use.
    role_arns: ?[]const []const u8 = null,

    /// Data specified by the caller to be included in the JWT token. The data is
    /// mapped
    /// to the amr claim of the JWT token.
    token_properties: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .expiration_in_days = "ExpirationInDays",
        .license_arn = "LicenseArn",
        .role_arns = "RoleArns",
        .token_properties = "TokenProperties",
    };
};

pub const CreateTokenOutput = struct {
    /// Refresh token, encoded as a JWT token.
    token: ?[]const u8 = null,

    /// Token ID.
    token_id: ?[]const u8 = null,

    /// Token type.
    token_type: ?TokenType = null,

    pub const json_field_names = .{
        .token = "Token",
        .token_id = "TokenId",
        .token_type = "TokenType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTokenInput, options: CallOptions) !CreateTokenOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "license-manager", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTokenInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("license-manager", "License Manager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSLicenseManager.CreateToken");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTokenOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateTokenOutput, body, allocator);
}

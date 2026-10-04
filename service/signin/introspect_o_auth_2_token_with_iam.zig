const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const IntrospectOAuth2TokenWithIAMInput = struct {
    /// The string value of the token to introspect.
    /// May be either an access_token or a refresh_token issued by AWS Sign-In.
    token: []const u8,

    /// Optional hint about the type of the token submitted for introspection.
    /// The server uses this hint to optimize lookup, but still falls back to
    /// the other token type on miss. Allowed values: access_token, refresh_token.
    token_type_hint: ?[]const u8 = null,

    pub const json_field_names = .{
        .token = "token",
        .token_type_hint = "tokenTypeHint",
    };
};

pub const IntrospectOAuth2TokenWithIAMOutput = struct {
    /// 12-digit AWS account ID of the token's subject principal.
    account_id: ?[]const u8 = null,

    /// Indicates whether the token is currently active. `true` only when the
    /// token is valid, has not expired, has not been revoked, and belongs to
    /// the caller's account.
    active: bool,

    /// Audience of the token: the OAuth resource the token is scoped to
    /// (for example, "aws-mcp.amazonaws.com"). Omitted for refresh tokens.
    aud: ?[]const u8 = null,

    /// Client identifier for the OAuth 2.0 client that requested the token.
    client_id: ?[]const u8 = null,

    /// Token expiration time as a NumericDate (Unix epoch seconds).
    exp: ?i64 = null,

    /// Token issuance time as a NumericDate (Unix epoch seconds).
    iat: ?i64 = null,

    /// Issuer of the token. Always "signin.amazonaws.com" for AWS Sign-In.
    iss: ?[]const u8 = null,

    /// Unique identifier for the token.
    jti: ?[]const u8 = null,

    /// Token "not before" time as a NumericDate (Unix epoch seconds).
    nbf: ?i64 = null,

    /// The OAuth resource the token is scoped to during Human OAuth flow.
    /// Only present for refresh token introspection.
    resource: ?[]const u8 = null,

    /// AWS Sign-In session ARN bound to the token, of the form
    /// arn:aws:signin:{region}:{account}:session/{uuid}.
    signin_session: ?[]const u8 = null,

    /// Subject of the token: the IAM principal ARN. For assumed-role sessions,
    /// this is the session ARN (matches sts:GetCallerIdentity's `Arn` field),
    /// e.g. arn:aws:sts::123456789012:assumed-role/MyRole/session-name.
    sub: ?[]const u8 = null,

    /// Indicates which kind of token was introspected.
    /// One of "access_token" or "refresh_token".
    token_type: ?[]const u8 = null,

    /// User identifier matching sts:GetCallerIdentity's `UserId` field for the
    /// token's subject principal (e.g. "AIDAEXAMPLE" for an IAM user, or
    /// "AROAEXAMPLE:session-name" for an assumed role).
    user_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .active = "active",
        .aud = "aud",
        .client_id = "clientId",
        .exp = "exp",
        .iat = "iat",
        .iss = "iss",
        .jti = "jti",
        .nbf = "nbf",
        .resource = "resource",
        .signin_session = "signinSession",
        .sub = "sub",
        .token_type = "tokenType",
        .user_id = "userId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: IntrospectOAuth2TokenWithIAMInput, options: CallOptions) !IntrospectOAuth2TokenWithIAMOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "signin", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: IntrospectOAuth2TokenWithIAMInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("signin", "Signin", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/introspect";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    try query_buf.appendSlice(allocator, "x-amz-client-auth-method=iam");
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"token\":");
    try aws.json.writeValue(@TypeOf(input.token), input.token, allocator, &body_buf);
    has_prev = true;
    if (input.token_type_hint) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tokenTypeHint\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !IntrospectOAuth2TokenWithIAMOutput {
    const result: IntrospectOAuth2TokenWithIAMOutput = try aws.json.parseJsonObject(
        IntrospectOAuth2TokenWithIAMOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

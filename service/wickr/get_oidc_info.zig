const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OidcConfigInfo = @import("oidc_config_info.zig").OidcConfigInfo;
const OidcTokenInfo = @import("oidc_token_info.zig").OidcTokenInfo;

pub const GetOidcInfoInput = struct {
    /// The CA certificate for secure communication with the OIDC provider
    /// (optional).
    certificate: ?[]const u8 = null,

    /// The OAuth client ID for retrieving access tokens (optional).
    client_id: ?[]const u8 = null,

    /// The OAuth client secret for retrieving access tokens (optional).
    client_secret: ?[]const u8 = null,

    /// The authorization code for retrieving access tokens (optional).
    code: ?[]const u8 = null,

    /// The PKCE code verifier for enhanced security in the OAuth flow (optional).
    code_verifier: ?[]const u8 = null,

    /// The OAuth grant type for retrieving access tokens (optional).
    grant_type: ?[]const u8 = null,

    /// The ID of the Wickr network whose OIDC configuration will be retrieved.
    network_id: []const u8,

    /// The redirect URI for the OAuth flow (optional).
    redirect_uri: ?[]const u8 = null,

    /// The URL for the OIDC provider (optional).
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .certificate = "certificate",
        .client_id = "clientId",
        .client_secret = "clientSecret",
        .code = "code",
        .code_verifier = "codeVerifier",
        .grant_type = "grantType",
        .network_id = "networkId",
        .redirect_uri = "redirectUri",
        .url = "url",
    };
};

pub const GetOidcInfoOutput = struct {
    /// The OpenID Connect configuration information for the network, including
    /// issuer, client ID, scopes, and other SSO settings.
    openid_connect_info: ?OidcConfigInfo = null,

    /// OAuth token information including access token, refresh token, and
    /// expiration details (only present if token parameters were provided in the
    /// request).
    token_info: ?OidcTokenInfo = null,

    pub const json_field_names = .{
        .openid_connect_info = "openidConnectInfo",
        .token_info = "tokenInfo",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetOidcInfoInput, options: CallOptions) !GetOidcInfoOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "wickr", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetOidcInfoInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("admin.wickr", "Wickr", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/networks/");
    try path_buf.appendSlice(allocator, input.network_id);
    try path_buf.appendSlice(allocator, "/oidc");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.certificate) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "certificate=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.client_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "clientId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.client_secret) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "clientSecret=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.code) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "code=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.code_verifier) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "codeVerifier=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.grant_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "grantType=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.redirect_uri) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "redirectUri=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.url) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "url=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetOidcInfoOutput {
    var result: GetOidcInfoOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetOidcInfoOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

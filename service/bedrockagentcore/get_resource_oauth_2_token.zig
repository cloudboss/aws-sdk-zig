const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Oauth2FlowType = @import("oauth_2_flow_type.zig").Oauth2FlowType;
const SessionStatus = @import("session_status.zig").SessionStatus;

pub const GetResourceOauth2TokenInput = struct {
    /// The audiences to include in the token request. These are used to specify the
    /// intended recipients of the OAuth2 token.
    audiences: ?[]const []const u8 = null,

    /// A map of custom parameters to include in the authorization request to the
    /// resource credential provider. These parameters are in addition to the
    /// standard OAuth 2.0 flow parameters, and will not override them.
    custom_parameters: ?[]const aws.map.StringMapEntry = null,

    /// An opaque string that will be sent back to the callback URL provided in
    /// resourceOauth2ReturnUrl. This state should be used to protect the callback
    /// URL of your application against CSRF attacks by ensuring the response
    /// corresponds to the original request.
    custom_state: ?[]const u8 = null,

    /// Indicates whether to always initiate a new three-legged OAuth (3LO) flow,
    /// regardless of any existing session.
    force_authentication: ?bool = null,

    /// The type of flow to be performed.
    oauth_2_flow: Oauth2FlowType,

    /// The name of the resource's credential provider.
    resource_credential_provider_name: []const u8,

    /// The callback URL to redirect to after the OAuth 2.0 token retrieval is
    /// complete. This URL must be one of the provided URLs configured for the
    /// workload identity.
    resource_oauth_2_return_url: ?[]const u8 = null,

    /// The resources to include in the token request. These are used to specify the
    /// target resources for which the OAuth2 token is being requested.
    resources: ?[]const []const u8 = null,

    /// The OAuth scopes being requested.
    scopes: []const []const u8,

    /// Unique identifier for the user's authentication session for retrieving
    /// OAuth2 tokens. This ID tracks the authorization flow state across multiple
    /// requests and responses during the OAuth2 authentication process.
    session_uri: ?[]const u8 = null,

    /// The identity token of the workload from which you want to retrieve the
    /// OAuth2 token.
    workload_identity_token: []const u8,

    pub const json_field_names = .{
        .audiences = "audiences",
        .custom_parameters = "customParameters",
        .custom_state = "customState",
        .force_authentication = "forceAuthentication",
        .oauth_2_flow = "oauth2Flow",
        .resource_credential_provider_name = "resourceCredentialProviderName",
        .resource_oauth_2_return_url = "resourceOauth2ReturnUrl",
        .resources = "resources",
        .scopes = "scopes",
        .session_uri = "sessionUri",
        .workload_identity_token = "workloadIdentityToken",
    };
};

pub const GetResourceOauth2TokenOutput = struct {
    /// The OAuth 2.0 access token to use.
    access_token: ?[]const u8 = null,

    /// The URL to initiate the authorization process, provided when the access
    /// token requires user authorization.
    authorization_url: ?[]const u8 = null,

    /// Status indicating whether the user's authorization session is in progress or
    /// has failed. This helps determine the next steps in the OAuth2 authentication
    /// flow.
    session_status: ?SessionStatus = null,

    /// Unique identifier for the user's authorization session for retrieving OAuth2
    /// tokens. This matches the sessionId from the request and can be used to track
    /// the session state.
    session_uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_token = "accessToken",
        .authorization_url = "authorizationUrl",
        .session_status = "sessionStatus",
        .session_uri = "sessionUri",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetResourceOauth2TokenInput, options: CallOptions) !GetResourceOauth2TokenOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock-agentcore", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetResourceOauth2TokenInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore", "Bedrock AgentCore", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/identities/oauth2/token";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.audiences) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"audiences\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.custom_parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"customParameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.custom_state) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"customState\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.force_authentication) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"forceAuthentication\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"oauth2Flow\":");
    try aws.json.writeValue(@TypeOf(input.oauth_2_flow), input.oauth_2_flow, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"resourceCredentialProviderName\":");
    try aws.json.writeValue(@TypeOf(input.resource_credential_provider_name), input.resource_credential_provider_name, allocator, &body_buf);
    has_prev = true;
    if (input.resource_oauth_2_return_url) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"resourceOauth2ReturnUrl\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.resources) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"resources\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"scopes\":");
    try aws.json.writeValue(@TypeOf(input.scopes), input.scopes, allocator, &body_buf);
    has_prev = true;
    if (input.session_uri) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sessionUri\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"workloadIdentityToken\":");
    try aws.json.writeValue(@TypeOf(input.workload_identity_token), input.workload_identity_token, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetResourceOauth2TokenOutput {
    const result: GetResourceOauth2TokenOutput = try aws.json.parseJsonObject(
        GetResourceOauth2TokenOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

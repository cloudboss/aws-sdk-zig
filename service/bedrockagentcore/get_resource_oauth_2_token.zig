const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Oauth2FlowType = @import("oauth_2_flow_type.zig").Oauth2FlowType;
const SessionStatus = @import("session_status.zig").SessionStatus;

pub const GetResourceOauth2TokenInput = struct {
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
        .custom_parameters = "customParameters",
        .custom_state = "customState",
        .force_authentication = "forceAuthentication",
        .oauth_2_flow = "oauth2Flow",
        .resource_credential_provider_name = "resourceCredentialProviderName",
        .resource_oauth_2_return_url = "resourceOauth2ReturnUrl",
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
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "bedrock-agentcore");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetResourceOauth2TokenInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore", "Bedrock AgentCore", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/identities/oauth2/token";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

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

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetResourceOauth2TokenOutput {
    var result: GetResourceOauth2TokenOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetResourceOauth2TokenOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateIdException")) {
        return .{ .arena = arena, .kind = .{ .duplicate_id_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        return .{ .arena = arena, .kind = .{ .invalid_input_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RetryableConflictException")) {
        return .{ .arena = arena, .kind = .{ .retryable_conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RuntimeClientError")) {
        return .{ .arena = arena, .kind = .{ .runtime_client_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceException")) {
        return .{ .arena = arena, .kind = .{ .service_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottledException")) {
        return .{ .arena = arena, .kind = .{ .throttled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthorizedException")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}

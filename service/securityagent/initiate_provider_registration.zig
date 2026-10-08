const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Provider = @import("provider.zig").Provider;

pub const InitiateProviderRegistrationInput = struct {
    /// The client ID of the OAuth application registered on your self-managed
    /// provider instance.
    client_id: ?[]const u8 = null,

    /// The client secret of the OAuth application registered on your self-managed
    /// provider instance.
    client_secret: ?[]const u8 = null,

    /// The name of the organization to connect.
    organization_name: ?[]const u8 = null,

    /// The provider to initiate registration with.
    provider: Provider,

    /// The HTTPS URL of a self-managed provider instance. Omit for SaaS providers.
    target_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_id = "clientId",
        .client_secret = "clientSecret",
        .organization_name = "organizationName",
        .provider = "provider",
        .target_url = "targetUrl",
    };
};

pub const InitiateProviderRegistrationOutput = struct {
    /// The CSRF state token to use when completing the OAuth flow.
    csrf_state: []const u8,

    /// The URL to redirect the user to for completing the OAuth authorization.
    redirect_to: []const u8,

    pub const json_field_names = .{
        .csrf_state = "csrfState",
        .redirect_to = "redirectTo",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: InitiateProviderRegistrationInput, options: CallOptions) !InitiateProviderRegistrationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityagent", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: InitiateProviderRegistrationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityagent", "SecurityAgent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/oauth2/provider/register";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_secret) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientSecret\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.organization_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"organizationName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"provider\":");
    try aws.json.writeValue(@TypeOf(input.provider), input.provider, allocator, &body_buf);
    has_prev = true;
    if (input.target_url) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"targetUrl\":");
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
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !InitiateProviderRegistrationOutput {
    const result: InitiateProviderRegistrationOutput = try aws.json.parseJsonObject(
        InitiateProviderRegistrationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

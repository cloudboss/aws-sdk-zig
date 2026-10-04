const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RegisteredUserEmbeddingExperienceConfiguration = @import("registered_user_embedding_experience_configuration.zig").RegisteredUserEmbeddingExperienceConfiguration;

pub const GenerateEmbedUrlForRegisteredUserWithIdentityInput = struct {
    /// A list of domains to be allowed to generate the embed URL.
    allowed_domains: ?[]const []const u8 = null,

    /// The ID of the Amazon Web Services registered user.
    aws_account_id: []const u8,

    experience_configuration: RegisteredUserEmbeddingExperienceConfiguration,

    /// The validity of the session in minutes.
    session_lifetime_in_minutes: ?i64 = null,

    pub const json_field_names = .{
        .allowed_domains = "AllowedDomains",
        .aws_account_id = "AwsAccountId",
        .experience_configuration = "ExperienceConfiguration",
        .session_lifetime_in_minutes = "SessionLifetimeInMinutes",
    };
};

pub const GenerateEmbedUrlForRegisteredUserWithIdentityOutput = struct {
    /// The generated embed URL for the registered user.
    embed_url: []const u8,

    /// The Amazon Web Services request ID for this operation.
    request_id: []const u8,

    /// The HTTP status of the request.
    status: ?i32 = null,

    pub const json_field_names = .{
        .embed_url = "EmbedUrl",
        .request_id = "RequestId",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GenerateEmbedUrlForRegisteredUserWithIdentityInput, options: CallOptions) !GenerateEmbedUrlForRegisteredUserWithIdentityOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "quicksight", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GenerateEmbedUrlForRegisteredUserWithIdentityInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/embed-url/registered-user-with-identity");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.allowed_domains) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AllowedDomains\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ExperienceConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.experience_configuration), input.experience_configuration, allocator, &body_buf);
    has_prev = true;
    if (input.session_lifetime_in_minutes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SessionLifetimeInMinutes\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GenerateEmbedUrlForRegisteredUserWithIdentityOutput {
    var result: GenerateEmbedUrlForRegisteredUserWithIdentityOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GenerateEmbedUrlForRegisteredUserWithIdentityOutput, body, allocator);
    }
    result.status = @intCast(status);
    _ = headers;

    return result;
}

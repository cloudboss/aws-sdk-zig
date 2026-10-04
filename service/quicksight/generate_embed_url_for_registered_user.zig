const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RegisteredUserEmbeddingExperienceConfiguration = @import("registered_user_embedding_experience_configuration.zig").RegisteredUserEmbeddingExperienceConfiguration;

pub const GenerateEmbedUrlForRegisteredUserInput = struct {
    /// The domains that you want to add to the allow list for access to the
    /// generated URL
    /// that is then embedded. This optional parameter overrides the static domains
    /// that are
    /// configured in the Manage Quick Sight menu in the Amazon Quick Sight console.
    /// Instead, it
    /// allows only the domains that you include in this parameter. You can list up
    /// to three
    /// domains or subdomains in each API call.
    ///
    /// To include all subdomains under a specific domain to the allow list, use
    /// `*`. For example, `https://*.sapp.amazon.com` includes all
    /// subdomains under `https://sapp.amazon.com`.
    allowed_domains: ?[]const []const u8 = null,

    /// The ID for the Amazon Web Services account that contains the dashboard that
    /// you're
    /// embedding.
    aws_account_id: []const u8,

    /// The experience that you want to embed. For registered users, you can embed
    /// Quick dashboards, Amazon Quick Sight visuals, the Amazon Quick Sight Q
    /// search bar,
    /// the Amazon Quick Sight Generative Q&A experience, or the entire Amazon Quick
    /// Sight console.
    experience_configuration: RegisteredUserEmbeddingExperienceConfiguration,

    /// How many minutes the session is valid. The session lifetime must be in
    /// [15-600]
    /// minutes range.
    session_lifetime_in_minutes: ?i64 = null,

    /// The Amazon Resource Name for the registered user.
    user_arn: []const u8,

    pub const json_field_names = .{
        .allowed_domains = "AllowedDomains",
        .aws_account_id = "AwsAccountId",
        .experience_configuration = "ExperienceConfiguration",
        .session_lifetime_in_minutes = "SessionLifetimeInMinutes",
        .user_arn = "UserArn",
    };
};

pub const GenerateEmbedUrlForRegisteredUserOutput = struct {
    /// The embed URL for the Amazon Quick Sight dashboard, visual, Q search bar,
    /// Generative Q&A experience, or
    /// console.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GenerateEmbedUrlForRegisteredUserInput, options: CallOptions) !GenerateEmbedUrlForRegisteredUserOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GenerateEmbedUrlForRegisteredUserInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/embed-url/registered-user");
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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"UserArn\":");
    try aws.json.writeValue(@TypeOf(input.user_arn), input.user_arn, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GenerateEmbedUrlForRegisteredUserOutput {
    var result: GenerateEmbedUrlForRegisteredUserOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GenerateEmbedUrlForRegisteredUserOutput, body, allocator);
    }
    result.status = @intCast(status);
    _ = headers;

    return result;
}

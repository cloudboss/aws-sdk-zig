const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AnonymousUserEmbeddingExperienceConfiguration = @import("anonymous_user_embedding_experience_configuration.zig").AnonymousUserEmbeddingExperienceConfiguration;
const SessionTag = @import("session_tag.zig").SessionTag;

pub const GenerateEmbedUrlForAnonymousUserInput = struct {
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

    /// The Amazon Resource Names (ARNs) for the Quick Sight resources that the user
    /// is authorized to
    /// access during the lifetime of the session.
    ///
    /// If you choose `Dashboard` embedding experience, pass the list of dashboard
    /// ARNs in the account that you want the user to be able to view.
    ///
    /// If you want to make changes to the theme of your embedded content, pass a
    /// list of
    /// theme ARNs that the anonymous users need access to.
    ///
    /// Currently, you can pass up to 25 theme ARNs in each API call.
    authorized_resource_arns: []const []const u8,

    /// The ID for the Amazon Web Services account that contains the dashboard that
    /// you're
    /// embedding.
    aws_account_id: []const u8,

    /// The configuration of the experience that you are embedding.
    experience_configuration: AnonymousUserEmbeddingExperienceConfiguration,

    /// The Amazon Quick Sight namespace that the anonymous user virtually belongs
    /// to. If you
    /// are not using an Amazon Quick custom namespace, set this to
    /// `default`.
    namespace: []const u8,

    /// How many minutes the session is valid. The session lifetime must be in
    /// [15-600]
    /// minutes range.
    session_lifetime_in_minutes: ?i64 = null,

    /// Session tags are user-specified strings that identify a session in your
    /// application. You can use these tags to implement row-level security (RLS)
    /// controls.
    /// Before you use the `SessionTags` parameter, make sure that you have
    /// configured the relevant datasets using the
    /// `DataSet$RowLevelPermissionTagConfiguration` parameter
    /// so that session tags can be used to provide row-level security.
    ///
    /// When using `SessionTags` in `GenerateEmbedUrlForAnonymousUser`,
    ///
    /// * Treat `SessionTags` as security credentials. Do not expose `SessionTags`
    ///   to end users or client-side code.
    ///
    /// * Implement server-side controls. Ensure that `SessionTags` are set
    ///   exclusively by your trusted backend services, not by parameters that end
    ///   users can modify.
    ///
    /// * Protect `SessionTags` from enumeration. Ensure that users in one tenant
    ///   cannot discover or guess sessionTag values belonging to other tenants.
    ///
    /// * Review your architecture. If downstream customers or partners are allowed
    ///   to call the `GenerateEmbedUrlForAnonymousUser` API directly,
    /// evaluate whether those parties could specify sessionTag values for tenants
    /// they should not access.
    ///
    /// Besides, these are not the tags used for the Amazon Web Services resource
    /// tagging feature.
    /// For more information, see [Using Row-Level Security (RLS) with
    /// Tags](https://docs.aws.amazon.com/quicksight/latest/user/quicksight-dev-rls-tags.html) in the *Amazon Quick User Guide*.
    session_tags: ?[]const SessionTag = null,

    pub const json_field_names = .{
        .allowed_domains = "AllowedDomains",
        .authorized_resource_arns = "AuthorizedResourceArns",
        .aws_account_id = "AwsAccountId",
        .experience_configuration = "ExperienceConfiguration",
        .namespace = "Namespace",
        .session_lifetime_in_minutes = "SessionLifetimeInMinutes",
        .session_tags = "SessionTags",
    };
};

pub const GenerateEmbedUrlForAnonymousUserOutput = struct {
    /// The Amazon Resource Name (ARN) to use for the anonymous Amazon Quick
    /// user.
    anonymous_user_arn: []const u8,

    /// The embed URL for the dashboard.
    embed_url: []const u8,

    /// The Amazon Web Services request ID for this operation.
    request_id: []const u8,

    /// The HTTP status of the request.
    status: ?i32 = null,

    pub const json_field_names = .{
        .anonymous_user_arn = "AnonymousUserArn",
        .embed_url = "EmbedUrl",
        .request_id = "RequestId",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GenerateEmbedUrlForAnonymousUserInput, options: CallOptions) !GenerateEmbedUrlForAnonymousUserOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GenerateEmbedUrlForAnonymousUserInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/embed-url/anonymous-user");
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
    try body_buf.appendSlice(allocator, "\"AuthorizedResourceArns\":");
    try aws.json.writeValue(@TypeOf(input.authorized_resource_arns), input.authorized_resource_arns, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ExperienceConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.experience_configuration), input.experience_configuration, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Namespace\":");
    try aws.json.writeValue(@TypeOf(input.namespace), input.namespace, allocator, &body_buf);
    has_prev = true;
    if (input.session_lifetime_in_minutes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SessionLifetimeInMinutes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.session_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SessionTags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GenerateEmbedUrlForAnonymousUserOutput {
    var result: GenerateEmbedUrlForAnonymousUserOutput = try aws.json.parseJsonObject(
        GenerateEmbedUrlForAnonymousUserOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    result.status = @intCast(status);
    _ = headers;

    return result;
}

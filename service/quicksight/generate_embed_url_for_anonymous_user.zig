const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
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
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "quicksight");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GenerateEmbedUrlForAnonymousUserInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/embed-url/anonymous-user");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
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

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GenerateEmbedUrlForAnonymousUserOutput {
    var result: GenerateEmbedUrlForAnonymousUserOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GenerateEmbedUrlForAnonymousUserOutput, body, allocator);
    }
    result.status = @intCast(status);
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
    if (std.mem.eql(u8, error_code, "ConcurrentUpdatingException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_updating_exception = .{
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
    if (std.mem.eql(u8, error_code, "CustomerManagedKeyUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .customer_managed_key_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DomainNotWhitelistedException")) {
        return .{ .arena = arena, .kind = .{ .domain_not_whitelisted_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IdentityTypeNotSupportedException")) {
        return .{ .arena = arena, .kind = .{ .identity_type_not_supported_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalFailureException")) {
        return .{ .arena = arena, .kind = .{ .internal_failure_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidDataSetParameterValueException")) {
        return .{ .arena = arena, .kind = .{ .invalid_data_set_parameter_value_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterValueException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_value_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PreconditionNotMetException")) {
        return .{ .arena = arena, .kind = .{ .precondition_not_met_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "QuickSightUserNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .quick_sight_user_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_exists_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .resource_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SessionLifetimeInMinutesInvalidException")) {
        return .{ .arena = arena, .kind = .{ .session_lifetime_in_minutes_invalid_exception = .{
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
    if (std.mem.eql(u8, error_code, "UnsupportedPricingPlanException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_pricing_plan_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedUserEditionException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_user_edition_exception = .{
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

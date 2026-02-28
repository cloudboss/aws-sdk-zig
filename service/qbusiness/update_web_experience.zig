const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const WebExperienceAuthConfiguration = @import("web_experience_auth_configuration.zig").WebExperienceAuthConfiguration;
const BrowserExtensionConfiguration = @import("browser_extension_configuration.zig").BrowserExtensionConfiguration;
const CustomizationConfiguration = @import("customization_configuration.zig").CustomizationConfiguration;
const IdentityProviderConfiguration = @import("identity_provider_configuration.zig").IdentityProviderConfiguration;
const WebExperienceSamplePromptsControlMode = @import("web_experience_sample_prompts_control_mode.zig").WebExperienceSamplePromptsControlMode;

pub const UpdateWebExperienceInput = struct {
    /// The identifier of the Amazon Q Business application attached to the web
    /// experience.
    application_id: []const u8,

    /// The authentication configuration of the Amazon Q Business web experience.
    authentication_configuration: ?WebExperienceAuthConfiguration = null,

    /// The browser extension configuration for an Amazon Q Business web experience.
    ///
    /// For Amazon Q Business application using external OIDC-compliant identity
    /// providers (IdPs). The IdP administrator must add the browser extension
    /// sign-in redirect URLs to the IdP application. For more information, see
    /// [Configure external OIDC identity provider for your browser
    /// extensions.](https://docs.aws.amazon.com/amazonq/latest/qbusiness-ug/browser-extensions.html).
    browser_extension_configuration: ?BrowserExtensionConfiguration = null,

    /// Updates the custom logo, favicon, font, and color used in the Amazon Q web
    /// experience.
    customization_configuration: ?CustomizationConfiguration = null,

    /// Information about the identity provider (IdP) used to authenticate end users
    /// of an Amazon Q Business web experience.
    identity_provider_configuration: ?IdentityProviderConfiguration = null,

    /// Updates the website domain origins that are allowed to embed the Amazon Q
    /// Business web experience. The *domain origin* refers to the *base URL* for
    /// accessing a website including the protocol (`http/https`), the domain name,
    /// and the port number (if specified).
    ///
    /// * Any values except `null` submitted as part of this update will replace all
    ///   previous values.
    /// * You must only submit a *base URL* and not a full path. For example,
    ///   `https://docs.aws.amazon.com`.
    origins: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) of the role with permission to access the
    /// Amazon Q Business web experience and required resources.
    role_arn: ?[]const u8 = null,

    /// Determines whether sample prompts are enabled in the web experience for an
    /// end user.
    sample_prompts_control_mode: ?WebExperienceSamplePromptsControlMode = null,

    /// The subtitle of the Amazon Q Business web experience.
    subtitle: ?[]const u8 = null,

    /// The title of the Amazon Q Business web experience.
    title: ?[]const u8 = null,

    /// The identifier of the Amazon Q Business web experience.
    web_experience_id: []const u8,

    /// A customized welcome message for an end user in an Amazon Q Business web
    /// experience.
    welcome_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .authentication_configuration = "authenticationConfiguration",
        .browser_extension_configuration = "browserExtensionConfiguration",
        .customization_configuration = "customizationConfiguration",
        .identity_provider_configuration = "identityProviderConfiguration",
        .origins = "origins",
        .role_arn = "roleArn",
        .sample_prompts_control_mode = "samplePromptsControlMode",
        .subtitle = "subtitle",
        .title = "title",
        .web_experience_id = "webExperienceId",
        .welcome_message = "welcomeMessage",
    };
};

pub const UpdateWebExperienceOutput = struct {
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateWebExperienceInput, options: Options) !UpdateWebExperienceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "qbusiness");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateWebExperienceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("qbusiness", "QBusiness", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/applications/");
    try path_buf.appendSlice(alloc, input.application_id);
    try path_buf.appendSlice(alloc, "/experiences/");
    try path_buf.appendSlice(alloc, input.web_experience_id);
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.authentication_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"authenticationConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.browser_extension_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"browserExtensionConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.customization_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"customizationConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.identity_provider_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"identityProviderConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.origins) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"origins\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"roleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.sample_prompts_control_mode) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"samplePromptsControlMode\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.subtitle) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"subtitle\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.title) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"title\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.welcome_message) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"welcomeMessage\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateWebExperienceOutput {
    _ = alloc;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateWebExperienceOutput = .{};

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
    if (std.mem.eql(u8, error_code, "ExternalResourceException")) {
        return .{ .arena = arena, .kind = .{ .external_resource_exception = .{
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
    if (std.mem.eql(u8, error_code, "LicenseNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .license_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MediaTooLargeException")) {
        return .{ .arena = arena, .kind = .{ .media_too_large_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
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

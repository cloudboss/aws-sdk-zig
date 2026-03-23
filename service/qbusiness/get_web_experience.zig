const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const WebExperienceAuthConfiguration = @import("web_experience_auth_configuration.zig").WebExperienceAuthConfiguration;
const BrowserExtensionConfiguration = @import("browser_extension_configuration.zig").BrowserExtensionConfiguration;
const CustomizationConfiguration = @import("customization_configuration.zig").CustomizationConfiguration;
const ErrorDetail = @import("error_detail.zig").ErrorDetail;
const IdentityProviderConfiguration = @import("identity_provider_configuration.zig").IdentityProviderConfiguration;
const WebExperienceSamplePromptsControlMode = @import("web_experience_sample_prompts_control_mode.zig").WebExperienceSamplePromptsControlMode;
const WebExperienceStatus = @import("web_experience_status.zig").WebExperienceStatus;

pub const GetWebExperienceInput = struct {
    /// The identifier of the Amazon Q Business application linked to the web
    /// experience.
    application_id: []const u8,

    /// The identifier of the Amazon Q Business web experience.
    web_experience_id: []const u8,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .web_experience_id = "webExperienceId",
    };
};

pub const GetWebExperienceOutput = struct {
    /// The identifier of the Amazon Q Business application linked to the web
    /// experience.
    application_id: ?[]const u8 = null,

    /// The authentication configuration information for your Amazon Q Business web
    /// experience.
    authentication_configuration: ?WebExperienceAuthConfiguration = null,

    /// The browser extension configuration for an Amazon Q Business web experience.
    browser_extension_configuration: ?BrowserExtensionConfiguration = null,

    /// The Unix timestamp when the Amazon Q Business web experience was last
    /// created.
    created_at: ?i64 = null,

    /// Gets the custom logo, favicon, font, and color used in the Amazon Q web
    /// experience.
    customization_configuration: ?CustomizationConfiguration = null,

    /// The endpoint of your Amazon Q Business web experience.
    default_endpoint: ?[]const u8 = null,

    /// When the `Status` field value is `FAILED`, the `ErrorMessage` field contains
    /// a description of the error that caused the data source connector to fail.
    @"error": ?ErrorDetail = null,

    /// Information about the identity provider (IdP) used to authenticate end users
    /// of an Amazon Q Business web experience.
    identity_provider_configuration: ?IdentityProviderConfiguration = null,

    /// Gets the website domain origins that are allowed to embed the Amazon Q
    /// Business web experience. The *domain origin* refers to the base URL for
    /// accessing a website including the protocol (`http/https`), the domain name,
    /// and the port number (if specified).
    origins: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) of the service role attached to your web
    /// experience.
    role_arn: ?[]const u8 = null,

    /// Determines whether sample prompts are enabled in the web experience for an
    /// end user.
    sample_prompts_control_mode: ?WebExperienceSamplePromptsControlMode = null,

    /// The current status of the Amazon Q Business web experience. When the
    /// `Status` field value is `FAILED`, the `ErrorMessage` field contains a
    /// description of the error that caused the data source connector to fail.
    status: ?WebExperienceStatus = null,

    /// The subtitle for your Amazon Q Business web experience.
    subtitle: ?[]const u8 = null,

    /// The title for your Amazon Q Business web experience.
    title: ?[]const u8 = null,

    /// The Unix timestamp when the Amazon Q Business web experience was last
    /// updated.
    updated_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the role with the permission to access the
    /// Amazon Q Business web experience and required resources.
    web_experience_arn: ?[]const u8 = null,

    /// The identifier of the Amazon Q Business web experience.
    web_experience_id: ?[]const u8 = null,

    /// The customized welcome message for end users of an Amazon Q Business web
    /// experience.
    welcome_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .authentication_configuration = "authenticationConfiguration",
        .browser_extension_configuration = "browserExtensionConfiguration",
        .created_at = "createdAt",
        .customization_configuration = "customizationConfiguration",
        .default_endpoint = "defaultEndpoint",
        .@"error" = "error",
        .identity_provider_configuration = "identityProviderConfiguration",
        .origins = "origins",
        .role_arn = "roleArn",
        .sample_prompts_control_mode = "samplePromptsControlMode",
        .status = "status",
        .subtitle = "subtitle",
        .title = "title",
        .updated_at = "updatedAt",
        .web_experience_arn = "webExperienceArn",
        .web_experience_id = "webExperienceId",
        .welcome_message = "welcomeMessage",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetWebExperienceInput, options: CallOptions) !GetWebExperienceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "qbusiness");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetWebExperienceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("qbusiness", "QBusiness", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/experiences/");
    try path_buf.appendSlice(allocator, input.web_experience_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetWebExperienceOutput {
    var result: GetWebExperienceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetWebExperienceOutput, body, allocator);
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

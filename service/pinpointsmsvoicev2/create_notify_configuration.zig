const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const NumberCapability = @import("number_capability.zig").NumberCapability;
const Tag = @import("tag.zig").Tag;
const NotifyConfigurationUseCase = @import("notify_configuration_use_case.zig").NotifyConfigurationUseCase;
const NotifyConfigurationStatus = @import("notify_configuration_status.zig").NotifyConfigurationStatus;
const NotifyConfigurationTier = @import("notify_configuration_tier.zig").NotifyConfigurationTier;
const TierUpgradeStatus = @import("tier_upgrade_status.zig").TierUpgradeStatus;

pub const CreateNotifyConfigurationInput = struct {
    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the request. If you don't specify a client token, a randomly generated
    /// token is used for the request to ensure idempotency.
    client_token: ?[]const u8 = null,

    /// The default template identifier to associate with the notify configuration.
    /// If specified, this template is used when sending messages without an
    /// explicit template identifier.
    default_template_id: ?[]const u8 = null,

    /// By default this is set to false. When set to true the notify configuration
    /// can't be deleted. You can change this value using the
    /// UpdateNotifyConfiguration action.
    deletion_protection_enabled: ?bool = null,

    /// The display name to associate with the notify configuration.
    display_name: []const u8,

    /// An array of channels to enable for the notify configuration. Supported
    /// values include `SMS` and `VOICE`.
    enabled_channels: []const NumberCapability,

    /// An array of two-character ISO country codes, in ISO 3166-1 alpha-2 format,
    /// that are enabled for the notify configuration.
    enabled_countries: ?[]const []const u8 = null,

    /// The identifier of the pool to associate with the notify configuration.
    pool_id: ?[]const u8 = null,

    /// An array of tags (key and value pairs) associated with the notify
    /// configuration.
    tags: ?[]const Tag = null,

    /// The use case for the notify configuration.
    use_case: NotifyConfigurationUseCase,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .default_template_id = "DefaultTemplateId",
        .deletion_protection_enabled = "DeletionProtectionEnabled",
        .display_name = "DisplayName",
        .enabled_channels = "EnabledChannels",
        .enabled_countries = "EnabledCountries",
        .pool_id = "PoolId",
        .tags = "Tags",
        .use_case = "UseCase",
    };
};

pub const CreateNotifyConfigurationOutput = struct {
    /// The time when the notify configuration was created, in [UNIX epoch
    /// time](https://www.epochconverter.com/) format.
    created_timestamp: i64,

    /// The default template identifier associated with the notify configuration.
    default_template_id: ?[]const u8 = null,

    /// When set to true deletion protection is enabled. By default this is set to
    /// false.
    deletion_protection_enabled: ?bool = null,

    /// The display name associated with the notify configuration.
    display_name: []const u8,

    /// An array of channels enabled for the notify configuration. Supported values
    /// include `SMS` and `VOICE`.
    enabled_channels: ?[]const NumberCapability = null,

    /// An array of two-character ISO country codes, in ISO 3166-1 alpha-2 format,
    /// that are enabled for the notify configuration.
    enabled_countries: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) for the notify configuration.
    notify_configuration_arn: []const u8,

    /// The unique identifier for the notify configuration.
    notify_configuration_id: []const u8,

    /// The identifier of the pool associated with the notify configuration.
    pool_id: ?[]const u8 = null,

    /// The reason the notify configuration was rejected, if applicable.
    rejection_reason: ?[]const u8 = null,

    /// The current status of the notify configuration.
    status: NotifyConfigurationStatus,

    /// An array of tags (key and value pairs) associated with the notify
    /// configuration.
    tags: ?[]const Tag = null,

    /// The tier of the notify configuration.
    tier: NotifyConfigurationTier,

    /// The tier upgrade status of the notify configuration.
    tier_upgrade_status: TierUpgradeStatus,

    /// The use case for the notify configuration.
    use_case: NotifyConfigurationUseCase,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .default_template_id = "DefaultTemplateId",
        .deletion_protection_enabled = "DeletionProtectionEnabled",
        .display_name = "DisplayName",
        .enabled_channels = "EnabledChannels",
        .enabled_countries = "EnabledCountries",
        .notify_configuration_arn = "NotifyConfigurationArn",
        .notify_configuration_id = "NotifyConfigurationId",
        .pool_id = "PoolId",
        .rejection_reason = "RejectionReason",
        .status = "Status",
        .tags = "Tags",
        .tier = "Tier",
        .tier_upgrade_status = "TierUpgradeStatus",
        .use_case = "UseCase",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateNotifyConfigurationInput, options: CallOptions) !CreateNotifyConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sms-voice", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateNotifyConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sms-voice", "Pinpoint SMS Voice V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "PinpointSMSVoiceV2.CreateNotifyConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateNotifyConfigurationOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateNotifyConfigurationOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
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
        const parsed_error: ?errors.AccessDeniedException = aws.json.parseJsonObject(errors.AccessDeniedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .access_denied_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        const parsed_error: ?errors.ConflictException = aws.json.parseJsonObject(errors.ConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        const parsed_error: ?errors.InternalServerException = aws.json.parseJsonObject(errors.InternalServerException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_server_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        const parsed_error: ?errors.ResourceNotFoundException = aws.json.parseJsonObject(errors.ResourceNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        const parsed_error: ?errors.ServiceQuotaExceededException = aws.json.parseJsonObject(errors.ServiceQuotaExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        const parsed_error: ?errors.ThrottlingException = aws.json.parseJsonObject(errors.ThrottlingException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .throttling_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        const parsed_error: ?errors.ValidationException = aws.json.parseJsonObject(errors.ValidationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .validation_exception = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}

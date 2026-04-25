const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const NumberCapability = @import("number_capability.zig").NumberCapability;
const NotifyConfigurationStatus = @import("notify_configuration_status.zig").NotifyConfigurationStatus;
const NotifyConfigurationTier = @import("notify_configuration_tier.zig").NotifyConfigurationTier;
const TierUpgradeStatus = @import("tier_upgrade_status.zig").TierUpgradeStatus;
const NotifyConfigurationUseCase = @import("notify_configuration_use_case.zig").NotifyConfigurationUseCase;

pub const UpdateNotifyConfigurationInput = struct {
    /// The template ID to set as the default, or the special value
    /// UNSET_DEFAULT_TEMPLATE to clear the current default template.
    default_template_id: ?[]const u8 = null,

    /// When set to true the notify configuration can't be deleted.
    deletion_protection_enabled: ?bool = null,

    /// An array of channels to enable for the notify configuration. Supported
    /// values include `SMS` and `VOICE`.
    enabled_channels: ?[]const NumberCapability = null,

    /// An array of two-character ISO country codes, in ISO 3166-1 alpha-2 format,
    /// that are enabled for the notify configuration.
    enabled_countries: ?[]const []const u8 = null,

    /// The identifier of the notify configuration to update. The
    /// NotifyConfigurationId can be found using the DescribeNotifyConfigurations
    /// operation.
    notify_configuration_id: []const u8,

    /// The pool ID or ARN to associate, or the special value
    /// UNSET_DEFAULT_POOL_FOR_NOTIFY to clear the current default pool.
    pool_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .default_template_id = "DefaultTemplateId",
        .deletion_protection_enabled = "DeletionProtectionEnabled",
        .enabled_channels = "EnabledChannels",
        .enabled_countries = "EnabledCountries",
        .notify_configuration_id = "NotifyConfigurationId",
        .pool_id = "PoolId",
    };
};

pub const UpdateNotifyConfigurationOutput = struct {
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
        .tier = "Tier",
        .tier_upgrade_status = "TierUpgradeStatus",
        .use_case = "UseCase",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateNotifyConfigurationInput, options: CallOptions) !UpdateNotifyConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sms-voice");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateNotifyConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sms-voice", "Pinpoint SMS Voice V2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "PinpointSMSVoiceV2.UpdateNotifyConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateNotifyConfigurationOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateNotifyConfigurationOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
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

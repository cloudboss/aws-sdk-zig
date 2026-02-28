const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AutoEnableMode = @import("auto_enable_mode.zig").AutoEnableMode;
const AutomatedDiscoveryStatus = @import("automated_discovery_status.zig").AutomatedDiscoveryStatus;

pub const GetAutomatedDiscoveryConfigurationInput = struct {
};

pub const GetAutomatedDiscoveryConfigurationOutput = struct {
    /// Specifies whether automated sensitive data discovery is enabled
    /// automatically for accounts in the organization. Possible values are: ALL,
    /// enable it for all existing accounts and new member accounts; NEW, enable it
    /// only for new member accounts; and, NONE, don't enable it for any accounts.
    auto_enable_organization_members: ?AutoEnableMode = null,

    /// The unique identifier for the classification scope that's used when
    /// performing automated sensitive data discovery. The classification scope
    /// specifies S3 buckets to exclude from analyses.
    classification_scope_id: ?[]const u8 = null,

    /// The date and time, in UTC and extended ISO 8601 format, when automated
    /// sensitive data discovery was most recently disabled. This value is null if
    /// automated sensitive data discovery is currently enabled.
    disabled_at: ?i64 = null,

    /// The date and time, in UTC and extended ISO 8601 format, when automated
    /// sensitive data discovery was initially enabled. This value is null if
    /// automated sensitive data discovery has never been enabled.
    first_enabled_at: ?i64 = null,

    /// The date and time, in UTC and extended ISO 8601 format, when the
    /// configuration settings or status of automated sensitive data discovery was
    /// most recently changed.
    last_updated_at: ?i64 = null,

    /// The unique identifier for the sensitivity inspection template that's used
    /// when performing automated sensitive data discovery. The template specifies
    /// which allow lists, custom data identifiers, and managed data identifiers to
    /// use when analyzing data.
    sensitivity_inspection_template_id: ?[]const u8 = null,

    /// The current status of automated sensitive data discovery for the
    /// organization or account. Possible values are: ENABLED, use the specified
    /// settings to perform automated sensitive data discovery activities; and,
    /// DISABLED, don't perform automated sensitive data discovery activities.
    status: ?AutomatedDiscoveryStatus = null,

    pub const json_field_names = .{
        .auto_enable_organization_members = "autoEnableOrganizationMembers",
        .classification_scope_id = "classificationScopeId",
        .disabled_at = "disabledAt",
        .first_enabled_at = "firstEnabledAt",
        .last_updated_at = "lastUpdatedAt",
        .sensitivity_inspection_template_id = "sensitivityInspectionTemplateId",
        .status = "status",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAutomatedDiscoveryConfigurationInput, options: Options) !GetAutomatedDiscoveryConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "macie2");

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

fn serializeRequest(alloc: std.mem.Allocator, input: GetAutomatedDiscoveryConfigurationInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("macie2", "Macie2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/automated-discovery/configuration";

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetAutomatedDiscoveryConfigurationOutput {
    var result: GetAutomatedDiscoveryConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetAutomatedDiscoveryConfigurationOutput, body, alloc);
    }
    _ = status;
    _ = headers;

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
    if (std.mem.eql(u8, error_code, "UnprocessableEntityException")) {
        return .{ .arena = arena, .kind = .{ .unprocessable_entity_exception = .{
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

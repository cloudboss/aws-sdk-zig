const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AppType = @import("app_type.zig").AppType;
const FeatureStatus = @import("feature_status.zig").FeatureStatus;
const ResourceSpec = @import("resource_spec.zig").ResourceSpec;
const AppStatus = @import("app_status.zig").AppStatus;

pub const DescribeAppInput = struct {
    /// The name of the app.
    app_name: []const u8,

    /// The type of app.
    app_type: AppType,

    /// The domain ID.
    domain_id: []const u8,

    /// The name of the space.
    space_name: ?[]const u8 = null,

    /// The user profile name. If this value is not set, then `SpaceName` must be
    /// set.
    user_profile_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_name = "AppName",
        .app_type = "AppType",
        .domain_id = "DomainId",
        .space_name = "SpaceName",
        .user_profile_name = "UserProfileName",
    };
};

pub const DescribeAppOutput = struct {
    /// The Amazon Resource Name (ARN) of the app.
    app_arn: ?[]const u8 = null,

    /// The name of the app.
    app_name: ?[]const u8 = null,

    /// The type of app.
    app_type: ?AppType = null,

    /// The lifecycle configuration that runs before the default lifecycle
    /// configuration
    built_in_lifecycle_config_arn: ?[]const u8 = null,

    /// The creation time of the application.
    ///
    /// After an application has been shut down for 24 hours, SageMaker AI deletes
    /// all metadata for the application. To be considered an update and retain
    /// application metadata, applications must be restarted within 24 hours after
    /// the previous application has been shut down. After this time window,
    /// creation of an application is considered a new application rather than an
    /// update of the previous application.
    creation_time: ?i64 = null,

    /// The domain ID.
    domain_id: ?[]const u8 = null,

    /// The effective status of Trusted Identity Propagation (TIP) for this
    /// application. When enabled, user identities from IAM Identity Center are
    /// being propagated through the application to TIP enabled Amazon Web Services
    /// services. When disabled, standard IAM role-based access is used.
    effective_trusted_identity_propagation_status: ?FeatureStatus = null,

    /// The failure reason.
    failure_reason: ?[]const u8 = null,

    /// The timestamp of the last health check.
    last_health_check_timestamp: ?i64 = null,

    /// The timestamp of the last user's activity. `LastUserActivityTimestamp` is
    /// also updated when SageMaker AI performs health checks without user activity.
    /// As a result, this value is set to the same value as
    /// `LastHealthCheckTimestamp`.
    last_user_activity_timestamp: ?i64 = null,

    /// Indicates whether the application is launched in recovery mode.
    recovery_mode: ?bool = null,

    /// The instance type and the Amazon Resource Name (ARN) of the SageMaker AI
    /// image created on the instance.
    resource_spec: ?ResourceSpec = null,

    /// The name of the space. If this value is not set, then `UserProfileName` must
    /// be set.
    space_name: ?[]const u8 = null,

    /// The status.
    status: ?AppStatus = null,

    /// The user profile name.
    user_profile_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_arn = "AppArn",
        .app_name = "AppName",
        .app_type = "AppType",
        .built_in_lifecycle_config_arn = "BuiltInLifecycleConfigArn",
        .creation_time = "CreationTime",
        .domain_id = "DomainId",
        .effective_trusted_identity_propagation_status = "EffectiveTrustedIdentityPropagationStatus",
        .failure_reason = "FailureReason",
        .last_health_check_timestamp = "LastHealthCheckTimestamp",
        .last_user_activity_timestamp = "LastUserActivityTimestamp",
        .recovery_mode = "RecoveryMode",
        .resource_spec = "ResourceSpec",
        .space_name = "SpaceName",
        .status = "Status",
        .user_profile_name = "UserProfileName",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAppInput, options: Options) !DescribeAppOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sagemaker");

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

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeAppInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker", "SageMaker", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "SageMaker.DescribeApp");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeAppOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeAppOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUse")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found = .{
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

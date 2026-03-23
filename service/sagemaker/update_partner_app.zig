const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const PartnerAppConfig = @import("partner_app_config.zig").PartnerAppConfig;
const PartnerAppMaintenanceConfig = @import("partner_app_maintenance_config.zig").PartnerAppMaintenanceConfig;
const Tag = @import("tag.zig").Tag;

pub const UpdatePartnerAppInput = struct {
    /// Configuration settings for the SageMaker Partner AI App.
    application_config: ?PartnerAppConfig = null,

    /// The semantic version to upgrade the SageMaker Partner AI App to. Must be the
    /// same semantic version returned in the `AvailableUpgrade` field from
    /// `DescribePartnerApp`. Version skipping and downgrades are not supported.
    app_version: ?[]const u8 = null,

    /// The ARN of the SageMaker Partner AI App to update.
    arn: []const u8,

    /// A unique token that guarantees that the call to this API is idempotent.
    client_token: ?[]const u8 = null,

    /// When set to `TRUE`, the SageMaker Partner AI App is automatically upgraded
    /// to the latest minor version during the next scheduled maintenance window, if
    /// one is available.
    enable_auto_minor_version_upgrade: ?bool = null,

    /// When set to `TRUE`, the SageMaker Partner AI App sets the Amazon Web
    /// Services IAM session name or the authenticated IAM user as the identity of
    /// the SageMaker Partner AI App user.
    enable_iam_session_based_identity: ?bool = null,

    /// Maintenance configuration settings for the SageMaker Partner AI App.
    maintenance_config: ?PartnerAppMaintenanceConfig = null,

    /// Each tag consists of a key and an optional value. Tag keys must be unique
    /// per resource.
    tags: ?[]const Tag = null,

    /// Indicates the instance type and size of the cluster attached to the
    /// SageMaker Partner AI App.
    tier: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_config = "ApplicationConfig",
        .app_version = "AppVersion",
        .arn = "Arn",
        .client_token = "ClientToken",
        .enable_auto_minor_version_upgrade = "EnableAutoMinorVersionUpgrade",
        .enable_iam_session_based_identity = "EnableIamSessionBasedIdentity",
        .maintenance_config = "MaintenanceConfig",
        .tags = "Tags",
        .tier = "Tier",
    };
};

pub const UpdatePartnerAppOutput = struct {
    /// The ARN of the SageMaker Partner AI App that was updated.
    arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdatePartnerAppInput, options: CallOptions) !UpdatePartnerAppOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sagemaker");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdatePartnerAppInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

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
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.UpdatePartnerApp");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdatePartnerAppOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdatePartnerAppOutput, body, allocator);
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

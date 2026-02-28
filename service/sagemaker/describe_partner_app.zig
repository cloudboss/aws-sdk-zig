const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const PartnerAppConfig = @import("partner_app_config.zig").PartnerAppConfig;
const PartnerAppAuthType = @import("partner_app_auth_type.zig").PartnerAppAuthType;
const AvailableUpgrade = @import("available_upgrade.zig").AvailableUpgrade;
const ErrorInfo = @import("error_info.zig").ErrorInfo;
const PartnerAppMaintenanceConfig = @import("partner_app_maintenance_config.zig").PartnerAppMaintenanceConfig;
const PartnerAppStatus = @import("partner_app_status.zig").PartnerAppStatus;
const PartnerAppType = @import("partner_app_type.zig").PartnerAppType;

pub const DescribePartnerAppInput = struct {
    /// The ARN of the SageMaker Partner AI App to describe.
    arn: []const u8,

    /// When set to `TRUE`, the response includes available upgrade information for
    /// the SageMaker Partner AI App. Default is `FALSE`.
    include_available_upgrade: ?bool = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .include_available_upgrade = "IncludeAvailableUpgrade",
    };
};

pub const DescribePartnerAppOutput = struct {
    /// Configuration settings for the SageMaker Partner AI App.
    application_config: ?PartnerAppConfig = null,

    /// The ARN of the SageMaker Partner AI App that was described.
    arn: ?[]const u8 = null,

    /// The authorization type that users use to access the SageMaker Partner AI
    /// App.
    auth_type: ?PartnerAppAuthType = null,

    /// A map of available minor version upgrades for the SageMaker Partner AI App.
    /// The key is the semantic version number, and the value is a list of release
    /// notes for that version. A null value indicates no upgrades are available.
    available_upgrade: ?AvailableUpgrade = null,

    /// The URL of the SageMaker Partner AI App that the Application SDK uses to
    /// support in-app calls for the user.
    base_url: ?[]const u8 = null,

    /// The time that the SageMaker Partner AI App was created.
    creation_time: ?i64 = null,

    /// The end-of-life date for the current version of the SageMaker Partner AI
    /// App.
    current_version_eol_date: ?i64 = null,

    /// Indicates whether the SageMaker Partner AI App is configured for automatic
    /// minor version upgrades during scheduled maintenance windows.
    enable_auto_minor_version_upgrade: ?bool = null,

    /// When set to `TRUE`, the SageMaker Partner AI App sets the Amazon Web
    /// Services IAM session name or the authenticated IAM user as the identity of
    /// the SageMaker Partner AI App user.
    enable_iam_session_based_identity: ?bool = null,

    /// This is an error field object that contains the error code and the reason
    /// for an operation failure.
    @"error": ?ErrorInfo = null,

    /// The ARN of the IAM role associated with the SageMaker Partner AI App.
    execution_role_arn: ?[]const u8 = null,

    /// The Amazon Web Services KMS customer managed key used to encrypt the data at
    /// rest associated with SageMaker Partner AI Apps.
    kms_key_id: ?[]const u8 = null,

    /// The time that the SageMaker Partner AI App was last modified.
    last_modified_time: ?i64 = null,

    /// Maintenance configuration settings for the SageMaker Partner AI App.
    maintenance_config: ?PartnerAppMaintenanceConfig = null,

    /// The name of the SageMaker Partner AI App.
    name: ?[]const u8 = null,

    /// The status of the SageMaker Partner AI App.
    ///
    /// * Creating: SageMaker AI is creating the partner AI app. The partner AI app
    ///   is not available during creation.
    /// * Updating: SageMaker AI is updating the partner AI app. The partner AI app
    ///   is not available when updating.
    /// * Deleting: SageMaker AI is deleting the partner AI app. The partner AI app
    ///   is not available during deletion.
    /// * Available: The partner AI app is provisioned and accessible.
    /// * Failed: The partner AI app is in a failed state and isn't available.
    ///   SageMaker AI is investigating the issue. For further guidance, contact
    ///   Amazon Web Services Support.
    /// * UpdateFailed: The partner AI app couldn't be updated but is available.
    /// * Deleted: The partner AI app is permanently deleted and not available.
    status: ?PartnerAppStatus = null,

    /// The instance type and size of the cluster attached to the SageMaker Partner
    /// AI App.
    tier: ?[]const u8 = null,

    /// The type of SageMaker Partner AI App. Must be one of the following:
    /// `lakera-guard`, `comet`, `deepchecks-llm-evaluation`, or `fiddler`.
    @"type": ?PartnerAppType = null,

    /// The version of the SageMaker Partner AI App.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_config = "ApplicationConfig",
        .arn = "Arn",
        .auth_type = "AuthType",
        .available_upgrade = "AvailableUpgrade",
        .base_url = "BaseUrl",
        .creation_time = "CreationTime",
        .current_version_eol_date = "CurrentVersionEolDate",
        .enable_auto_minor_version_upgrade = "EnableAutoMinorVersionUpgrade",
        .enable_iam_session_based_identity = "EnableIamSessionBasedIdentity",
        .@"error" = "Error",
        .execution_role_arn = "ExecutionRoleArn",
        .kms_key_id = "KmsKeyId",
        .last_modified_time = "LastModifiedTime",
        .maintenance_config = "MaintenanceConfig",
        .name = "Name",
        .status = "Status",
        .tier = "Tier",
        .@"type" = "Type",
        .version = "Version",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribePartnerAppInput, options: Options) !DescribePartnerAppOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: DescribePartnerAppInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "SageMaker.DescribePartnerApp");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribePartnerAppOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribePartnerAppOutput, body, alloc);
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

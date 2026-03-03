const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AppNetworkAccessType = @import("app_network_access_type.zig").AppNetworkAccessType;
const AppSecurityGroupManagement = @import("app_security_group_management.zig").AppSecurityGroupManagement;
const DefaultSpaceSettings = @import("default_space_settings.zig").DefaultSpaceSettings;
const UserSettings = @import("user_settings.zig").UserSettings;
const DomainSettingsForUpdate = @import("domain_settings_for_update.zig").DomainSettingsForUpdate;
const TagPropagation = @import("tag_propagation.zig").TagPropagation;

pub const UpdateDomainInput = struct {
    /// Specifies the VPC used for non-EFS traffic.
    ///
    /// * `PublicInternetOnly` - Non-EFS traffic is through a VPC managed by Amazon
    ///   SageMaker AI, which allows direct internet access.
    /// * `VpcOnly` - All Studio traffic is through the specified VPC and subnets.
    ///
    /// This configuration can only be modified if there are no apps in the
    /// `InService`, `Pending`, or `Deleting` state. The configuration cannot be
    /// updated if
    /// `DomainSettings.RStudioServerProDomainSettings.DomainExecutionRoleArn` is
    /// already set or
    /// `DomainSettings.RStudioServerProDomainSettings.DomainExecutionRoleArn` is
    /// provided as part of the same request.
    app_network_access_type: ?AppNetworkAccessType = null,

    /// The entity that creates and manages the required security groups for
    /// inter-app communication in `VPCOnly` mode. Required when
    /// `CreateDomain.AppNetworkAccessType` is `VPCOnly` and
    /// `DomainSettings.RStudioServerProDomainSettings.DomainExecutionRoleArn` is
    /// provided. If setting up the domain for use with RStudio, this value must be
    /// set to `Service`.
    app_security_group_management: ?AppSecurityGroupManagement = null,

    /// The default settings for shared spaces that users create in the domain.
    default_space_settings: ?DefaultSpaceSettings = null,

    /// A collection of settings.
    default_user_settings: ?UserSettings = null,

    /// The ID of the domain to be updated.
    domain_id: []const u8,

    /// A collection of `DomainSettings` configuration values to update.
    domain_settings_for_update: ?DomainSettingsForUpdate = null,

    /// The VPC subnets that Studio uses for communication.
    ///
    /// If removing subnets, ensure there are no apps in the `InService`, `Pending`,
    /// or `Deleting` state.
    subnet_ids: ?[]const []const u8 = null,

    /// Indicates whether custom tag propagation is supported for the domain.
    /// Defaults to `DISABLED`.
    tag_propagation: ?TagPropagation = null,

    /// The identifier for the VPC used by the domain for network communication. Use
    /// this field only when adding VPC configuration to a SageMaker AI domain used
    /// in Amazon SageMaker Unified Studio that was created without VPC settings.
    /// SageMaker AI doesn't automatically apply VPC updates to existing
    /// applications. Stop and restart your applications to apply the changes.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_network_access_type = "AppNetworkAccessType",
        .app_security_group_management = "AppSecurityGroupManagement",
        .default_space_settings = "DefaultSpaceSettings",
        .default_user_settings = "DefaultUserSettings",
        .domain_id = "DomainId",
        .domain_settings_for_update = "DomainSettingsForUpdate",
        .subnet_ids = "SubnetIds",
        .tag_propagation = "TagPropagation",
        .vpc_id = "VpcId",
    };
};

pub const UpdateDomainOutput = struct {
    /// The Amazon Resource Name (ARN) of the domain.
    domain_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain_arn = "DomainArn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDomainInput, options: Options) !UpdateDomainOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDomainInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker", "SageMaker", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.UpdateDomain");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDomainOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateDomainOutput, body, allocator);
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

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AccountAccessType = @import("account_access_type.zig").AccountAccessType;
const AuthenticationProviderTypes = @import("authentication_provider_types.zig").AuthenticationProviderTypes;
const NetworkAccessConfiguration = @import("network_access_configuration.zig").NetworkAccessConfiguration;
const PermissionType = @import("permission_type.zig").PermissionType;
const VpcConfiguration = @import("vpc_configuration.zig").VpcConfiguration;
const DataSourceType = @import("data_source_type.zig").DataSourceType;
const NotificationDestinationType = @import("notification_destination_type.zig").NotificationDestinationType;
const WorkspaceDescription = @import("workspace_description.zig").WorkspaceDescription;

pub const CreateWorkspaceInput = struct {
    /// Specifies whether the workspace can access Amazon Web Services resources in
    /// this
    /// Amazon Web Services account only, or whether it can also access Amazon Web
    /// Services
    /// resources in other accounts in the same organization. If you specify
    /// `ORGANIZATION`, you must specify which organizational units the workspace
    /// can access in the `workspaceOrganizationalUnits` parameter.
    account_access_type: AccountAccessType,

    /// Specifies whether this workspace uses SAML 2.0, IAM Identity Center, or both
    /// to
    /// authenticate users for using the Grafana console within a workspace. For
    /// more
    /// information, see [User authentication in
    /// Amazon Managed
    /// Grafana](https://docs.aws.amazon.com/grafana/latest/userguide/authentication-in-AMG.html).
    authentication_providers: []const AuthenticationProviderTypes,

    /// A unique, case-sensitive, user-provided identifier to ensure the idempotency
    /// of the
    /// request.
    client_token: ?[]const u8 = null,

    /// The configuration string for the workspace that you create. For more
    /// information about
    /// the format and configuration options available, see [Working in your Grafana
    /// workspace](https://docs.aws.amazon.com/grafana/latest/userguide/AMG-configure-workspace.html).
    configuration: ?[]const u8 = null,

    /// Specifies the version of Grafana to support in the new workspace. If not
    /// specified,
    /// defaults to the latest version (for example, 10.4).
    ///
    /// To get a list of supported versions, use the `ListVersions`
    /// operation.
    grafana_version: ?[]const u8 = null,

    /// Configuration for network access to your workspace.
    ///
    /// When this is configured, only listed IP addresses and VPC endpoints will be
    /// able to
    /// access your workspace. Standard Grafana authentication and authorization
    /// will still be
    /// required.
    ///
    /// If this is not configured, or is removed, then all IP addresses and VPC
    /// endpoints will
    /// be allowed. Standard Grafana authentication and authorization will still be
    /// required.
    network_access_control: ?NetworkAccessConfiguration = null,

    /// The name of an IAM role that already exists to use with Organizations to
    /// access Amazon Web Services data sources and notification channels in other
    /// accounts
    /// in an organization.
    organization_role_name: ?[]const u8 = null,

    /// When creating a workspace through the Amazon Web Services API, CLI or Amazon
    /// Web Services CloudFormation, you must manage IAM roles and provision the
    /// permissions that the workspace needs to use Amazon Web Services data sources
    /// and
    /// notification channels.
    ///
    /// You must also specify a `workspaceRoleArn` for a role that you will
    /// manage for the workspace to use when accessing those datasources and
    /// notification
    /// channels.
    ///
    /// The ability for Amazon Managed Grafana to create and update IAM roles on
    /// behalf of the user is supported only in the Amazon Managed Grafana console,
    /// where this value
    /// may be set to `SERVICE_MANAGED`.
    ///
    /// Use only the `CUSTOMER_MANAGED` permission type when creating a
    /// workspace with the API, CLI or Amazon Web Services CloudFormation.
    ///
    /// For more information, see [Amazon Managed Grafana
    /// permissions and policies for Amazon Web Services data sources and
    /// notification
    /// channels](https://docs.aws.amazon.com/grafana/latest/userguide/AMG-manage-permissions.html).
    permission_type: PermissionType,

    /// The name of the CloudFormation stack set to use to generate IAM
    /// roles to be used for this workspace.
    stack_set_name: ?[]const u8 = null,

    /// The list of tags associated with the workspace.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The configuration settings for an Amazon VPC that contains data sources for
    /// your Grafana workspace to connect to.
    ///
    /// Connecting to a private VPC is not yet available in the Asia Pacific (Seoul)
    /// Region (ap-northeast-2).
    vpc_configuration: ?VpcConfiguration = null,

    /// This parameter is for internal use only, and should not be used.
    workspace_data_sources: ?[]const DataSourceType = null,

    /// A description for the workspace. This is used only to help you identify this
    /// workspace.
    ///
    /// Pattern: `^[\\p{L}\\p{Z}\\p{N}\\p{P}]{0,2048}$`
    workspace_description: ?[]const u8 = null,

    /// The name for the workspace. It does not have to be unique.
    workspace_name: ?[]const u8 = null,

    /// Specify the Amazon Web Services notification channels that you plan to use
    /// in this
    /// workspace. Specifying these data sources here enables Amazon Managed Grafana
    /// to create
    /// IAM roles and permissions that allow Amazon Managed Grafana to use these
    /// channels.
    workspace_notification_destinations: ?[]const NotificationDestinationType = null,

    /// Specifies the organizational units that this workspace is allowed to use
    /// data sources
    /// from, if this workspace is in an account that is part of an organization.
    workspace_organizational_units: ?[]const []const u8 = null,

    /// Specified the IAM role that grants permissions to the Amazon Web Services
    /// resources that the workspace will view data from, including both data
    /// sources and notification channels. You are responsible for managing the
    /// permissions
    /// for this role as new data sources or notification channels are added.
    workspace_role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_access_type = "accountAccessType",
        .authentication_providers = "authenticationProviders",
        .client_token = "clientToken",
        .configuration = "configuration",
        .grafana_version = "grafanaVersion",
        .network_access_control = "networkAccessControl",
        .organization_role_name = "organizationRoleName",
        .permission_type = "permissionType",
        .stack_set_name = "stackSetName",
        .tags = "tags",
        .vpc_configuration = "vpcConfiguration",
        .workspace_data_sources = "workspaceDataSources",
        .workspace_description = "workspaceDescription",
        .workspace_name = "workspaceName",
        .workspace_notification_destinations = "workspaceNotificationDestinations",
        .workspace_organizational_units = "workspaceOrganizationalUnits",
        .workspace_role_arn = "workspaceRoleArn",
    };
};

pub const CreateWorkspaceOutput = struct {
    /// A structure containing data about the workspace that was created.
    workspace: ?WorkspaceDescription = null,

    pub const json_field_names = .{
        .workspace = "workspace",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateWorkspaceInput, options: CallOptions) !CreateWorkspaceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "grafana");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateWorkspaceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("grafana", "grafana", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/workspaces";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"accountAccessType\":");
    try aws.json.writeValue(@TypeOf(input.account_access_type), input.account_access_type, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"authenticationProviders\":");
    try aws.json.writeValue(@TypeOf(input.authentication_providers), input.authentication_providers, allocator, &body_buf);
    has_prev = true;
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"configuration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.grafana_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"grafanaVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.network_access_control) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"networkAccessControl\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.organization_role_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"organizationRoleName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"permissionType\":");
    try aws.json.writeValue(@TypeOf(input.permission_type), input.permission_type, allocator, &body_buf);
    has_prev = true;
    if (input.stack_set_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"stackSetName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.vpc_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"vpcConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.workspace_data_sources) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"workspaceDataSources\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.workspace_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"workspaceDescription\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.workspace_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"workspaceName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.workspace_notification_destinations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"workspaceNotificationDestinations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.workspace_organizational_units) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"workspaceOrganizationalUnits\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.workspace_role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"workspaceRoleArn\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateWorkspaceOutput {
    var result: CreateWorkspaceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateWorkspaceOutput, body, allocator);
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

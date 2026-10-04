const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccountAccessType = @import("account_access_type.zig").AccountAccessType;
const NetworkAccessConfiguration = @import("network_access_configuration.zig").NetworkAccessConfiguration;
const PermissionType = @import("permission_type.zig").PermissionType;
const VpcConfiguration = @import("vpc_configuration.zig").VpcConfiguration;
const DataSourceType = @import("data_source_type.zig").DataSourceType;
const NotificationDestinationType = @import("notification_destination_type.zig").NotificationDestinationType;
const WorkspaceDescription = @import("workspace_description.zig").WorkspaceDescription;

pub const UpdateWorkspaceInput = struct {
    /// Specifies whether the workspace can access Amazon Web Services resources in
    /// this Amazon Web Services account only, or whether it can also access Amazon
    /// Web Services resources in other accounts in the same organization. If you
    /// specify `ORGANIZATION`, you must specify which organizational units the
    /// workspace can access in the `workspaceOrganizationalUnits` parameter.
    account_access_type: ?AccountAccessType = null,

    /// The configuration settings for network access to your workspace.
    ///
    /// When this is configured, only listed IP addresses and VPC endpoints will be
    /// able to access your workspace. Standard Grafana authentication and
    /// authorization will still be required.
    ///
    /// If this is not configured, or is removed, then all IP addresses and VPC
    /// endpoints will be allowed. Standard Grafana authentication and authorization
    /// will still be required.
    network_access_control: ?NetworkAccessConfiguration = null,

    /// The name of an IAM role that already exists to use to access resources
    /// through Organizations. This can only be used with a workspace that has the
    /// `permissionType` set to `CUSTOMER_MANAGED`.
    organization_role_name: ?[]const u8 = null,

    /// Use this parameter if you want to change a workspace from `SERVICE_MANAGED`
    /// to `CUSTOMER_MANAGED`. This allows you to manage the permissions that the
    /// workspace uses to access datasources and notification channels. If the
    /// workspace is in a member Amazon Web Services account of an organization, and
    /// that account is not a delegated administrator account, and you want the
    /// workspace to access data sources in other Amazon Web Services accounts in
    /// the organization, you must choose `CUSTOMER_MANAGED`.
    ///
    /// If you specify this as `CUSTOMER_MANAGED`, you must also specify a
    /// `workspaceRoleArn` that the workspace will use for accessing Amazon Web
    /// Services resources.
    ///
    /// For more information on the role and permissions needed, see [Amazon Managed
    /// Grafana permissions and policies for Amazon Web Services data sources and
    /// notification
    /// channels](https://docs.aws.amazon.com/grafana/latest/userguide/AMG-manage-permissions.html)
    ///
    /// Do not use this to convert a `CUSTOMER_MANAGED` workspace to
    /// `SERVICE_MANAGED`. Do not include this parameter if you want to leave the
    /// workspace as `SERVICE_MANAGED`.
    ///
    /// You can convert a `CUSTOMER_MANAGED` workspace to `SERVICE_MANAGED` using
    /// the Amazon Managed Grafana console. For more information, see [Managing
    /// permissions for data sources and notification
    /// channels](https://docs.aws.amazon.com/grafana/latest/userguide/AMG-datasource-and-notification.html).
    permission_type: ?PermissionType = null,

    /// Whether to remove the network access configuration from the workspace.
    ///
    /// Setting this to `true` and providing a `networkAccessControl` to set will
    /// return an error.
    ///
    /// If you remove this configuration by setting this to `true`, then all IP
    /// addresses and VPC endpoints will be allowed. Standard Grafana authentication
    /// and authorization will still be required.
    remove_network_access_configuration: ?bool = null,

    /// Whether to remove the VPC configuration from the workspace.
    ///
    /// Setting this to `true` and providing a `vpcConfiguration` to set will return
    /// an error.
    remove_vpc_configuration: ?bool = null,

    /// The name of the CloudFormation stack set to use to generate IAM roles to be
    /// used for this workspace.
    stack_set_name: ?[]const u8 = null,

    /// The configuration settings for an Amazon VPC that contains data sources for
    /// your Grafana workspace to connect to.
    vpc_configuration: ?VpcConfiguration = null,

    /// This parameter is for internal use only, and should not be used.
    workspace_data_sources: ?[]const DataSourceType = null,

    /// A description for the workspace. This is used only to help you identify this
    /// workspace.
    workspace_description: ?[]const u8 = null,

    /// The ID of the workspace to update.
    workspace_id: []const u8,

    /// A new name for the workspace to update.
    workspace_name: ?[]const u8 = null,

    /// Specify the Amazon Web Services notification channels that you plan to use
    /// in this workspace. Specifying these data sources here enables Amazon Managed
    /// Grafana to create IAM roles and permissions that allow Amazon Managed
    /// Grafana to use these channels.
    workspace_notification_destinations: ?[]const NotificationDestinationType = null,

    /// Specifies the organizational units that this workspace is allowed to use
    /// data sources from, if this workspace is in an account that is part of an
    /// organization.
    workspace_organizational_units: ?[]const []const u8 = null,

    /// Specifies an IAM role that grants permissions to Amazon Web Services
    /// resources that the workspace accesses, such as data sources and notification
    /// channels. If this workspace has `permissionType` `CUSTOMER_MANAGED`, then
    /// this role is required.
    workspace_role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_access_type = "accountAccessType",
        .network_access_control = "networkAccessControl",
        .organization_role_name = "organizationRoleName",
        .permission_type = "permissionType",
        .remove_network_access_configuration = "removeNetworkAccessConfiguration",
        .remove_vpc_configuration = "removeVpcConfiguration",
        .stack_set_name = "stackSetName",
        .vpc_configuration = "vpcConfiguration",
        .workspace_data_sources = "workspaceDataSources",
        .workspace_description = "workspaceDescription",
        .workspace_id = "workspaceId",
        .workspace_name = "workspaceName",
        .workspace_notification_destinations = "workspaceNotificationDestinations",
        .workspace_organizational_units = "workspaceOrganizationalUnits",
        .workspace_role_arn = "workspaceRoleArn",
    };
};

pub const UpdateWorkspaceOutput = struct {
    /// A structure containing data about the workspace that was created.
    workspace: ?WorkspaceDescription = null,

    pub const json_field_names = .{
        .workspace = "workspace",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateWorkspaceInput, options: CallOptions) !UpdateWorkspaceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "grafana", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateWorkspaceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("grafana", "grafana", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.account_access_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"accountAccessType\":");
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
    if (input.permission_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"permissionType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.remove_network_access_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"removeNetworkAccessConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.remove_vpc_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"removeVpcConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.stack_set_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"stackSetName\":");
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

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateWorkspaceOutput {
    var result: UpdateWorkspaceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateWorkspaceOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

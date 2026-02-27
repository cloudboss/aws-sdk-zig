const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DashboardPublishOptions = @import("dashboard_publish_options.zig").DashboardPublishOptions;
const DashboardVersionDefinition = @import("dashboard_version_definition.zig").DashboardVersionDefinition;
const LinkSharingConfiguration = @import("link_sharing_configuration.zig").LinkSharingConfiguration;
const Parameters = @import("parameters.zig").Parameters;
const ResourcePermission = @import("resource_permission.zig").ResourcePermission;
const DashboardSourceEntity = @import("dashboard_source_entity.zig").DashboardSourceEntity;
const Tag = @import("tag.zig").Tag;
const ValidationStrategy = @import("validation_strategy.zig").ValidationStrategy;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

pub const CreateDashboardInput = struct {
    /// The ID of the Amazon Web Services account where you want to create the
    /// dashboard.
    aws_account_id: []const u8,

    /// The ID for the dashboard, also added to the IAM policy.
    dashboard_id: []const u8,

    /// Options for publishing the dashboard when you create it:
    ///
    /// * `AvailabilityStatus` for `AdHocFilteringOption` - This
    /// status can be either `ENABLED` or `DISABLED`. When this is
    /// set to `DISABLED`, Amazon Quick Sight disables the left filter pane on
    /// the published dashboard, which can be used for ad hoc (one-time) filtering.
    /// This
    /// option is `ENABLED` by default.
    ///
    /// * `AvailabilityStatus` for `ExportToCSVOption` - This
    /// status can be either `ENABLED` or `DISABLED`. The visual
    /// option to export data to .CSV format isn't enabled when this is set to
    /// `DISABLED`. This option is `ENABLED` by default.
    ///
    /// * `VisibilityState` for `SheetControlsOption` - This
    /// visibility state can be either `COLLAPSED` or `EXPANDED`.
    /// This option is `COLLAPSED` by default.
    ///
    /// * `AvailabilityStatus` for `QuickSuiteActionsOption` -
    /// This status can be either `ENABLED` or `DISABLED`.
    /// Features related to Actions in Amazon Quick Suite on dashboards are disabled
    /// when this is set to `DISABLED`. This option is `DISABLED`
    /// by default.
    ///
    /// * `AvailabilityStatus` for `ExecutiveSummaryOption` - This
    /// status can be either `ENABLED` or `DISABLED`. The option
    /// to build an executive summary is disabled when this is set to
    /// `DISABLED`. This option is `ENABLED` by
    /// default.
    ///
    /// * `AvailabilityStatus` for `DataStoriesSharingOption` -
    /// This status can be either `ENABLED` or `DISABLED`. The
    /// option to share a data story is disabled when this is set to
    /// `DISABLED`. This option is `ENABLED` by
    /// default.
    dashboard_publish_options: ?DashboardPublishOptions = null,

    /// The definition of a dashboard.
    ///
    /// A definition is the data model of all features in a Dashboard, Template, or
    /// Analysis.
    ///
    /// Either a `SourceEntity` or a `Definition` must be provided in
    /// order for the request to be valid.
    definition: ?DashboardVersionDefinition = null,

    /// When you create the dashboard, Amazon Quick Sight adds the dashboard to
    /// these
    /// folders.
    folder_arns: ?[]const []const u8 = null,

    /// A list of analysis Amazon Resource Names (ARNs) to be linked to the
    /// dashboard.
    link_entities: ?[]const []const u8 = null,

    /// A structure that contains the permissions of a shareable link to the
    /// dashboard.
    link_sharing_configuration: ?LinkSharingConfiguration = null,

    /// The display name of the dashboard.
    name: []const u8,

    /// The parameters for the creation of the dashboard, which you want to use to
    /// override
    /// the default settings. A dashboard can have any type of parameters, and some
    /// parameters
    /// might accept multiple values.
    parameters: ?Parameters = null,

    /// A structure that contains the permissions of the dashboard. You can use this
    /// structure
    /// for granting permissions by providing a list of IAM action information
    /// for each principal ARN.
    ///
    /// To specify no permissions, omit the permissions list.
    permissions: ?[]const ResourcePermission = null,

    /// The entity that you are using as a source when you create the dashboard. In
    /// `SourceEntity`, you specify the type of object you're using as source.
    /// You can only create a dashboard from a template, so you use a
    /// `SourceTemplate` entity. If you need to create a dashboard from an
    /// analysis, first convert the analysis to a template by using the `
    /// [CreateTemplate](https://docs.aws.amazon.com/quicksight/latest/APIReference/API_CreateTemplate.html)
    /// ` API operation. For `SourceTemplate`,
    /// specify the Amazon Resource Name (ARN) of the source template. The
    /// `SourceTemplate`ARN can contain any Amazon Web Services account and any
    /// Amazon Quick Sight-supported Amazon Web Services Region.
    ///
    /// Use the `DataSetReferences` entity within `SourceTemplate` to
    /// list the replacement datasets for the placeholders listed in the original.
    /// The schema in
    /// each dataset must match its placeholder.
    ///
    /// Either a `SourceEntity` or a `Definition` must be provided in
    /// order for the request to be valid.
    source_entity: ?DashboardSourceEntity = null,

    /// Contains a map of the key-value pairs for the resource tag or tags assigned
    /// to the
    /// dashboard.
    tags: ?[]const Tag = null,

    /// The Amazon Resource Name (ARN) of the theme that is being used for this
    /// dashboard. If
    /// you add a value for this field, it overrides the value that is used in the
    /// source
    /// entity. The theme ARN must exist in the same Amazon Web Services account
    /// where you create
    /// the dashboard.
    theme_arn: ?[]const u8 = null,

    /// The option to relax the validation needed to create a dashboard with
    /// definition
    /// objects. This option skips the validation step for specific errors.
    validation_strategy: ?ValidationStrategy = null,

    /// A description for the first version of the dashboard being created.
    version_description: ?[]const u8 = null,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .dashboard_id = "DashboardId",
        .dashboard_publish_options = "DashboardPublishOptions",
        .definition = "Definition",
        .folder_arns = "FolderArns",
        .link_entities = "LinkEntities",
        .link_sharing_configuration = "LinkSharingConfiguration",
        .name = "Name",
        .parameters = "Parameters",
        .permissions = "Permissions",
        .source_entity = "SourceEntity",
        .tags = "Tags",
        .theme_arn = "ThemeArn",
        .validation_strategy = "ValidationStrategy",
        .version_description = "VersionDescription",
    };
};

pub const CreateDashboardOutput = struct {
    /// The ARN of the dashboard.
    arn: ?[]const u8 = null,

    /// The status of the dashboard creation request.
    creation_status: ?ResourceStatus = null,

    /// The ID for the dashboard.
    dashboard_id: ?[]const u8 = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: i32 = 0,

    /// The ARN of the dashboard, including the version number of the first version
    /// that is
    /// created.
    version_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_status = "CreationStatus",
        .dashboard_id = "DashboardId",
        .request_id = "RequestId",
        .status = "Status",
        .version_arn = "VersionArn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDashboardInput, options: Options) !CreateDashboardOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "quicksight");

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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateDashboardInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/accounts/");
    try path_buf.appendSlice(alloc, input.aws_account_id);
    try path_buf.appendSlice(alloc, "/dashboards/");
    try path_buf.appendSlice(alloc, input.dashboard_id);
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.dashboard_publish_options) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"DashboardPublishOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.definition) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Definition\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.folder_arns) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"FolderArns\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.link_entities) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"LinkEntities\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.link_sharing_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"LinkSharingConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, alloc, &body_buf);
    has_prev = true;
    if (input.parameters) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Parameters\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.permissions) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Permissions\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.source_entity) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"SourceEntity\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.theme_arn) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"ThemeArn\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.validation_strategy) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"ValidationStrategy\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.version_description) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"VersionDescription\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateDashboardOutput {
    var result: CreateDashboardOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateDashboardOutput, body, alloc);
    }
    result.status = @intCast(status);
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
    if (std.mem.eql(u8, error_code, "ConcurrentUpdatingException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_updating_exception = .{
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
    if (std.mem.eql(u8, error_code, "CustomerManagedKeyUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .customer_managed_key_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DomainNotWhitelistedException")) {
        return .{ .arena = arena, .kind = .{ .domain_not_whitelisted_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IdentityTypeNotSupportedException")) {
        return .{ .arena = arena, .kind = .{ .identity_type_not_supported_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalFailureException")) {
        return .{ .arena = arena, .kind = .{ .internal_failure_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidDataSetParameterValueException")) {
        return .{ .arena = arena, .kind = .{ .invalid_data_set_parameter_value_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterValueException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_value_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PreconditionNotMetException")) {
        return .{ .arena = arena, .kind = .{ .precondition_not_met_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "QuickSightUserNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .quick_sight_user_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_exists_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .resource_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SessionLifetimeInMinutesInvalidException")) {
        return .{ .arena = arena, .kind = .{ .session_lifetime_in_minutes_invalid_exception = .{
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
    if (std.mem.eql(u8, error_code, "UnsupportedPricingPlanException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_pricing_plan_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedUserEditionException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_user_edition_exception = .{
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

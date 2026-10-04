const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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
    /// each dataset must match its placeholder. Use the `TopicReferences`
    /// entity to list the replacement topics for the topic placeholders listed in
    /// the original.
    /// The schema in each topic must match its placeholder.
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
    status: ?i32 = null,

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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDashboardInput, options: CallOptions) !CreateDashboardOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "quicksight", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDashboardInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/dashboards/");
    try path_buf.appendSlice(allocator, input.dashboard_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.dashboard_publish_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DashboardPublishOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.definition) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Definition\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.folder_arns) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FolderArns\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.link_entities) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LinkEntities\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.link_sharing_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LinkSharingConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Parameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.permissions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Permissions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.source_entity) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SourceEntity\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.theme_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ThemeArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.validation_strategy) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ValidationStrategy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.version_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"VersionDescription\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDashboardOutput {
    var result: CreateDashboardOutput = try aws.json.parseJsonObject(
        CreateDashboardOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    result.status = @intCast(status);
    _ = headers;

    return result;
}

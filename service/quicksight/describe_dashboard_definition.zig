const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DashboardPublishOptions = @import("dashboard_publish_options.zig").DashboardPublishOptions;
const DashboardVersionDefinition = @import("dashboard_version_definition.zig").DashboardVersionDefinition;
const DashboardError = @import("dashboard_error.zig").DashboardError;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

pub const DescribeDashboardDefinitionInput = struct {
    /// The alias name.
    alias_name: ?[]const u8 = null,

    /// The ID of the Amazon Web Services account that contains the dashboard that
    /// you're
    /// describing.
    aws_account_id: []const u8,

    /// The ID for the dashboard.
    dashboard_id: []const u8,

    /// The version number for the dashboard. If a version number isn't passed, the
    /// latest published dashboard version is described.
    version_number: ?i64 = null,

    pub const json_field_names = .{
        .alias_name = "AliasName",
        .aws_account_id = "AwsAccountId",
        .dashboard_id = "DashboardId",
        .version_number = "VersionNumber",
    };
};

pub const DescribeDashboardDefinitionOutput = struct {
    /// The ID of the dashboard described.
    dashboard_id: ?[]const u8 = null,

    /// Options for publishing the dashboard:
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
    definition: ?DashboardVersionDefinition = null,

    /// Errors associated with this dashboard version.
    errors: ?[]const DashboardError = null,

    /// The display name of the dashboard.
    name: ?[]const u8 = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// Status associated with the dashboard version.
    ///
    /// * `CREATION_IN_PROGRESS`
    ///
    /// * `CREATION_SUCCESSFUL`
    ///
    /// * `CREATION_FAILED`
    ///
    /// * `UPDATE_IN_PROGRESS`
    ///
    /// * `UPDATE_SUCCESSFUL`
    ///
    /// * `UPDATE_FAILED`
    ///
    /// * `DELETED`
    resource_status: ?ResourceStatus = null,

    /// The HTTP status of the request.
    status: ?i32 = null,

    /// The ARN of the theme of the dashboard.
    theme_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .dashboard_id = "DashboardId",
        .dashboard_publish_options = "DashboardPublishOptions",
        .definition = "Definition",
        .errors = "Errors",
        .name = "Name",
        .request_id = "RequestId",
        .resource_status = "ResourceStatus",
        .status = "Status",
        .theme_arn = "ThemeArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDashboardDefinitionInput, options: CallOptions) !DescribeDashboardDefinitionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDashboardDefinitionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/dashboards/");
    try path_buf.appendSlice(allocator, input.dashboard_id);
    try path_buf.appendSlice(allocator, "/definition");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.alias_name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "alias-name=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.version_number) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "version-number=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDashboardDefinitionOutput {
    var result: DescribeDashboardDefinitionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeDashboardDefinitionOutput, body, allocator);
    }
    result.status = @intCast(status);
    _ = headers;

    return result;
}

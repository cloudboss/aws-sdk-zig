const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DashboardPublishOptions = @import("dashboard_publish_options.zig").DashboardPublishOptions;
const DashboardVersionDefinition = @import("dashboard_version_definition.zig").DashboardVersionDefinition;
const Parameters = @import("parameters.zig").Parameters;
const DashboardSourceEntity = @import("dashboard_source_entity.zig").DashboardSourceEntity;
const ValidationStrategy = @import("validation_strategy.zig").ValidationStrategy;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

pub const UpdateDashboardInput = struct {
    /// The ID of the Amazon Web Services account that contains the dashboard that
    /// you're
    /// updating.
    aws_account_id: []const u8,

    /// The ID for the dashboard.
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
    definition: ?DashboardVersionDefinition = null,

    /// The display name of the dashboard.
    name: []const u8,

    /// A structure that contains the parameters of the dashboard. These are
    /// parameter
    /// overrides for a dashboard. A dashboard can have any type of parameters, and
    /// some
    /// parameters might accept multiple values.
    parameters: ?Parameters = null,

    /// The entity that you are using as a source when you update the dashboard. In
    /// `SourceEntity`, you specify the type of object you're using as source.
    /// You can only update a dashboard from a template, so you use a
    /// `SourceTemplate` entity. If you need to update a dashboard from an
    /// analysis, first convert the analysis to a template by using the `
    /// [CreateTemplate](https://docs.aws.amazon.com/quicksight/latest/APIReference/API_CreateTemplate.html)
    /// ` API operation. For `SourceTemplate`,
    /// specify the Amazon Resource Name (ARN) of the source template. The
    /// `SourceTemplate` ARN can contain any Amazon Web Services account and any
    /// Amazon Quick Sight-supported Amazon Web Services Region.
    ///
    /// Use the `DataSetReferences` entity within `SourceTemplate` to
    /// list the replacement datasets for the placeholders listed in the original.
    /// The schema in
    /// each dataset must match its placeholder.
    source_entity: ?DashboardSourceEntity = null,

    /// The Amazon Resource Name (ARN) of the theme that is being used for this
    /// dashboard. If
    /// you add a value for this field, it overrides the value that was originally
    /// associated
    /// with the entity. The theme ARN must exist in the same Amazon Web Services
    /// account where
    /// you create the dashboard.
    theme_arn: ?[]const u8 = null,

    /// The option to relax the validation needed to update a dashboard with
    /// definition
    /// objects. This skips the validation step for specific errors.
    validation_strategy: ?ValidationStrategy = null,

    /// A description for the first version of the dashboard being created.
    version_description: ?[]const u8 = null,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .dashboard_id = "DashboardId",
        .dashboard_publish_options = "DashboardPublishOptions",
        .definition = "Definition",
        .name = "Name",
        .parameters = "Parameters",
        .source_entity = "SourceEntity",
        .theme_arn = "ThemeArn",
        .validation_strategy = "ValidationStrategy",
        .version_description = "VersionDescription",
    };
};

pub const UpdateDashboardOutput = struct {
    /// The Amazon Resource Name (ARN) of the resource.
    arn: ?[]const u8 = null,

    /// The creation status of the request.
    creation_status: ?ResourceStatus = null,

    /// The ID for the dashboard.
    dashboard_id: ?[]const u8 = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: ?i32 = null,

    /// The ARN of the dashboard, including the version number.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDashboardInput, options: Options) !UpdateDashboardOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDashboardInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/dashboards/");
    try path_buf.appendSlice(allocator, input.dashboard_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
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
    if (input.source_entity) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SourceEntity\":");
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

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDashboardOutput {
    var result: UpdateDashboardOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateDashboardOutput, body, allocator);
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

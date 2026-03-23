const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ColumnGroup = @import("column_group.zig").ColumnGroup;
const ColumnLevelPermissionRule = @import("column_level_permission_rule.zig").ColumnLevelPermissionRule;
const DataPrepConfiguration = @import("data_prep_configuration.zig").DataPrepConfiguration;
const DatasetParameter = @import("dataset_parameter.zig").DatasetParameter;
const DataSetUsageConfiguration = @import("data_set_usage_configuration.zig").DataSetUsageConfiguration;
const FieldFolder = @import("field_folder.zig").FieldFolder;
const DataSetImportMode = @import("data_set_import_mode.zig").DataSetImportMode;
const LogicalTable = @import("logical_table.zig").LogicalTable;
const PerformanceConfiguration = @import("performance_configuration.zig").PerformanceConfiguration;
const ResourcePermission = @import("resource_permission.zig").ResourcePermission;
const PhysicalTable = @import("physical_table.zig").PhysicalTable;
const RowLevelPermissionDataSet = @import("row_level_permission_data_set.zig").RowLevelPermissionDataSet;
const RowLevelPermissionTagConfiguration = @import("row_level_permission_tag_configuration.zig").RowLevelPermissionTagConfiguration;
const SemanticModelConfiguration = @import("semantic_model_configuration.zig").SemanticModelConfiguration;
const Tag = @import("tag.zig").Tag;
const DataSetUseAs = @import("data_set_use_as.zig").DataSetUseAs;

pub const CreateDataSetInput = struct {
    /// The Amazon Web Services account ID.
    aws_account_id: []const u8,

    /// Groupings of columns that work together in certain Amazon Quick Sight
    /// features.
    /// Currently, only geospatial hierarchy is supported.
    column_groups: ?[]const ColumnGroup = null,

    /// A set of one or more definitions of a `
    /// [ColumnLevelPermissionRule](https://docs.aws.amazon.com/quicksight/latest/APIReference/API_ColumnLevelPermissionRule.html)
    /// `.
    column_level_permission_rules: ?[]const ColumnLevelPermissionRule = null,

    /// The data preparation configuration for the dataset. This configuration
    /// defines the source tables,
    /// transformation steps, and destination tables used to prepare the data.
    /// Required when using the new data preparation experience.
    data_prep_configuration: ?DataPrepConfiguration = null,

    /// An ID for the dataset that you want to create. This ID is unique per Amazon
    /// Web Services Region for each Amazon Web Services account.
    data_set_id: []const u8,

    /// The parameter declarations of the dataset.
    dataset_parameters: ?[]const DatasetParameter = null,

    data_set_usage_configuration: ?DataSetUsageConfiguration = null,

    /// The folder that contains fields and nested subfolders for your dataset.
    field_folders: ?[]const aws.map.MapEntry(FieldFolder) = null,

    /// When you create the dataset, Amazon Quick Sight adds the dataset to these
    /// folders.
    folder_arns: ?[]const []const u8 = null,

    /// Indicates whether you want to import the data into SPICE.
    import_mode: DataSetImportMode,

    /// Configures the combination and transformation of the data from the physical
    /// tables. This parameter is used with the legacy data preparation experience.
    logical_table_map: ?[]const aws.map.MapEntry(LogicalTable) = null,

    /// The display name for the dataset.
    name: []const u8,

    /// The configuration for the performance optimization of the dataset that
    /// contains a
    /// `UniqueKey` configuration.
    performance_configuration: ?PerformanceConfiguration = null,

    /// A list of resource permissions on the dataset.
    permissions: ?[]const ResourcePermission = null,

    /// Declares the physical tables that are available in the underlying data
    /// sources.
    physical_table_map: []const aws.map.MapEntry(PhysicalTable),

    /// The row-level security configuration for the data that you want to create.
    /// This parameter is
    /// used with the legacy data preparation experience.
    row_level_permission_data_set: ?RowLevelPermissionDataSet = null,

    /// The configuration of tags on a dataset to set row-level security. Row-level
    /// security
    /// tags are currently supported for anonymous embedding only. This parameter is
    /// used with the legacy data preparation experience.
    row_level_permission_tag_configuration: ?RowLevelPermissionTagConfiguration = null,

    /// The semantic model configuration for the dataset. This configuration defines
    /// how the prepared
    /// data is structured for an analysis, including table mappings and row-level
    /// security configurations.
    /// Required when using the new data preparation experience.
    semantic_model_configuration: ?SemanticModelConfiguration = null,

    /// Contains a map of the key-value pairs for the resource tag or tags assigned
    /// to the
    /// dataset.
    tags: ?[]const Tag = null,

    /// The usage of the dataset. `RLS_RULES` must be specified for RLS permission
    /// datasets.
    use_as: ?DataSetUseAs = null,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .column_groups = "ColumnGroups",
        .column_level_permission_rules = "ColumnLevelPermissionRules",
        .data_prep_configuration = "DataPrepConfiguration",
        .data_set_id = "DataSetId",
        .dataset_parameters = "DatasetParameters",
        .data_set_usage_configuration = "DataSetUsageConfiguration",
        .field_folders = "FieldFolders",
        .folder_arns = "FolderArns",
        .import_mode = "ImportMode",
        .logical_table_map = "LogicalTableMap",
        .name = "Name",
        .performance_configuration = "PerformanceConfiguration",
        .permissions = "Permissions",
        .physical_table_map = "PhysicalTableMap",
        .row_level_permission_data_set = "RowLevelPermissionDataSet",
        .row_level_permission_tag_configuration = "RowLevelPermissionTagConfiguration",
        .semantic_model_configuration = "SemanticModelConfiguration",
        .tags = "Tags",
        .use_as = "UseAs",
    };
};

pub const CreateDataSetOutput = struct {
    /// The Amazon Resource Name (ARN) of the dataset.
    arn: ?[]const u8 = null,

    /// The ID for the dataset that you want to create. This ID is unique per Amazon
    /// Web Services Region for each Amazon Web Services account.
    data_set_id: ?[]const u8 = null,

    /// The ARN for the ingestion, which is triggered as a result of dataset
    /// creation if the
    /// import mode is SPICE.
    ingestion_arn: ?[]const u8 = null,

    /// The ID of the ingestion, which is triggered as a result of dataset creation
    /// if the
    /// import mode is SPICE.
    ingestion_id: ?[]const u8 = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: ?i32 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .data_set_id = "DataSetId",
        .ingestion_arn = "IngestionArn",
        .ingestion_id = "IngestionId",
        .request_id = "RequestId",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDataSetInput, options: CallOptions) !CreateDataSetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDataSetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/data-sets");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.column_groups) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ColumnGroups\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.column_level_permission_rules) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ColumnLevelPermissionRules\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.data_prep_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DataPrepConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DataSetId\":");
    try aws.json.writeValue(@TypeOf(input.data_set_id), input.data_set_id, allocator, &body_buf);
    has_prev = true;
    if (input.dataset_parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DatasetParameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.data_set_usage_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DataSetUsageConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.field_folders) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FieldFolders\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.folder_arns) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FolderArns\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ImportMode\":");
    try aws.json.writeValue(@TypeOf(input.import_mode), input.import_mode, allocator, &body_buf);
    has_prev = true;
    if (input.logical_table_map) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LogicalTableMap\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.performance_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PerformanceConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.permissions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Permissions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PhysicalTableMap\":");
    try aws.json.writeValue(@TypeOf(input.physical_table_map), input.physical_table_map, allocator, &body_buf);
    has_prev = true;
    if (input.row_level_permission_data_set) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RowLevelPermissionDataSet\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.row_level_permission_tag_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RowLevelPermissionTagConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.semantic_model_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SemanticModelConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.use_as) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"UseAs\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDataSetOutput {
    var result: CreateDataSetOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateDataSetOutput, body, allocator);
    }
    result.status = @intCast(status);
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

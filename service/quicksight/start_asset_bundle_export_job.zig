const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AssetBundleCloudFormationOverridePropertyConfiguration = @import("asset_bundle_cloud_formation_override_property_configuration.zig").AssetBundleCloudFormationOverridePropertyConfiguration;
const AssetBundleExportFormat = @import("asset_bundle_export_format.zig").AssetBundleExportFormat;
const IncludeFolderMembers = @import("include_folder_members.zig").IncludeFolderMembers;
const AssetBundleExportJobValidationStrategy = @import("asset_bundle_export_job_validation_strategy.zig").AssetBundleExportJobValidationStrategy;

pub const StartAssetBundleExportJobInput = struct {
    /// The ID of the job. This ID is unique while the job is running. After the job
    /// is
    /// completed, you can reuse this ID for another job.
    asset_bundle_export_job_id: []const u8,

    /// The ID of the Amazon Web Services account to export assets from.
    aws_account_id: []const u8,

    /// An optional collection of structures that generate CloudFormation parameters
    /// to
    /// override the existing resource property values when the resource is exported
    /// to a new
    /// CloudFormation template.
    ///
    /// Use this field if the `ExportFormat` field of a
    /// `StartAssetBundleExportJobRequest` API call is set to
    /// `CLOUDFORMATION_JSON`.
    cloud_formation_override_property_configuration: ?AssetBundleCloudFormationOverridePropertyConfiguration = null,

    /// The export data format.
    export_format: AssetBundleExportFormat,

    /// A Boolean that determines whether all dependencies of each resource ARN are
    /// recursively
    /// exported with the job. For example, say you provided a Dashboard ARN to the
    /// `ResourceArns` parameter. If you set `IncludeAllDependencies` to
    /// `TRUE`, any theme, dataset, and data source resource that is a dependency of
    /// the dashboard is also exported.
    include_all_dependencies: ?bool = null,

    /// A setting that indicates whether you want to include folder assets. You can
    /// also use
    /// this setting to recusrsively include all subfolders of an exported folder.
    include_folder_members: ?IncludeFolderMembers = null,

    /// A Boolean that determines if the exported asset carries over information
    /// about the
    /// folders that the asset is a member of.
    include_folder_memberships: ?bool = null,

    /// A Boolean that determines whether all permissions for each resource ARN are
    /// exported
    /// with the job. If you set `IncludePermissions` to `TRUE`, any
    /// permissions associated with each resource are exported.
    include_permissions: ?bool = null,

    /// A Boolean that determines whether all tags for each resource ARN are
    /// exported with the
    /// job. If you set `IncludeTags` to `TRUE`, any tags associated with
    /// each resource are exported.
    include_tags: ?bool = null,

    /// An array of resource ARNs to export. The following resources are supported.
    ///
    /// * `Analysis`
    ///
    /// * `Dashboard`
    ///
    /// * `DataSet`
    ///
    /// * `DataSource`
    ///
    /// * `RefreshSchedule`
    ///
    /// * `Theme`
    ///
    /// * `VPCConnection`
    ///
    /// The API caller must have the necessary permissions in their IAM role to
    /// access each resource before the resources can be exported.
    resource_arns: []const []const u8,

    /// An optional parameter that determines which validation strategy to use for
    /// the export
    /// job. If `StrictModeForAllResources` is set to `TRUE`, strict
    /// validation for every error is enforced. If it is set to `FALSE`, validation
    /// is
    /// skipped for specific UI errors that are shown as warnings. The default value
    /// for
    /// `StrictModeForAllResources` is `FALSE`.
    validation_strategy: ?AssetBundleExportJobValidationStrategy = null,

    pub const json_field_names = .{
        .asset_bundle_export_job_id = "AssetBundleExportJobId",
        .aws_account_id = "AwsAccountId",
        .cloud_formation_override_property_configuration = "CloudFormationOverridePropertyConfiguration",
        .export_format = "ExportFormat",
        .include_all_dependencies = "IncludeAllDependencies",
        .include_folder_members = "IncludeFolderMembers",
        .include_folder_memberships = "IncludeFolderMemberships",
        .include_permissions = "IncludePermissions",
        .include_tags = "IncludeTags",
        .resource_arns = "ResourceArns",
        .validation_strategy = "ValidationStrategy",
    };
};

pub const StartAssetBundleExportJobOutput = struct {
    /// The Amazon Resource Name (ARN) for the export job.
    arn: ?[]const u8 = null,

    /// The ID of the job. This ID is unique while the job is running. After the job
    /// is
    /// completed, you can reuse this ID for another job.
    asset_bundle_export_job_id: ?[]const u8 = null,

    /// The Amazon Web Services response ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the response.
    status: ?i32 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .asset_bundle_export_job_id = "AssetBundleExportJobId",
        .request_id = "RequestId",
        .status = "Status",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartAssetBundleExportJobInput, options: Options) !StartAssetBundleExportJobOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: StartAssetBundleExportJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/accounts/");
    try path_buf.appendSlice(alloc, input.aws_account_id);
    try path_buf.appendSlice(alloc, "/asset-bundle-export-jobs/export");
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"AssetBundleExportJobId\":");
    try aws.json.writeValue(@TypeOf(input.asset_bundle_export_job_id), input.asset_bundle_export_job_id, alloc, &body_buf);
    has_prev = true;
    if (input.cloud_formation_override_property_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"CloudFormationOverridePropertyConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"ExportFormat\":");
    try aws.json.writeValue(@TypeOf(input.export_format), input.export_format, alloc, &body_buf);
    has_prev = true;
    if (input.include_all_dependencies) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"IncludeAllDependencies\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.include_folder_members) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"IncludeFolderMembers\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.include_folder_memberships) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"IncludeFolderMemberships\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.include_permissions) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"IncludePermissions\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.include_tags) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"IncludeTags\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"ResourceArns\":");
    try aws.json.writeValue(@TypeOf(input.resource_arns), input.resource_arns, alloc, &body_buf);
    has_prev = true;
    if (input.validation_strategy) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"ValidationStrategy\":");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !StartAssetBundleExportJobOutput {
    var result: StartAssetBundleExportJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartAssetBundleExportJobOutput, body, alloc);
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

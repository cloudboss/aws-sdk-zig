const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartAssetBundleExportJobInput, options: CallOptions) !StartAssetBundleExportJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartAssetBundleExportJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/asset-bundle-export-jobs/export");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"AssetBundleExportJobId\":");
    try aws.json.writeValue(@TypeOf(input.asset_bundle_export_job_id), input.asset_bundle_export_job_id, allocator, &body_buf);
    has_prev = true;
    if (input.cloud_formation_override_property_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CloudFormationOverridePropertyConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ExportFormat\":");
    try aws.json.writeValue(@TypeOf(input.export_format), input.export_format, allocator, &body_buf);
    has_prev = true;
    if (input.include_all_dependencies) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IncludeAllDependencies\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.include_folder_members) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IncludeFolderMembers\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.include_folder_memberships) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IncludeFolderMemberships\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.include_permissions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IncludePermissions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.include_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IncludeTags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ResourceArns\":");
    try aws.json.writeValue(@TypeOf(input.resource_arns), input.resource_arns, allocator, &body_buf);
    has_prev = true;
    if (input.validation_strategy) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ValidationStrategy\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartAssetBundleExportJobOutput {
    var result: StartAssetBundleExportJobOutput = try aws.json.parseJsonObject(
        StartAssetBundleExportJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    result.status = @intCast(status);
    _ = headers;

    return result;
}

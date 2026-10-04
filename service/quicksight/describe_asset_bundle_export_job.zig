const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssetBundleCloudFormationOverridePropertyConfiguration = @import("asset_bundle_cloud_formation_override_property_configuration.zig").AssetBundleCloudFormationOverridePropertyConfiguration;
const AssetBundleExportJobError = @import("asset_bundle_export_job_error.zig").AssetBundleExportJobError;
const AssetBundleExportFormat = @import("asset_bundle_export_format.zig").AssetBundleExportFormat;
const IncludeFolderMembers = @import("include_folder_members.zig").IncludeFolderMembers;
const AssetBundleExportJobStatus = @import("asset_bundle_export_job_status.zig").AssetBundleExportJobStatus;
const AssetBundleExportJobValidationStrategy = @import("asset_bundle_export_job_validation_strategy.zig").AssetBundleExportJobValidationStrategy;
const AssetBundleExportJobWarning = @import("asset_bundle_export_job_warning.zig").AssetBundleExportJobWarning;

pub const DescribeAssetBundleExportJobInput = struct {
    /// The ID of the job that you want described. The job ID is set when you start
    /// a new job
    /// with a `StartAssetBundleExportJob` API call.
    asset_bundle_export_job_id: []const u8,

    /// The ID of the Amazon Web Services account the export job is executed in.
    aws_account_id: []const u8,

    pub const json_field_names = .{
        .asset_bundle_export_job_id = "AssetBundleExportJobId",
        .aws_account_id = "AwsAccountId",
    };
};

pub const DescribeAssetBundleExportJobOutput = struct {
    /// The Amazon Resource Name (ARN) for the export job.
    arn: ?[]const u8 = null,

    /// The ID of the job. The job ID is set when you start a new job with a
    /// `StartAssetBundleExportJob` API call.
    asset_bundle_export_job_id: ?[]const u8 = null,

    /// The ID of the Amazon Web Services account that the export job was executed
    /// in.
    aws_account_id: ?[]const u8 = null,

    /// The CloudFormation override property configuration for the export job.
    cloud_formation_override_property_configuration: ?AssetBundleCloudFormationOverridePropertyConfiguration = null,

    /// The time that the export job was created.
    created_time: ?i64 = null,

    /// The URL to download the exported asset bundle data from.
    ///
    /// This URL is available only after the job has succeeded. This URL is valid
    /// for 5 minutes
    /// after issuance. Call `DescribeAssetBundleExportJob` again for a fresh URL if
    /// needed.
    ///
    /// The downloaded asset bundle is a zip file named `assetbundle-{jobId}.qs`.
    /// The
    /// file has a `.qs` extension.
    ///
    /// This URL can't be used in a `StartAssetBundleImportJob` API call and
    /// should only be used for download purposes.
    download_url: ?[]const u8 = null,

    /// An array of error records that describes any failures that occurred during
    /// the export
    /// job processing.
    ///
    /// Error records accumulate while the job runs. The complete set of error
    /// records is
    /// available after the job has completed and failed.
    errors: ?[]const AssetBundleExportJobError = null,

    /// The format of the exported asset bundle. A `QUICKSIGHT_JSON` formatted file
    /// can be used to make a `StartAssetBundleImportJob` API call. A
    /// `CLOUDFORMATION_JSON` formatted file can be used in the CloudFormation
    /// console and with the CloudFormation APIs.
    export_format: ?AssetBundleExportFormat = null,

    /// The include dependencies flag.
    include_all_dependencies: ?bool = null,

    /// A setting that determines whether folder members are included.
    include_folder_members: ?IncludeFolderMembers = null,

    /// The include folder memberships flag.
    include_folder_memberships: ?bool = null,

    /// The include permissions flag.
    include_permissions: ?bool = null,

    /// The include tags flag.
    include_tags: ?bool = null,

    /// Indicates the status of a job through its queuing and execution.
    ///
    /// Poll this `DescribeAssetBundleExportApi` until `JobStatus` is
    /// either `SUCCESSFUL` or `FAILED`.
    job_status: ?AssetBundleExportJobStatus = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// A list of resource ARNs that exported with the job.
    resource_arns: ?[]const []const u8 = null,

    /// The HTTP status of the response.
    status: ?i32 = null,

    /// The validation strategy that is used to export the analysis or dashboard.
    validation_strategy: ?AssetBundleExportJobValidationStrategy = null,

    /// An array of warning records that describe the analysis or dashboard that is
    /// exported.
    /// This array includes UI errors that can be skipped during the validation
    /// process.
    ///
    /// This property only appears if `StrictModeForAllResources` in
    /// `ValidationStrategy` is set to `FALSE`.
    warnings: ?[]const AssetBundleExportJobWarning = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .asset_bundle_export_job_id = "AssetBundleExportJobId",
        .aws_account_id = "AwsAccountId",
        .cloud_formation_override_property_configuration = "CloudFormationOverridePropertyConfiguration",
        .created_time = "CreatedTime",
        .download_url = "DownloadUrl",
        .errors = "Errors",
        .export_format = "ExportFormat",
        .include_all_dependencies = "IncludeAllDependencies",
        .include_folder_members = "IncludeFolderMembers",
        .include_folder_memberships = "IncludeFolderMemberships",
        .include_permissions = "IncludePermissions",
        .include_tags = "IncludeTags",
        .job_status = "JobStatus",
        .request_id = "RequestId",
        .resource_arns = "ResourceArns",
        .status = "Status",
        .validation_strategy = "ValidationStrategy",
        .warnings = "Warnings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAssetBundleExportJobInput, options: CallOptions) !DescribeAssetBundleExportJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAssetBundleExportJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/asset-bundle-export-jobs/");
    try path_buf.appendSlice(allocator, input.asset_bundle_export_job_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAssetBundleExportJobOutput {
    var result: DescribeAssetBundleExportJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeAssetBundleExportJobOutput, body, allocator);
    }
    result.status = @intCast(status);
    _ = headers;

    return result;
}

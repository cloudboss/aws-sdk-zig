const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssetBundleImportSourceDescription = @import("asset_bundle_import_source_description.zig").AssetBundleImportSourceDescription;
const AssetBundleImportJobError = @import("asset_bundle_import_job_error.zig").AssetBundleImportJobError;
const AssetBundleImportFailureAction = @import("asset_bundle_import_failure_action.zig").AssetBundleImportFailureAction;
const AssetBundleImportJobStatus = @import("asset_bundle_import_job_status.zig").AssetBundleImportJobStatus;
const AssetBundleImportJobOverrideParameters = @import("asset_bundle_import_job_override_parameters.zig").AssetBundleImportJobOverrideParameters;
const AssetBundleImportJobOverridePermissions = @import("asset_bundle_import_job_override_permissions.zig").AssetBundleImportJobOverridePermissions;
const AssetBundleImportJobOverrideTags = @import("asset_bundle_import_job_override_tags.zig").AssetBundleImportJobOverrideTags;
const AssetBundleImportJobOverrideValidationStrategy = @import("asset_bundle_import_job_override_validation_strategy.zig").AssetBundleImportJobOverrideValidationStrategy;
const AssetBundleImportJobWarning = @import("asset_bundle_import_job_warning.zig").AssetBundleImportJobWarning;

pub const DescribeAssetBundleImportJobInput = struct {
    /// The ID of the job. The job ID is set when you start a new job with a
    /// `StartAssetBundleImportJob` API call.
    asset_bundle_import_job_id: []const u8,

    /// The ID of the Amazon Web Services account the import job was executed in.
    aws_account_id: []const u8,

    pub const json_field_names = .{
        .asset_bundle_import_job_id = "AssetBundleImportJobId",
        .aws_account_id = "AwsAccountId",
    };
};

pub const DescribeAssetBundleImportJobOutput = struct {
    /// The Amazon Resource Name (ARN) for the import job.
    arn: ?[]const u8 = null,

    /// The ID of the job. The job ID is set when you start a new job with a
    /// `StartAssetBundleImportJob` API call.
    asset_bundle_import_job_id: ?[]const u8 = null,

    /// The source of the asset bundle zip file that contains the data that is
    /// imported by the
    /// job.
    asset_bundle_import_source: ?AssetBundleImportSourceDescription = null,

    /// The ID of the Amazon Web Services account the import job was executed in.
    aws_account_id: ?[]const u8 = null,

    /// The time that the import job was created.
    created_time: ?i64 = null,

    /// An array of error records that describes any failures that occurred during
    /// the export
    /// job processing.
    ///
    /// Error records accumulate while the job is still running. The complete set of
    /// error
    /// records is available after the job has completed and failed.
    errors: ?[]const AssetBundleImportJobError = null,

    /// The failure action for the import job.
    failure_action: ?AssetBundleImportFailureAction = null,

    /// Indicates the status of a job through its queuing and execution.
    ///
    /// Poll the `DescribeAssetBundleImport` API until `JobStatus` returns
    /// one of the following values:
    ///
    /// * `SUCCESSFUL`
    ///
    /// * `FAILED`
    ///
    /// * `FAILED_ROLLBACK_COMPLETED`
    ///
    /// * `FAILED_ROLLBACK_ERROR`
    job_status: ?AssetBundleImportJobStatus = null,

    /// Optional overrides that are applied to the resource configuration before
    /// import.
    override_parameters: ?AssetBundleImportJobOverrideParameters = null,

    /// Optional permission overrides that are applied to the resource configuration
    /// before
    /// import.
    override_permissions: ?AssetBundleImportJobOverridePermissions = null,

    /// Optional tag overrides that are applied to the resource configuration before
    /// import.
    override_tags: ?AssetBundleImportJobOverrideTags = null,

    /// An optional validation strategy override for all analyses and dashboards to
    /// be applied
    /// to the resource configuration before import.
    override_validation_strategy: ?AssetBundleImportJobOverrideValidationStrategy = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// An array of error records that describes any failures that occurred while an
    /// import job
    /// was attempting a rollback.
    ///
    /// Error records accumulate while the job is still running. The complete set of
    /// error
    /// records is available after the job has completed and failed.
    rollback_errors: ?[]const AssetBundleImportJobError = null,

    /// The HTTP status of the response.
    status: ?i32 = null,

    /// An array of warning records that describe all permitted errors that are
    /// encountered
    /// during the import job.
    warnings: ?[]const AssetBundleImportJobWarning = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .asset_bundle_import_job_id = "AssetBundleImportJobId",
        .asset_bundle_import_source = "AssetBundleImportSource",
        .aws_account_id = "AwsAccountId",
        .created_time = "CreatedTime",
        .errors = "Errors",
        .failure_action = "FailureAction",
        .job_status = "JobStatus",
        .override_parameters = "OverrideParameters",
        .override_permissions = "OverridePermissions",
        .override_tags = "OverrideTags",
        .override_validation_strategy = "OverrideValidationStrategy",
        .request_id = "RequestId",
        .rollback_errors = "RollbackErrors",
        .status = "Status",
        .warnings = "Warnings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAssetBundleImportJobInput, options: CallOptions) !DescribeAssetBundleImportJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAssetBundleImportJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/asset-bundle-import-jobs/");
    try path_buf.appendSlice(allocator, input.asset_bundle_import_job_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAssetBundleImportJobOutput {
    var result: DescribeAssetBundleImportJobOutput = try aws.json.parseJsonObject(
        DescribeAssetBundleImportJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    result.status = @intCast(status);
    _ = headers;

    return result;
}

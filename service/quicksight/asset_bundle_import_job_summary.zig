const AssetBundleImportFailureAction = @import("asset_bundle_import_failure_action.zig").AssetBundleImportFailureAction;
const AssetBundleImportJobStatus = @import("asset_bundle_import_job_status.zig").AssetBundleImportJobStatus;

/// A summary of the import job that includes details of the requested job's
/// configuration and its current status.
pub const AssetBundleImportJobSummary = struct {
    /// The ARN of the import job.
    arn: ?[]const u8 = null,

    /// The ID of the job. This ID is unique while the job is running. After the job
    /// is
    /// completed, you can reuse this ID for another job.
    asset_bundle_import_job_id: ?[]const u8 = null,

    /// The time that the import job was created.
    created_time: ?i64 = null,

    /// The failure action for the import job.
    failure_action: ?AssetBundleImportFailureAction = null,

    /// The current status of the import job.
    job_status: ?AssetBundleImportJobStatus = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .asset_bundle_import_job_id = "AssetBundleImportJobId",
        .created_time = "CreatedTime",
        .failure_action = "FailureAction",
        .job_status = "JobStatus",
    };
};

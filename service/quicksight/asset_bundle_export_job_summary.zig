const AssetBundleExportFormat = @import("asset_bundle_export_format.zig").AssetBundleExportFormat;
const AssetBundleExportJobStatus = @import("asset_bundle_export_job_status.zig").AssetBundleExportJobStatus;

/// A summary of the export job that includes details of the job's configuration
/// and
/// its current status.
pub const AssetBundleExportJobSummary = struct {
    /// The ARN of the export job.
    arn: ?[]const u8 = null,

    /// The ID of the export job.
    asset_bundle_export_job_id: ?[]const u8 = null,

    /// The time that the export job was created.
    created_time: ?i64 = null,

    /// The format for the export job.
    export_format: ?AssetBundleExportFormat = null,

    /// The flag that determines the inclusion of resource dependencies in the
    /// returned asset
    /// bundle.
    include_all_dependencies: bool = false,

    /// The flag that determines the inclusion of permissions associated with each
    /// resource
    /// ARN.
    include_permissions: bool = false,

    /// The flag that determines the inclusion of tags associated with each resource
    /// ARN.
    include_tags: bool = false,

    /// The current status of the export job.
    job_status: ?AssetBundleExportJobStatus = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .asset_bundle_export_job_id = "AssetBundleExportJobId",
        .created_time = "CreatedTime",
        .export_format = "ExportFormat",
        .include_all_dependencies = "IncludeAllDependencies",
        .include_permissions = "IncludePermissions",
        .include_tags = "IncludeTags",
        .job_status = "JobStatus",
    };
};

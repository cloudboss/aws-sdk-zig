const PackageImportJobType = @import("package_import_job_type.zig").PackageImportJobType;
const PackageImportJobStatus = @import("package_import_job_status.zig").PackageImportJobStatus;

/// A job to import a package version.
pub const PackageImportJob = struct {
    /// When the job was created.
    created_time: ?i64,

    /// The job's ID.
    job_id: ?[]const u8,

    /// The job's type.
    job_type: ?PackageImportJobType,

    /// When the job was updated.
    last_updated_time: ?i64,

    /// The job's status.
    status: ?PackageImportJobStatus,

    /// The job's status message.
    status_message: ?[]const u8,

    pub const json_field_names = .{
        .created_time = "CreatedTime",
        .job_id = "JobId",
        .job_type = "JobType",
        .last_updated_time = "LastUpdatedTime",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};

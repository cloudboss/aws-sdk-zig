const JobType = @import("job_type.zig").JobType;
const UpdateProgress = @import("update_progress.zig").UpdateProgress;

/// Returns information about the latest device job.
pub const LatestDeviceJob = struct {
    /// The target version of the device software.
    image_version: ?[]const u8 = null,

    /// The job's type.
    job_type: ?JobType = null,

    /// Status of the latest device job.
    status: ?UpdateProgress = null,

    pub const json_field_names = .{
        .image_version = "ImageVersion",
        .job_type = "JobType",
        .status = "Status",
    };
};

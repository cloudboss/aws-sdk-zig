const UploaderStatus = @import("uploader_status.zig").UploaderStatus;

/// The latest status of a stream’s edge to cloud uploader job.
pub const LastUploaderStatus = struct {
    /// A description of an uploader job’s latest status.
    job_status_details: ?[]const u8,

    /// The timestamp at which the uploader job was last executed and media
    /// collected to the cloud.
    last_collected_time: ?i64,

    /// The timestamp at which the uploader status was last updated.
    last_updated_time: ?i64,

    /// The status of the latest uploader job.
    uploader_status: ?UploaderStatus,

    pub const json_field_names = .{
        .job_status_details = "JobStatusDetails",
        .last_collected_time = "LastCollectedTime",
        .last_updated_time = "LastUpdatedTime",
        .uploader_status = "UploaderStatus",
    };
};

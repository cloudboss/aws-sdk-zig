const RecorderStatus = @import("recorder_status.zig").RecorderStatus;

/// The latest status of a stream's edge recording job.
pub const LastRecorderStatus = struct {
    /// A description of a recorder job’s latest status.
    job_status_details: ?[]const u8,

    /// The timestamp at which the recorder job was last executed and media stored
    /// to local disk.
    last_collected_time: ?i64,

    /// The timestamp at which the recorder status was last updated.
    last_updated_time: ?i64,

    /// The status of the latest recorder job.
    recorder_status: ?RecorderStatus,

    pub const json_field_names = .{
        .job_status_details = "JobStatusDetails",
        .last_collected_time = "LastCollectedTime",
        .last_updated_time = "LastUpdatedTime",
        .recorder_status = "RecorderStatus",
    };
};

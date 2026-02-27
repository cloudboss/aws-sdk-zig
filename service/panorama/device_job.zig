const JobType = @import("job_type.zig").JobType;

/// A job that runs on a device.
pub const DeviceJob = struct {
    /// When the job was created.
    created_time: ?i64,

    /// The ID of the target device.
    device_id: ?[]const u8,

    /// The name of the target device
    device_name: ?[]const u8,

    /// The job's ID.
    job_id: ?[]const u8,

    /// The job's type.
    job_type: ?JobType,

    pub const json_field_names = .{
        .created_time = "CreatedTime",
        .device_id = "DeviceId",
        .device_name = "DeviceName",
        .job_id = "JobId",
        .job_type = "JobType",
    };
};

/// A job for a device.
pub const Job = struct {
    /// The target device's ID.
    device_id: ?[]const u8,

    /// The job's ID.
    job_id: ?[]const u8,

    pub const json_field_names = .{
        .device_id = "DeviceId",
        .job_id = "JobId",
    };
};

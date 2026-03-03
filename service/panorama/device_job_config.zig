const OTAJobConfig = @import("ota_job_config.zig").OTAJobConfig;

/// A job's configuration.
pub const DeviceJobConfig = struct {
    /// A configuration for an over-the-air (OTA) upgrade. Required for OTA jobs.
    ota_job_config: ?OTAJobConfig = null,

    pub const json_field_names = .{
        .ota_job_config = "OTAJobConfig",
    };
};

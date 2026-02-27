const FirstBoot = @import("first_boot.zig").FirstBoot;

/// Launched instance.
pub const LaunchedInstance = struct {
    /// Launched instance EC2 ID.
    ec_2_instance_id: ?[]const u8,

    /// Launched instance first boot.
    first_boot: ?FirstBoot,

    /// Launched instance Job ID.
    job_id: ?[]const u8,

    pub const json_field_names = .{
        .ec_2_instance_id = "ec2InstanceID",
        .first_boot = "firstBoot",
        .job_id = "jobID",
    };
};

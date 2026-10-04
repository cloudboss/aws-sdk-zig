const FirstBoot = @import("first_boot.zig").FirstBoot;
const LastKnownCheck = @import("last_known_check.zig").LastKnownCheck;
const LastKnownCheckStatus = @import("last_known_check_status.zig").LastKnownCheckStatus;

/// Launched instance.
pub const LaunchedInstance = struct {
    /// Launched instance EC2 ID.
    ec_2_instance_id: ?[]const u8 = null,

    /// Launched instance first boot.
    first_boot: ?FirstBoot = null,

    /// Launched instance Job ID.
    job_id: ?[]const u8 = null,

    /// Launched instance last known checks.
    last_known_checks: ?[]const LastKnownCheck = null,

    /// Launched instance last known FSx checks status.
    last_known_fsx_checks_status: ?LastKnownCheckStatus = null,

    pub const json_field_names = .{
        .ec_2_instance_id = "ec2InstanceID",
        .first_boot = "firstBoot",
        .job_id = "jobID",
        .last_known_checks = "lastKnownChecks",
        .last_known_fsx_checks_status = "lastKnownFsxChecksStatus",
    };
};

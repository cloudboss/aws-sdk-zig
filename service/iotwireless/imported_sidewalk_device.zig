const OnboardStatus = @import("onboard_status.zig").OnboardStatus;

/// Information about a Sidewalk device that has been added to an import task.
pub const ImportedSidewalkDevice = struct {
    /// The time at which the status information was last updated.
    last_update_time: ?i64,

    /// The onboarding status of the Sidewalk device in the import task.
    onboarding_status: ?OnboardStatus,

    /// The reason for the onboarding status information for the Sidewalk device.
    onboarding_status_reason: ?[]const u8,

    /// The Sidewalk manufacturing serial number (SMSN) of the Sidewalk device.
    sidewalk_manufacturing_sn: ?[]const u8,

    pub const json_field_names = .{
        .last_update_time = "LastUpdateTime",
        .onboarding_status = "OnboardingStatus",
        .onboarding_status_reason = "OnboardingStatusReason",
        .sidewalk_manufacturing_sn = "SidewalkManufacturingSn",
    };
};

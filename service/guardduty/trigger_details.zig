const TriggerType = @import("trigger_type.zig").TriggerType;

/// Represents the reason the scan was triggered.
pub const TriggerDetails = struct {
    /// The description of the scan trigger.
    description: ?[]const u8 = null,

    /// The ID of the GuardDuty finding that triggered the malware scan.
    guard_duty_finding_id: ?[]const u8 = null,

    /// Specifies the trigger type that started the malware scan.
    trigger_type: ?TriggerType = null,

    pub const json_field_names = .{
        .description = "Description",
        .guard_duty_finding_id = "GuardDutyFindingId",
        .trigger_type = "TriggerType",
    };
};

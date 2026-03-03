const MacSystemIntegrityProtectionConfiguration = @import("mac_system_integrity_protection_configuration.zig").MacSystemIntegrityProtectionConfiguration;
const Tag = @import("tag.zig").Tag;
const MacModificationTaskState = @import("mac_modification_task_state.zig").MacModificationTaskState;
const MacModificationTaskType = @import("mac_modification_task_type.zig").MacModificationTaskType;

/// Information about a System Integrity Protection (SIP) modification task or
/// volume
/// ownership delegation task for an Amazon EC2 Mac instance.
pub const MacModificationTask = struct {
    /// The ID of the Amazon EC2 Mac instance.
    instance_id: ?[]const u8 = null,

    /// The ID of task.
    mac_modification_task_id: ?[]const u8 = null,

    /// [SIP modification tasks only] Information about the SIP
    /// configuration.
    mac_system_integrity_protection_config: ?MacSystemIntegrityProtectionConfiguration = null,

    /// The date and time the task was created, in the UTC timezone
    /// (`YYYY-MM-DDThh:mm:ss.sssZ`).
    start_time: ?i64 = null,

    /// The tags assigned to the task.
    tags: ?[]const Tag = null,

    /// The state of the task.
    task_state: ?MacModificationTaskState = null,

    /// The type of task.
    task_type: ?MacModificationTaskType = null,
};

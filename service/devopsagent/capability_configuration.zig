const TriggerFilterGroup = @import("trigger_filter_group.zig").TriggerFilterGroup;

/// Capability configuration for the AWS DevOps Agent.
pub const CapabilityConfiguration = struct {
    /// Whether the capability is enabled.
    enabled: ?bool = null,

    /// Optional trigger filter groups. Evaluated only when enabled=true; retained
    /// while the capability is disabled, so re-enabling restores the prior trigger
    /// behavior.
    trigger_filter_groups: ?[]const TriggerFilterGroup = null,

    pub const json_field_names = .{
        .enabled = "enabled",
        .trigger_filter_groups = "triggerFilterGroups",
    };
};

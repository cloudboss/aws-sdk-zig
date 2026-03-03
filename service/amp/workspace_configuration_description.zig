const LimitsPerLabelSet = @import("limits_per_label_set.zig").LimitsPerLabelSet;
const WorkspaceConfigurationStatus = @import("workspace_configuration_status.zig").WorkspaceConfigurationStatus;

/// This structure contains the description of the workspace configuration.
pub const WorkspaceConfigurationDescription = struct {
    /// This is an array of structures, where each structure displays one label sets
    /// for the workspace and the limits for that label set.
    limits_per_label_set: ?[]const LimitsPerLabelSet = null,

    /// This field displays how many days that metrics are retained in the
    /// workspace.
    retention_period_in_days: ?i32 = null,

    /// This structure displays the current status of the workspace configuration,
    /// and might also contain a reason for that status.
    status: WorkspaceConfigurationStatus,

    pub const json_field_names = .{
        .limits_per_label_set = "limitsPerLabelSet",
        .retention_period_in_days = "retentionPeriodInDays",
        .status = "status",
    };
};

/// Retrieves the details of maintenance actions that are pending.
pub const PendingMaintenanceActionDetails = struct {
    /// Displays the specific action of a pending maintenance action.
    action: []const u8,

    /// Displays the date of the maintenance window when the action is applied.
    /// The maintenance action is applied to the resource during its first
    /// maintenance window after this date.
    /// If this date is specified, any `NEXT_MAINTENANCE`
    /// `optInType` requests are ignored.
    auto_applied_after_date: ?[]const u8,

    /// Displays the effective date when the pending maintenance action is applied
    /// to the resource.
    current_apply_date: ?[]const u8,

    /// Displays a description providing more detail about the maintenance action.
    description: ?[]const u8,

    /// Displays the date when the maintenance action is automatically applied.
    /// The maintenance action is applied to the resource on this date regardless of
    /// the maintenance window for the resource.
    /// If this date is specified, any `IMMEDIATE`
    /// `optInType` requests are ignored.
    forced_apply_date: ?[]const u8,

    /// Displays the type of `optInType` request that has been received for the
    /// resource.
    opt_in_status: ?[]const u8,

    pub const json_field_names = .{
        .action = "action",
        .auto_applied_after_date = "autoAppliedAfterDate",
        .current_apply_date = "currentApplyDate",
        .description = "description",
        .forced_apply_date = "forcedApplyDate",
        .opt_in_status = "optInStatus",
    };
};

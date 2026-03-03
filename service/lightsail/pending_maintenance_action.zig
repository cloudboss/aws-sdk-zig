/// Describes a pending database maintenance action.
pub const PendingMaintenanceAction = struct {
    /// The type of pending database maintenance action.
    action: ?[]const u8 = null,

    /// The effective date of the pending database maintenance action.
    current_apply_date: ?i64 = null,

    /// Additional detail about the pending database maintenance action.
    description: ?[]const u8 = null,

    pub const json_field_names = .{
        .action = "action",
        .current_apply_date = "currentApplyDate",
        .description = "description",
    };
};

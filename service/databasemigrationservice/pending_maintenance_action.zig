/// Describes a maintenance action pending for an DMS resource, including when
/// and how it
/// will be applied. This data type is a response element to the
/// `DescribePendingMaintenanceActions` operation.
pub const PendingMaintenanceAction = struct {
    /// The type of pending maintenance action that is available for the resource.
    action: ?[]const u8,

    /// The date of the maintenance window when the action is to be applied. The
    /// maintenance
    /// action is applied to the resource during its first maintenance window after
    /// this date. If
    /// this date is specified, any `next-maintenance` opt-in requests are
    /// ignored.
    auto_applied_after_date: ?i64,

    /// The effective date when the pending maintenance action will be applied to
    /// the resource.
    /// This date takes into account opt-in requests received from the
    /// `ApplyPendingMaintenanceAction` API operation, and also the
    /// `AutoAppliedAfterDate` and `ForcedApplyDate` parameter values.
    /// This value is blank if an opt-in request has not been received and nothing
    /// has been
    /// specified for `AutoAppliedAfterDate` or `ForcedApplyDate`.
    current_apply_date: ?i64,

    /// A description providing more detail about the maintenance action.
    description: ?[]const u8,

    /// The date when the maintenance action will be automatically applied. The
    /// maintenance
    /// action is applied to the resource on this date regardless of the maintenance
    /// window for the
    /// resource. If this date is specified, any `immediate` opt-in requests are
    /// ignored.
    forced_apply_date: ?i64,

    /// The type of opt-in request that has been received for the resource.
    opt_in_status: ?[]const u8,

    pub const json_field_names = .{
        .action = "Action",
        .auto_applied_after_date = "AutoAppliedAfterDate",
        .current_apply_date = "CurrentApplyDate",
        .description = "Description",
        .forced_apply_date = "ForcedApplyDate",
        .opt_in_status = "OptInStatus",
    };
};

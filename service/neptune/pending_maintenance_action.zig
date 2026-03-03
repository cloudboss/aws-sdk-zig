/// Provides information about a pending maintenance action for a resource.
pub const PendingMaintenanceAction = struct {
    /// The type of pending maintenance action that is available for the resource.
    action: ?[]const u8 = null,

    /// The date of the maintenance window when the action is applied. The
    /// maintenance action is
    /// applied to the resource during its first maintenance window after this date.
    /// If this date is
    /// specified, any `next-maintenance` opt-in requests are ignored.
    auto_applied_after_date: ?i64 = null,

    /// The effective date when the pending maintenance action is applied to the
    /// resource. This
    /// date takes into account opt-in requests received from the
    /// ApplyPendingMaintenanceAction API, the `AutoAppliedAfterDate`, and the
    /// `ForcedApplyDate`. This value is blank if an opt-in request has not been
    /// received
    /// and nothing has been specified as `AutoAppliedAfterDate` or
    /// `ForcedApplyDate`.
    current_apply_date: ?i64 = null,

    /// A description providing more detail about the maintenance action.
    description: ?[]const u8 = null,

    /// The date when the maintenance action is automatically applied. The
    /// maintenance action is
    /// applied to the resource on this date regardless of the maintenance window
    /// for the resource. If
    /// this date is specified, any `immediate` opt-in requests are ignored.
    forced_apply_date: ?i64 = null,

    /// Indicates the type of opt-in request that has been received for the
    /// resource.
    opt_in_status: ?[]const u8 = null,
};

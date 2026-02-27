/// Provides information about a pending maintenance action for a resource.
pub const PendingMaintenanceAction = struct {
    /// The type of pending maintenance action that is available for the resource.
    ///
    /// For more information about maintenance actions, see [Maintaining a DB
    /// instance](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_UpgradeDBInstance.Maintenance.html).
    ///
    /// Valid Values:
    ///
    /// * `ca-certificate-rotation`
    /// * `db-upgrade`
    /// * `hardware-maintenance`
    /// * `os-upgrade`
    /// * `system-update`
    ///
    /// For more information about these actions, see [Maintenance actions for
    /// Amazon
    /// Aurora](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_UpgradeDBInstance.Maintenance.html#maintenance-actions-aurora) or [Maintenance actions for Amazon RDS](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_UpgradeDBInstance.Maintenance.html#maintenance-actions-rds).
    action: ?[]const u8,

    /// The date of the maintenance window when the action is applied. The
    /// maintenance action is applied to the resource during its first maintenance
    /// window after this date.
    auto_applied_after_date: ?i64,

    /// The effective date when the pending maintenance action is applied to the
    /// resource. This date takes into account opt-in requests received from the
    /// `ApplyPendingMaintenanceAction` API, the `AutoAppliedAfterDate`, and the
    /// `ForcedApplyDate`. This value is blank if an opt-in request has not been
    /// received and nothing has been specified as `AutoAppliedAfterDate` or
    /// `ForcedApplyDate`.
    current_apply_date: ?i64,

    /// A description providing more detail about the maintenance action.
    description: ?[]const u8,

    /// The date when the maintenance action is automatically applied.
    ///
    /// On this date, the maintenance action is applied to the resource as soon as
    /// possible, regardless of the maintenance window for the resource. There might
    /// be a delay of one or more days from this date before the maintenance action
    /// is applied.
    forced_apply_date: ?i64,

    /// Indicates the type of opt-in request that has been received for the
    /// resource.
    opt_in_status: ?[]const u8,
};

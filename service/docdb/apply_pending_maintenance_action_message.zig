/// Represents the input to ApplyPendingMaintenanceAction.
pub const ApplyPendingMaintenanceActionMessage = struct {
    /// The pending maintenance action to apply to this resource.
    ///
    /// Valid values: `system-update`, `db-upgrade`
    apply_action: []const u8,

    /// A value that specifies the type of opt-in request or undoes an
    /// opt-in request. An opt-in request of type `immediate`
    /// can't be undone.
    ///
    /// Valid values:
    ///
    /// * `immediate` - Apply the maintenance action
    /// immediately.
    ///
    /// * `next-maintenance` - Apply the maintenance
    /// action during the next maintenance window for the resource.
    ///
    /// * `undo-opt-in` - Cancel any existing
    /// `next-maintenance` opt-in requests.
    opt_in_type: []const u8,

    /// The Amazon Resource Name (ARN) of the resource that the pending
    /// maintenance action applies to.
    resource_identifier: []const u8,
};

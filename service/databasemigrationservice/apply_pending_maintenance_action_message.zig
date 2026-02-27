pub const ApplyPendingMaintenanceActionMessage = struct {
    /// The pending maintenance action to apply to this resource.
    ///
    /// Valid values: `os-upgrade`, `system-update`,
    /// `db-upgrade`, `os-patch`
    apply_action: []const u8,

    /// A value that specifies the type of opt-in request, or undoes an opt-in
    /// request. You
    /// can't undo an opt-in request of type `immediate`.
    ///
    /// Valid values:
    ///
    /// * `immediate` - Apply the maintenance action immediately.
    ///
    /// * `next-maintenance` - Apply the maintenance action during the next
    /// maintenance window for the resource.
    ///
    /// * `undo-opt-in` - Cancel any existing `next-maintenance` opt-in
    /// requests.
    opt_in_type: []const u8,

    /// The Amazon Resource Name (ARN) of the DMS resource that the pending
    /// maintenance action
    /// applies to.
    replication_instance_arn: []const u8,

    pub const json_field_names = .{
        .apply_action = "ApplyAction",
        .opt_in_type = "OptInType",
        .replication_instance_arn = "ReplicationInstanceArn",
    };
};

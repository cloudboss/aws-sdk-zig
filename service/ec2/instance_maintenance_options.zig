const InstanceAutoRecoveryState = @import("instance_auto_recovery_state.zig").InstanceAutoRecoveryState;
const InstanceRebootMigrationState = @import("instance_reboot_migration_state.zig").InstanceRebootMigrationState;

/// The maintenance options for the instance.
pub const InstanceMaintenanceOptions = struct {
    /// Provides information on the current automatic recovery behavior of your
    /// instance.
    auto_recovery: ?InstanceAutoRecoveryState,

    /// Specifies whether to attempt reboot migration during a user-initiated reboot
    /// of an
    /// instance that has a scheduled `system-reboot` event:
    ///
    /// * `default` - Amazon EC2 attempts to migrate the instance to
    /// new hardware (reboot migration). If successful, the `system-reboot`
    /// event is cleared. If unsuccessful, an in-place reboot occurs and the event
    /// remains scheduled.
    ///
    /// * `disabled` - Amazon EC2 keeps the instance on the same
    /// hardware (in-place reboot). The `system-reboot` event remains
    /// scheduled.
    ///
    /// This setting only applies to supported instances that have a scheduled
    /// reboot event.
    /// For more information, see [Enable or disable reboot
    /// migration](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/schedevents_actions_reboot.html#reboot-migration) in the
    /// *Amazon EC2 User Guide*.
    reboot_migration: ?InstanceRebootMigrationState,
};

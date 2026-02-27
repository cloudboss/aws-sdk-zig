const DesiredConfiguration = @import("desired_configuration.zig").DesiredConfiguration;
const RefreshPreferences = @import("refresh_preferences.zig").RefreshPreferences;
const InstanceRefreshProgressDetails = @import("instance_refresh_progress_details.zig").InstanceRefreshProgressDetails;
const RollbackDetails = @import("rollback_details.zig").RollbackDetails;
const InstanceRefreshStatus = @import("instance_refresh_status.zig").InstanceRefreshStatus;
const RefreshStrategy = @import("refresh_strategy.zig").RefreshStrategy;

/// Describes an instance refresh for an Auto Scaling group.
pub const InstanceRefresh = struct {
    /// The name of the Auto Scaling group.
    auto_scaling_group_name: ?[]const u8,

    /// Describes the desired configuration for the instance refresh.
    desired_configuration: ?DesiredConfiguration,

    /// The date and time at which the instance refresh ended.
    end_time: ?i64,

    /// The instance refresh ID.
    instance_refresh_id: ?[]const u8,

    /// The number of instances remaining to update before the instance refresh is
    /// complete.
    ///
    /// If you roll back the instance refresh, `InstancesToUpdate` shows you
    /// the number of instances that were not yet updated by the instance refresh.
    /// Therefore, these instances don't need to be replaced as part of the
    /// rollback.
    instances_to_update: ?i32,

    /// The percentage of the instance refresh that is complete. For each instance
    /// replacement, Amazon EC2 Auto Scaling tracks the instance's health status and
    /// warm-up time. When the
    /// instance's health status changes to healthy and the specified warm-up time
    /// passes, the
    /// instance is considered updated and is added to the percentage complete.
    ///
    /// `PercentageComplete` does not include instances that are replaced
    /// during a rollback. This value gradually goes back down to zero during a
    /// rollback.
    percentage_complete: ?i32,

    /// The preferences for an instance refresh.
    preferences: ?RefreshPreferences,

    /// Additional progress details for an Auto Scaling group that has a warm pool.
    progress_details: ?InstanceRefreshProgressDetails,

    /// The rollback details.
    rollback_details: ?RollbackDetails,

    /// The date and time at which the instance refresh began.
    start_time: ?i64,

    /// The current status for the instance refresh operation:
    ///
    /// * `Pending` - The request was created, but the instance refresh has
    /// not started.
    ///
    /// * `InProgress` - An instance refresh is in progress.
    ///
    /// * `Successful` - An instance refresh completed successfully.
    ///
    /// * `Failed` - An instance refresh failed to complete. You can
    /// troubleshoot using the status reason and the scaling activities.
    ///
    /// * `Cancelling` - An ongoing instance refresh is being
    /// cancelled.
    ///
    /// * `Cancelled` - The instance refresh is cancelled.
    ///
    /// * `RollbackInProgress` - An instance refresh is being rolled
    /// back.
    ///
    /// * `RollbackFailed` - The rollback failed to complete. You can
    /// troubleshoot using the status reason and the scaling activities.
    ///
    /// * `RollbackSuccessful` - The rollback completed successfully.
    ///
    /// * `Baking` - Waiting the specified bake time after an instance refresh has
    ///   finished updating instances.
    status: ?InstanceRefreshStatus,

    /// The explanation for the specific status assigned to this operation.
    status_reason: ?[]const u8,

    /// The strategy to use for the instance refresh. This determines how instances
    /// in the Auto Scaling group are
    /// updated. Default is Rolling.
    ///
    /// * `Rolling` – Terminates instances and launches replacements in batches
    ///
    /// * `ReplaceRootVolume` – Updates instances by replacing only the root volume
    ///   without terminating the instance
    strategy: ?RefreshStrategy,
};

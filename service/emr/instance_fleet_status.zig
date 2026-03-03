const InstanceFleetState = @import("instance_fleet_state.zig").InstanceFleetState;
const InstanceFleetStateChangeReason = @import("instance_fleet_state_change_reason.zig").InstanceFleetStateChangeReason;
const InstanceFleetTimeline = @import("instance_fleet_timeline.zig").InstanceFleetTimeline;

/// The status of the instance fleet.
///
/// The instance fleet configuration is available only in Amazon EMR releases
/// 4.8.0 and later, excluding 5.0.x versions.
pub const InstanceFleetStatus = struct {
    /// A code representing the instance fleet status.
    ///
    /// * `PROVISIONING`—The instance fleet is provisioning Amazon EC2
    /// resources and is not yet ready to run jobs.
    ///
    /// * `BOOTSTRAPPING`—Amazon EC2 instances and other resources have
    /// been provisioned and the bootstrap actions specified for the instances are
    /// underway.
    ///
    /// * `RUNNING`—Amazon EC2 instances and other resources are running.
    /// They are either executing jobs or waiting to execute jobs.
    ///
    /// * `RESIZING`—A resize operation is underway. Amazon EC2 instances
    /// are either being added or removed.
    ///
    /// * `SUSPENDED`—A resize operation could not complete. Existing Amazon EC2
    ///   instances are running, but instances can't be added or removed.
    ///
    /// * `TERMINATING`—The instance fleet is terminating Amazon EC2
    /// instances.
    ///
    /// * `TERMINATED`—The instance fleet is no longer active, and all Amazon EC2
    ///   instances have been terminated.
    state: ?InstanceFleetState = null,

    /// Provides status change reason details for the instance fleet.
    state_change_reason: ?InstanceFleetStateChangeReason = null,

    /// Provides historical timestamps for the instance fleet, including the time of
    /// creation,
    /// the time it became ready to run jobs, and the time of termination.
    timeline: ?InstanceFleetTimeline = null,

    pub const json_field_names = .{
        .state = "State",
        .state_change_reason = "StateChangeReason",
        .timeline = "Timeline",
    };
};

const SlurmHealthComponent = @import("slurm_health_component.zig").SlurmHealthComponent;
const SlurmHealthReason = @import("slurm_health_reason.zig").SlurmHealthReason;
const SlurmHealthStatus = @import("slurm_health_status.zig").SlurmHealthStatus;

/// Metadata information about the health of a Slurm component on the controller
/// node of a HyperPod cluster.
pub const SlurmHealthMetadata = struct {
    /// The Slurm component that the health information describes. The valid value
    /// is `Slurmdbd`, the Slurm accounting daemon.
    component: SlurmHealthComponent,

    /// The reason the component is unhealthy. Valid values:
    ///
    /// * `DaemonDown`: The daemon is not running, so job accounting records are not
    ///   being written.
    /// * `DaemonDisabled`: The daemon is running and its accounting database is
    ///   responding, but the daemon is not enabled to start automatically. Job
    ///   accounting stops the next time the controller node restarts.
    /// * `DbUnreachable`: The daemon is running, but its accounting database did
    ///   not respond. Job accounting records might not be written.
    ///
    /// This field is omitted when the component is healthy.
    reason: ?SlurmHealthReason = null,

    /// The health of the component. Valid values are `Healthy` and `Unhealthy`.
    status: SlurmHealthStatus,

    pub const json_field_names = .{
        .component = "Component",
        .reason = "Reason",
        .status = "Status",
    };
};

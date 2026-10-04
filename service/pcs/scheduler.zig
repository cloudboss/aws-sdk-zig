const SchedulerType = @import("scheduler_type.zig").SchedulerType;

/// The cluster management and job scheduling software associated with the
/// cluster.
pub const Scheduler = struct {
    /// The software PCS uses to manage cluster scaling and job scheduling.
    @"type": SchedulerType,

    /// The version of the specified scheduling software that PCS uses to manage
    /// cluster scaling and job scheduling. You can update this version using the
    /// `UpdateCluster` API action. For more information, see [Updating the
    /// scheduler version on a
    /// cluster](https://docs.aws.amazon.com/pcs/latest/userguide/working-with_clusters_version_update.html) and [Slurm versions in PCS](https://docs.aws.amazon.com/pcs/latest/userguide/slurm-versions.html) in the *PCS User Guide*.
    ///
    /// Valid Values: `23.11 | 24.05 | 24.11 | 25.05 | 25.11 | 26.05`
    version: []const u8,

    pub const json_field_names = .{
        .@"type" = "type",
        .version = "version",
    };
};

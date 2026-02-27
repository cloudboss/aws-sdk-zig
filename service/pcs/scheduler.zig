const SchedulerType = @import("scheduler_type.zig").SchedulerType;

/// The cluster management and job scheduling software associated with the
/// cluster.
pub const Scheduler = struct {
    /// The software PCS uses to manage cluster scaling and job scheduling.
    type: SchedulerType,

    /// The version of the specified scheduling software that PCS uses to manage
    /// cluster scaling and job scheduling. For more information, see [Slurm
    /// versions in
    /// PCS](https://docs.aws.amazon.com/pcs/latest/userguide/slurm-versions.html)
    /// in the *PCS User Guide*.
    ///
    /// Valid Values: `23.11 | 24.05 | 24.11`
    version: []const u8,

    pub const json_field_names = .{
        .type = "type",
        .version = "version",
    };
};

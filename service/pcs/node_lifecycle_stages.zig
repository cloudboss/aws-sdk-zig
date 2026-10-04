const NodeLifecycleScript = @import("node_lifecycle_script.zig").NodeLifecycleScript;

/// The stages of a compute node's lifecycle where you can configure scripts to
/// run.
pub const NodeLifecycleStages = struct {
    /// The scripts to run after PCS finishes setting up the compute node and before
    /// the Slurm daemon (`slurmd`) starts. Use this stage for tasks that must
    /// complete before the node accepts jobs, such as mounting shared storage,
    /// configuring networking, or installing software packages.
    node_bootstrapped: ?[]const NodeLifecycleScript = null,

    /// The scripts to run after the Slurm daemon (`slurmd`) starts and the compute
    /// node registers with the Slurm controller. Use this stage for tasks that
    /// require Slurm to be running, such as running Slurm commands.
    node_ready: ?[]const NodeLifecycleScript = null,

    pub const json_field_names = .{
        .node_bootstrapped = "nodeBootstrapped",
        .node_ready = "nodeReady",
    };
};

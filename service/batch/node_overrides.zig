const NodePropertyOverride = @import("node_property_override.zig").NodePropertyOverride;

/// An object that represents any node overrides to a job definition that's used
/// in a
/// [SubmitJob](https://docs.aws.amazon.com/batch/latest/APIReference/API_SubmitJob.html) API
/// operation.
///
/// This parameter isn't applicable to jobs that are running on Fargate
/// resources. Don't
/// provide it for these jobs. Rather, use `containerOverrides` instead.
pub const NodeOverrides = struct {
    /// The node property overrides for the job.
    node_property_overrides: ?[]const NodePropertyOverride = null,

    /// The number of nodes to use with a multi-node parallel job. This value
    /// overrides the number
    /// of nodes that are specified in the job definition. To use this override, you
    /// must meet the
    /// following conditions:
    ///
    /// * There must be at least one node range in your job definition that has an
    ///   open upper
    /// boundary, such as `:` or `n:`.
    ///
    /// * The lower boundary of the node range that's specified in the job
    ///   definition must be fewer
    /// than the number of nodes specified in the override.
    ///
    /// * The main node index that's specified in the job definition must be fewer
    ///   than the number
    /// of nodes specified in the override.
    num_nodes: ?i32 = null,

    pub const json_field_names = .{
        .node_property_overrides = "nodePropertyOverrides",
        .num_nodes = "numNodes",
    };
};

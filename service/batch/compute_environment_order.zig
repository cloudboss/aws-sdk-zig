/// The order that compute environments are tried in for job placement within a
/// queue. Compute
/// environments are tried in ascending order. For example, if two compute
/// environments are
/// associated with a job queue, the compute environment with a lower order
/// integer value is tried
/// for job placement first. Compute environments must be in the `VALID` state
/// before you
/// can associate them with a job queue. All of the compute environments must be
/// either EC2
/// (`EC2` or `SPOT`) or Fargate (`FARGATE` or
/// `FARGATE_SPOT`); Amazon EC2 and Fargate compute environments can't be mixed.
///
/// All compute environments that are associated with a job queue must share the
/// same
/// architecture. Batch doesn't support mixing compute environment architecture
/// types in a single
/// job queue.
pub const ComputeEnvironmentOrder = struct {
    /// The Amazon Resource Name (ARN) of the compute environment.
    compute_environment: []const u8,

    /// The order of the compute environment. Compute environments are tried in
    /// ascending order. For
    /// example, if two compute environments are associated with a job queue, the
    /// compute environment
    /// with a lower `order` integer value is tried for job placement first.
    order: i32,

    pub const json_field_names = .{
        .compute_environment = "computeEnvironment",
        .order = "order",
    };
};

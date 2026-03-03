const ClusterStatus = @import("cluster_status.zig").ClusterStatus;

/// Lists a summary of the properties of a SageMaker HyperPod cluster.
pub const ClusterSummary = struct {
    /// The Amazon Resource Name (ARN) of the SageMaker HyperPod cluster.
    cluster_arn: []const u8,

    /// The name of the SageMaker HyperPod cluster.
    cluster_name: []const u8,

    /// The status of the SageMaker HyperPod cluster.
    cluster_status: ClusterStatus,

    /// The time when the SageMaker HyperPod cluster is created.
    creation_time: i64,

    /// A list of Amazon Resource Names (ARNs) of the training plans associated with
    /// this cluster.
    ///
    /// For more information about how to reserve GPU capacity for your SageMaker
    /// HyperPod clusters using Amazon SageMaker Training Plan, see `
    /// [CreateTrainingPlan](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateTrainingPlan.html) `.
    training_plan_arns: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .cluster_arn = "ClusterArn",
        .cluster_name = "ClusterName",
        .cluster_status = "ClusterStatus",
        .creation_time = "CreationTime",
        .training_plan_arns = "TrainingPlanArns",
    };
};

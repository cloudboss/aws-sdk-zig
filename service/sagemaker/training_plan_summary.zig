const ReservedCapacitySummary = @import("reserved_capacity_summary.zig").ReservedCapacitySummary;
const TrainingPlanStatus = @import("training_plan_status.zig").TrainingPlanStatus;
const SageMakerResourceName = @import("sage_maker_resource_name.zig").SageMakerResourceName;

/// Details of the training plan.
///
/// For more information about how to reserve GPU capacity for your SageMaker
/// HyperPod clusters using Amazon SageMaker Training Plan, see `
/// [CreateTrainingPlan](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateTrainingPlan.html) `.
pub const TrainingPlanSummary = struct {
    /// The number of instances currently available for use in this training plan.
    available_instance_count: ?i32,

    /// The currency code for the upfront fee (e.g., USD).
    currency_code: ?[]const u8,

    /// The number of whole hours in the total duration for this training plan.
    duration_hours: ?i64,

    /// The additional minutes beyond whole hours in the total duration for this
    /// training plan.
    duration_minutes: ?i64,

    /// The end time of the training plan.
    end_time: ?i64,

    /// The number of instances currently in use from this training plan.
    in_use_instance_count: ?i32,

    /// A list of reserved capacities associated with this training plan, including
    /// details such as instance types, counts, and availability zones.
    reserved_capacity_summaries: ?[]const ReservedCapacitySummary,

    /// The start time of the training plan.
    start_time: ?i64,

    /// The current status of the training plan (e.g., Pending, Active, Expired). To
    /// see the complete list of status values available for a training plan, refer
    /// to the `Status` attribute within the `
    /// [TrainingPlanSummary](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_TrainingPlanSummary.html) ` object.
    status: TrainingPlanStatus,

    /// A message providing additional information about the current status of the
    /// training plan.
    status_message: ?[]const u8,

    /// The target resources (e.g., training jobs, HyperPod clusters, Endpoints)
    /// that can use this training plan.
    ///
    /// Training plans are specific to their target resource.
    ///
    /// * A training plan designed for SageMaker training jobs can only be used to
    ///   schedule and run training jobs.
    /// * A training plan for HyperPod clusters can be used exclusively to provide
    ///   compute resources to a cluster's instance group.
    /// * A training plan for SageMaker endpoints can be used exclusively to provide
    ///   compute resources to SageMaker endpoints for model deployment.
    target_resources: ?[]const SageMakerResourceName,

    /// The total number of instances reserved in this training plan.
    total_instance_count: ?i32,

    /// The total number of UltraServers allocated to this training plan.
    total_ultra_server_count: ?i32,

    /// The Amazon Resource Name (ARN); of the training plan.
    training_plan_arn: []const u8,

    /// The name of the training plan.
    training_plan_name: []const u8,

    /// The upfront fee for the training plan.
    upfront_fee: ?[]const u8,

    pub const json_field_names = .{
        .available_instance_count = "AvailableInstanceCount",
        .currency_code = "CurrencyCode",
        .duration_hours = "DurationHours",
        .duration_minutes = "DurationMinutes",
        .end_time = "EndTime",
        .in_use_instance_count = "InUseInstanceCount",
        .reserved_capacity_summaries = "ReservedCapacitySummaries",
        .start_time = "StartTime",
        .status = "Status",
        .status_message = "StatusMessage",
        .target_resources = "TargetResources",
        .total_instance_count = "TotalInstanceCount",
        .total_ultra_server_count = "TotalUltraServerCount",
        .training_plan_arn = "TrainingPlanArn",
        .training_plan_name = "TrainingPlanName",
        .upfront_fee = "UpfrontFee",
    };
};

const ReservedCapacityOffering = @import("reserved_capacity_offering.zig").ReservedCapacityOffering;
const SageMakerResourceName = @import("sage_maker_resource_name.zig").SageMakerResourceName;

/// Details about a training plan offering.
///
/// For more information about how to reserve GPU capacity for your SageMaker
/// HyperPod clusters using Amazon SageMaker Training Plan, see `
/// [CreateTrainingPlan](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateTrainingPlan.html) `.
pub const TrainingPlanOffering = struct {
    /// The currency code for the upfront fee (e.g., USD).
    currency_code: ?[]const u8 = null,

    /// The number of whole hours in the total duration for this training plan
    /// offering.
    duration_hours: ?i64 = null,

    /// The additional minutes beyond whole hours in the total duration for this
    /// training plan offering.
    duration_minutes: ?i64 = null,

    /// The requested end time that the user specified when searching for the
    /// training plan offering.
    requested_end_time_before: ?i64 = null,

    /// The requested start time that the user specified when searching for the
    /// training plan offering.
    requested_start_time_after: ?i64 = null,

    /// A list of reserved capacity offerings associated with this training plan
    /// offering.
    reserved_capacity_offerings: ?[]const ReservedCapacityOffering = null,

    /// The target resources (e.g., SageMaker Training Jobs, SageMaker HyperPod,
    /// SageMaker Endpoints) for this training plan offering.
    ///
    /// Training plans are specific to their target resource.
    ///
    /// * A training plan designed for SageMaker training jobs can only be used to
    ///   schedule and run training jobs.
    /// * A training plan for HyperPod clusters can be used exclusively to provide
    ///   compute resources to a cluster's instance group.
    /// * A training plan for SageMaker endpoints can be used exclusively to provide
    ///   compute resources to SageMaker endpoints for model deployment.
    target_resources: []const SageMakerResourceName,

    /// The unique identifier for this training plan offering.
    training_plan_offering_id: []const u8,

    /// The upfront fee for this training plan offering.
    upfront_fee: ?[]const u8 = null,

    pub const json_field_names = .{
        .currency_code = "CurrencyCode",
        .duration_hours = "DurationHours",
        .duration_minutes = "DurationMinutes",
        .requested_end_time_before = "RequestedEndTimeBefore",
        .requested_start_time_after = "RequestedStartTimeAfter",
        .reserved_capacity_offerings = "ReservedCapacityOfferings",
        .target_resources = "TargetResources",
        .training_plan_offering_id = "TrainingPlanOfferingId",
        .upfront_fee = "UpfrontFee",
    };
};

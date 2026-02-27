const CpuVendorArchitecture = @import("cpu_vendor_architecture.zig").CpuVendorArchitecture;
const EnhancedInfrastructureMetrics = @import("enhanced_infrastructure_metrics.zig").EnhancedInfrastructureMetrics;
const ExternalMetricsPreference = @import("external_metrics_preference.zig").ExternalMetricsPreference;
const InferredWorkloadTypesPreference = @import("inferred_workload_types_preference.zig").InferredWorkloadTypesPreference;
const LookBackPeriodPreference = @import("look_back_period_preference.zig").LookBackPeriodPreference;
const EffectivePreferredResource = @import("effective_preferred_resource.zig").EffectivePreferredResource;
const InstanceSavingsEstimationMode = @import("instance_savings_estimation_mode.zig").InstanceSavingsEstimationMode;
const UtilizationPreference = @import("utilization_preference.zig").UtilizationPreference;

/// Describes the effective recommendation preferences for a resource.
pub const EffectiveRecommendationPreferences = struct {
    /// Describes the CPU vendor and architecture for an instance or Amazon EC2 Auto
    /// Scaling group
    /// recommendations.
    ///
    /// For example, when you specify `AWS_ARM64` with:
    ///
    /// * A GetEC2InstanceRecommendations or GetAutoScalingGroupRecommendations
    ///   request, Compute Optimizer
    /// returns recommendations that consist of Graviton instance types only.
    ///
    /// * A GetEC2RecommendationProjectedMetrics request, Compute Optimizer returns
    ///   projected utilization metrics for Graviton instance type
    /// recommendations only.
    ///
    /// * A ExportEC2InstanceRecommendations or
    ///   ExportAutoScalingGroupRecommendations request, Compute Optimizer
    /// exports recommendations that consist of Graviton instance types only.
    cpu_vendor_architectures: ?[]const CpuVendorArchitecture,

    /// Describes the activation status of the enhanced infrastructure metrics
    /// preference.
    ///
    /// A status of `Active` confirms that the preference is applied in the latest
    /// recommendation refresh, and a status of `Inactive` confirms that it's not
    /// yet
    /// applied to recommendations.
    ///
    /// For more information, see [Enhanced
    /// infrastructure
    /// metrics](https://docs.aws.amazon.com/compute-optimizer/latest/ug/enhanced-infrastructure-metrics.html) in the *Compute Optimizer User
    /// Guide*.
    enhanced_infrastructure_metrics: ?EnhancedInfrastructureMetrics,

    /// An object that describes the external metrics recommendation preference.
    ///
    /// If the preference is applied in the latest recommendation refresh, an object
    /// with a
    /// valid `source` value appears in the response. If the preference isn't
    /// applied
    /// to the recommendations already, then this object doesn't appear in the
    /// response.
    external_metrics_preference: ?ExternalMetricsPreference,

    /// Describes the activation status of the inferred workload types preference.
    ///
    /// A status of `Active` confirms that the preference is applied in the latest
    /// recommendation refresh. A status of `Inactive` confirms that it's not yet
    /// applied to recommendations.
    inferred_workload_types: ?InferredWorkloadTypesPreference,

    /// The number of days the utilization metrics of the Amazon Web Services
    /// resource are analyzed.
    look_back_period: ?LookBackPeriodPreference,

    /// The resource type values that are considered as candidates when generating
    /// rightsizing recommendations.
    preferred_resources: ?[]const EffectivePreferredResource,

    /// Describes the savings estimation mode applied for calculating savings
    /// opportunity for a resource.
    savings_estimation_mode: ?InstanceSavingsEstimationMode,

    /// The resource’s CPU and memory utilization preferences, such as threshold and
    /// headroom, that
    /// are used to generate rightsizing recommendations.
    ///
    /// This preference is only available for the Amazon EC2 instance resource type.
    utilization_preferences: ?[]const UtilizationPreference,

    pub const json_field_names = .{
        .cpu_vendor_architectures = "cpuVendorArchitectures",
        .enhanced_infrastructure_metrics = "enhancedInfrastructureMetrics",
        .external_metrics_preference = "externalMetricsPreference",
        .inferred_workload_types = "inferredWorkloadTypes",
        .look_back_period = "lookBackPeriod",
        .preferred_resources = "preferredResources",
        .savings_estimation_mode = "savingsEstimationMode",
        .utilization_preferences = "utilizationPreferences",
    };
};

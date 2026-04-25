const EnhancedInfrastructureMetrics = @import("enhanced_infrastructure_metrics.zig").EnhancedInfrastructureMetrics;
const ExternalMetricsPreference = @import("external_metrics_preference.zig").ExternalMetricsPreference;
const InferredWorkloadTypesPreference = @import("inferred_workload_types_preference.zig").InferredWorkloadTypesPreference;
const LookBackPeriodPreference = @import("look_back_period_preference.zig").LookBackPeriodPreference;
const EffectivePreferredResource = @import("effective_preferred_resource.zig").EffectivePreferredResource;
const ResourceType = @import("resource_type.zig").ResourceType;
const SavingsEstimationMode = @import("savings_estimation_mode.zig").SavingsEstimationMode;
const Scope = @import("scope.zig").Scope;
const UtilizationPreference = @import("utilization_preference.zig").UtilizationPreference;

/// Describes a recommendation preference.
pub const RecommendationPreferencesDetail = struct {
    /// The status of the enhanced infrastructure metrics recommendation preference.
    ///
    /// When the recommendations page is refreshed, a status of `Active` confirms
    /// that the preference is applied to the recommendations, and a status of
    /// `Inactive` confirms that the preference isn't yet applied to
    /// recommendations.
    ///
    /// For more information, see [Enhanced
    /// infrastructure
    /// metrics](https://docs.aws.amazon.com/compute-optimizer/latest/ug/enhanced-infrastructure-metrics.html) in the *Compute Optimizer User
    /// Guide*.
    enhanced_infrastructure_metrics: ?EnhancedInfrastructureMetrics = null,

    /// An object that describes the external metrics recommendation preference.
    ///
    /// If the preference is applied in the latest recommendation refresh, an object
    /// with a
    /// valid `source` value appears in the response. If the preference isn't
    /// applied
    /// to the recommendations already, then this object doesn't appear in the
    /// response.
    external_metrics_preference: ?ExternalMetricsPreference = null,

    /// The status of the inferred workload types recommendation preference.
    ///
    /// When the recommendations page is refreshed, a status of `Active` confirms
    /// that the preference is applied to the recommendations, and a status of
    /// `Inactive` confirms that the preference isn't yet applied to
    /// recommendations.
    inferred_workload_types: ?InferredWorkloadTypesPreference = null,

    /// The preference to control the number of days the utilization metrics of the
    /// Amazon Web Services resource are analyzed.
    /// If the preference isn’t set, this object is null.
    look_back_period: ?LookBackPeriodPreference = null,

    /// The preference to control which resource type values are considered when
    /// generating rightsizing recommendations.
    /// This object resolves any wildcard expressions and returns the effective list
    /// of candidate resource type values.
    /// If the preference isn’t set, this object is null.
    preferred_resources: ?[]const EffectivePreferredResource = null,

    /// The target resource type of the recommendation preference to create.
    ///
    /// The `Ec2Instance` option encompasses standalone instances and instances
    /// that are part of Auto Scaling groups. The `AutoScalingGroup` option
    /// encompasses only instances that are part of an Auto Scaling group.
    resource_type: ?ResourceType = null,

    /// Describes the savings estimation mode used for calculating savings
    /// opportunity.
    ///
    /// Only the account manager or delegated administrator of your organization can
    /// activate this preference.
    savings_estimation_mode: ?SavingsEstimationMode = null,

    /// An object that describes the scope of the recommendation preference.
    ///
    /// Recommendation preferences can be created at the organization level (for
    /// management
    /// accounts of an organization only), account level, and resource level. For
    /// more
    /// information, see [Activating
    /// enhanced infrastructure
    /// metrics](https://docs.aws.amazon.com/compute-optimizer/latest/ug/enhanced-infrastructure-metrics.html) in the *Compute Optimizer User
    /// Guide*.
    scope: ?Scope = null,

    /// The preference to control the resource’s CPU utilization threshold, CPU
    /// utilization headroom, and memory utilization headroom.
    /// If the preference isn’t set, this object is null.
    ///
    /// This preference is only available for the Amazon EC2 instance resource type.
    utilization_preferences: ?[]const UtilizationPreference = null,

    pub const json_field_names = .{
        .enhanced_infrastructure_metrics = "enhancedInfrastructureMetrics",
        .external_metrics_preference = "externalMetricsPreference",
        .inferred_workload_types = "inferredWorkloadTypes",
        .look_back_period = "lookBackPeriod",
        .preferred_resources = "preferredResources",
        .resource_type = "resourceType",
        .savings_estimation_mode = "savingsEstimationMode",
        .scope = "scope",
        .utilization_preferences = "utilizationPreferences",
    };
};

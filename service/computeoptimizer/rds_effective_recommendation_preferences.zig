const CpuVendorArchitecture = @import("cpu_vendor_architecture.zig").CpuVendorArchitecture;
const EnhancedInfrastructureMetrics = @import("enhanced_infrastructure_metrics.zig").EnhancedInfrastructureMetrics;
const LookBackPeriodPreference = @import("look_back_period_preference.zig").LookBackPeriodPreference;
const RDSSavingsEstimationMode = @import("rds_savings_estimation_mode.zig").RDSSavingsEstimationMode;

/// Describes the effective recommendation preferences for Amazon Aurora and RDS
/// databases.
pub const RDSEffectiveRecommendationPreferences = struct {
    /// Describes the CPU vendor and architecture for DB instance recommendations.
    cpu_vendor_architectures: ?[]const CpuVendorArchitecture = null,

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
    enhanced_infrastructure_metrics: ?EnhancedInfrastructureMetrics = null,

    /// The number of days the utilization metrics of the DB instance are analyzed.
    look_back_period: ?LookBackPeriodPreference = null,

    /// Describes the savings estimation mode preference applied for calculating
    /// savings opportunity for DB instances.
    savings_estimation_mode: ?RDSSavingsEstimationMode = null,

    pub const json_field_names = .{
        .cpu_vendor_architectures = "cpuVendorArchitectures",
        .enhanced_infrastructure_metrics = "enhancedInfrastructureMetrics",
        .look_back_period = "lookBackPeriod",
        .savings_estimation_mode = "savingsEstimationMode",
    };
};

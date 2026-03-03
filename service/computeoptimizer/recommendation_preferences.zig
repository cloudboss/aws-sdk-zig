const CpuVendorArchitecture = @import("cpu_vendor_architecture.zig").CpuVendorArchitecture;

/// Describes the recommendation preferences to return in the response of a
/// GetAutoScalingGroupRecommendations, GetEC2InstanceRecommendations,
/// GetEC2RecommendationProjectedMetrics, GetRDSDatabaseRecommendations, and
/// GetRDSDatabaseRecommendationProjectedMetrics request.
pub const RecommendationPreferences = struct {
    /// Specifies the CPU vendor and architecture for Amazon EC2 instance and Amazon
    /// EC2 Auto Scaling group recommendations.
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
    cpu_vendor_architectures: ?[]const CpuVendorArchitecture = null,

    pub const json_field_names = .{
        .cpu_vendor_architectures = "cpuVendorArchitectures",
    };
};

const ServiceInsightHealth = @import("service_insight_health.zig").ServiceInsightHealth;
const ServiceName = @import("service_name.zig").ServiceName;

/// Represents the health of an Amazon Web Services service.
pub const ServiceHealth = struct {
    /// Number of resources that DevOps Guru is monitoring in an analyzed Amazon Web
    /// Services service.
    analyzed_resource_count: ?i64,

    /// Represents the health of an Amazon Web Services service. This is a
    /// `ServiceInsightHealth`
    /// that contains the number of open proactive and reactive insights for this
    /// service.
    insight: ?ServiceInsightHealth,

    /// The name of the Amazon Web Services service.
    service_name: ?ServiceName,

    pub const json_field_names = .{
        .analyzed_resource_count = "AnalyzedResourceCount",
        .insight = "Insight",
        .service_name = "ServiceName",
    };
};

const UsageMetricBasis = @import("usage_metric_basis.zig").UsageMetricBasis;
const ReservedInstanceOptions = @import("reserved_instance_options.zig").ReservedInstanceOptions;
const Tenancy = @import("tenancy.zig").Tenancy;

/// Indicates that the exported data must include EC2 instance type matches for
/// on-premises servers
/// that are discovered through Amazon Web Services Application Discovery
/// Service.
pub const Ec2RecommendationsExportPreferences = struct {
    /// The recommended EC2 instance type that matches the CPU usage metric of
    /// server performance data.
    cpu_performance_metric_basis: ?UsageMetricBasis = null,

    /// If set to true, the export
    /// [preferences](https://docs.aws.amazon.com/application-discovery/latest/APIReference/API_StartExportTask.html#API_StartExportTask_RequestSyntax)
    /// is set to `Ec2RecommendationsExportPreferences`.
    enabled: bool = false,

    /// An array of instance types to exclude from recommendations.
    excluded_instance_types: ?[]const []const u8 = null,

    /// The target Amazon Web Services Region for the recommendations.
    /// You can use any of the Region codes available for the chosen service,
    /// as listed in [Amazon Web Services service
    /// endpoints](https://docs.aws.amazon.com/general/latest/gr/rande.html) in the
    /// *Amazon Web Services General Reference*.
    preferred_region: ?[]const u8 = null,

    /// The recommended EC2 instance type that matches the Memory usage metric of
    /// server performance data.
    ram_performance_metric_basis: ?UsageMetricBasis = null,

    /// The contract type for a reserved instance.
    /// If blank, we assume an On-Demand instance is preferred.
    reserved_instance_options: ?ReservedInstanceOptions = null,

    /// The target tenancy to use for your recommended EC2 instances.
    tenancy: ?Tenancy = null,

    pub const json_field_names = .{
        .cpu_performance_metric_basis = "cpuPerformanceMetricBasis",
        .enabled = "enabled",
        .excluded_instance_types = "excludedInstanceTypes",
        .preferred_region = "preferredRegion",
        .ram_performance_metric_basis = "ramPerformanceMetricBasis",
        .reserved_instance_options = "reservedInstanceOptions",
        .tenancy = "tenancy",
    };
};

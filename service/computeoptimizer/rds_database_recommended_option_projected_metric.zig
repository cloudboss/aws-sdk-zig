const RDSDatabaseProjectedMetric = @import("rds_database_projected_metric.zig").RDSDatabaseProjectedMetric;

/// Describes the projected metrics of an Amazon Aurora and RDS database
/// recommendation option.
///
/// To determine the performance difference between your current Amazon Aurora
/// and RDS database and the recommended option, compare
/// the metric data of your service against its projected metric data.
pub const RDSDatabaseRecommendedOptionProjectedMetric = struct {
    /// An array of objects that describe the projected metric.
    projected_metrics: ?[]const RDSDatabaseProjectedMetric = null,

    /// The rank identifier of the Amazon Aurora or RDS DB instance recommendation
    /// option.
    rank: i32 = 0,

    /// The recommended DB instance class for the Amazon Aurora or RDS database.
    recommended_db_instance_class: ?[]const u8 = null,

    pub const json_field_names = .{
        .projected_metrics = "projectedMetrics",
        .rank = "rank",
        .recommended_db_instance_class = "recommendedDBInstanceClass",
    };
};

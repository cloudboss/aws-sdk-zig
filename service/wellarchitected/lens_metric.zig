const aws = @import("aws");

const PillarMetric = @import("pillar_metric.zig").PillarMetric;

/// A metric for a particular lens in a workload.
pub const LensMetric = struct {
    /// The lens ARN.
    lens_arn: ?[]const u8 = null,

    /// The metrics for the pillars in a lens.
    pillars: ?[]const PillarMetric = null,

    risk_counts: ?[]const aws.map.MapEntry(i32) = null,

    pub const json_field_names = .{
        .lens_arn = "LensArn",
        .pillars = "Pillars",
        .risk_counts = "RiskCounts",
    };
};

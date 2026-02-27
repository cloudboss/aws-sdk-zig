const aws = @import("aws");

const SavingsPlansCoverageData = @import("savings_plans_coverage_data.zig").SavingsPlansCoverageData;
const DateInterval = @import("date_interval.zig").DateInterval;

/// The amount of Savings Plans eligible usage that's covered by Savings Plans.
/// All
/// calculations consider the On-Demand equivalent of your Savings Plans usage.
pub const SavingsPlansCoverage = struct {
    /// The attribute that applies to a specific `Dimension`.
    attributes: ?[]const aws.map.StringMapEntry,

    /// The amount of Savings Plans eligible usage that the Savings Plans covered.
    coverage: ?SavingsPlansCoverageData,

    time_period: ?DateInterval,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .coverage = "Coverage",
        .time_period = "TimePeriod",
    };
};

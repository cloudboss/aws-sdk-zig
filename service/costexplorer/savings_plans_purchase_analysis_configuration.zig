const AccountScope = @import("account_scope.zig").AccountScope;
const AnalysisType = @import("analysis_type.zig").AnalysisType;
const DateInterval = @import("date_interval.zig").DateInterval;
const SavingsPlans = @import("savings_plans.zig").SavingsPlans;

/// The configuration for the Savings Plans purchase analysis.
pub const SavingsPlansPurchaseAnalysisConfiguration = struct {
    /// The account that the analysis is for.
    account_id: ?[]const u8 = null,

    /// The account scope that you want your analysis for.
    account_scope: ?AccountScope = null,

    /// The type of analysis.
    analysis_type: AnalysisType,

    /// The time period associated with the analysis.
    look_back_time_period: DateInterval,

    /// Specifies the target Savings Plans coverage as a percentage from `10` to
    /// `100`. This field is required when `AnalysisType` is
    /// `TARGET_AVERAGE_COVERAGE`. It defines the target average hourly coverage
    /// that the recommended Savings Plans commitment should achieve over the
    /// lookback
    /// period.
    savings_plans_target_coverage: ?i32 = null,

    /// Savings Plans to include in the analysis.
    savings_plans_to_add: []const SavingsPlans,

    /// Savings Plans to exclude from the analysis.
    savings_plans_to_exclude: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .account_scope = "AccountScope",
        .analysis_type = "AnalysisType",
        .look_back_time_period = "LookBackTimePeriod",
        .savings_plans_target_coverage = "SavingsPlansTargetCoverage",
        .savings_plans_to_add = "SavingsPlansToAdd",
        .savings_plans_to_exclude = "SavingsPlansToExclude",
    };
};

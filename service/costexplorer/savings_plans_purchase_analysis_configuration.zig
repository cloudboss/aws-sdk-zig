const AccountScope = @import("account_scope.zig").AccountScope;
const AnalysisType = @import("analysis_type.zig").AnalysisType;
const DateInterval = @import("date_interval.zig").DateInterval;
const SavingsPlans = @import("savings_plans.zig").SavingsPlans;

/// The configuration for the Savings Plans purchase analysis.
pub const SavingsPlansPurchaseAnalysisConfiguration = struct {
    /// The account that the analysis is for.
    account_id: ?[]const u8,

    /// The account scope that you want your analysis for.
    account_scope: ?AccountScope,

    /// The type of analysis.
    analysis_type: AnalysisType,

    /// The time period associated with the analysis.
    look_back_time_period: DateInterval,

    /// Savings Plans to include in the analysis.
    savings_plans_to_add: []const SavingsPlans,

    /// Savings Plans to exclude from the analysis.
    savings_plans_to_exclude: ?[]const []const u8,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .account_scope = "AccountScope",
        .analysis_type = "AnalysisType",
        .look_back_time_period = "LookBackTimePeriod",
        .savings_plans_to_add = "SavingsPlansToAdd",
        .savings_plans_to_exclude = "SavingsPlansToExclude",
    };
};

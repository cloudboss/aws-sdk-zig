const SavingsPlansPurchaseAnalysisConfiguration = @import("savings_plans_purchase_analysis_configuration.zig").SavingsPlansPurchaseAnalysisConfiguration;

/// The configuration for the commitment purchase analysis.
pub const CommitmentPurchaseAnalysisConfiguration = struct {
    /// The configuration for the Savings Plans purchase analysis.
    savings_plans_purchase_analysis_configuration: ?SavingsPlansPurchaseAnalysisConfiguration,

    pub const json_field_names = .{
        .savings_plans_purchase_analysis_configuration = "SavingsPlansPurchaseAnalysisConfiguration",
    };
};

const SavingsPlansPurchaseAnalysisDetails = @import("savings_plans_purchase_analysis_details.zig").SavingsPlansPurchaseAnalysisDetails;

/// Details about the analysis.
pub const AnalysisDetails = struct {
    /// Details about the Savings Plans purchase analysis.
    savings_plans_purchase_analysis_details: ?SavingsPlansPurchaseAnalysisDetails,

    pub const json_field_names = .{
        .savings_plans_purchase_analysis_details = "SavingsPlansPurchaseAnalysisDetails",
    };
};

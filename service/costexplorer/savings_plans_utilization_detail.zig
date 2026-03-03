const aws = @import("aws");

const SavingsPlansAmortizedCommitment = @import("savings_plans_amortized_commitment.zig").SavingsPlansAmortizedCommitment;
const SavingsPlansSavings = @import("savings_plans_savings.zig").SavingsPlansSavings;
const SavingsPlansUtilization = @import("savings_plans_utilization.zig").SavingsPlansUtilization;

/// A single daily or monthly Savings Plans utilization rate and details for
/// your account.
/// A management account in an organization have access to member accounts. You
/// can use
/// `GetDimensionValues` to determine the possible dimension values.
pub const SavingsPlansUtilizationDetail = struct {
    /// The total amortized commitment for a Savings Plans. Includes the sum of the
    /// upfront
    /// and recurring Savings Plans fees.
    amortized_commitment: ?SavingsPlansAmortizedCommitment = null,

    /// The attribute that applies to a specific `Dimension`.
    attributes: ?[]const aws.map.StringMapEntry = null,

    /// The amount saved by using existing Savings Plans. Savings returns both net
    /// savings
    /// from savings plans and also the `onDemandCostEquivalent` of the Savings
    /// Plans
    /// when considering the utilization rate.
    savings: ?SavingsPlansSavings = null,

    /// The unique Amazon Resource Name (ARN) for a particular Savings Plan.
    savings_plan_arn: ?[]const u8 = null,

    /// A ratio of your effectiveness of using existing Savings Plans to apply to
    /// workloads
    /// that are Savings Plans eligible.
    utilization: ?SavingsPlansUtilization = null,

    pub const json_field_names = .{
        .amortized_commitment = "AmortizedCommitment",
        .attributes = "Attributes",
        .savings = "Savings",
        .savings_plan_arn = "SavingsPlanArn",
        .utilization = "Utilization",
    };
};

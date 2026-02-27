const PaymentOption = @import("payment_option.zig").PaymentOption;
const SupportedSavingsPlansType = @import("supported_savings_plans_type.zig").SupportedSavingsPlansType;
const TermInYears = @import("term_in_years.zig").TermInYears;

/// The Savings Plans commitment details.
pub const SavingsPlans = struct {
    /// The instance family of the Savings Plans commitment.
    instance_family: ?[]const u8,

    /// The unique ID that's used to distinguish Savings Plans commitments from one
    /// another.
    offering_id: ?[]const u8,

    /// The payment option for the Savings Plans commitment.
    payment_option: ?PaymentOption,

    /// The Region associated with the Savings Plans commitment.
    region: ?[]const u8,

    /// The Savings Plans commitment.
    savings_plans_commitment: ?f64,

    /// The Savings Plans type.
    savings_plans_type: ?SupportedSavingsPlansType,

    /// The term that you want the Savings Plans commitment for.
    term_in_years: ?TermInYears,

    pub const json_field_names = .{
        .instance_family = "InstanceFamily",
        .offering_id = "OfferingId",
        .payment_option = "PaymentOption",
        .region = "Region",
        .savings_plans_commitment = "SavingsPlansCommitment",
        .savings_plans_type = "SavingsPlansType",
        .term_in_years = "TermInYears",
    };
};

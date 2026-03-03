const PaymentOption = @import("payment_option.zig").PaymentOption;
const Term = @import("term.zig").Term;

/// The preferred configuration for Reserved Instances and Savings Plans
/// commitment-based discounts, consisting of a payment option and a commitment
/// duration.
pub const PreferredCommitment = struct {
    /// The preferred upfront payment structure for commitments. If the value is
    /// null, it will default to `AllUpfront` (highest savings) where applicable.
    payment_option: ?PaymentOption = null,

    /// The preferred length of the commitment period. If the value is null, it will
    /// default to `ThreeYears` (highest savings) where applicable.
    term: ?Term = null,

    pub const json_field_names = .{
        .payment_option = "paymentOption",
        .term = "term",
    };
};

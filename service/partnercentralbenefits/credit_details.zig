const MonetaryValue = @import("monetary_value.zig").MonetaryValue;
const CreditCode = @import("credit_code.zig").CreditCode;

/// Contains information about credit-based benefit fulfillment, including AWS
/// promotional credits.
pub const CreditDetails = struct {
    /// The total amount of credits that have been allocated for this benefit.
    allocated_amount: MonetaryValue,

    /// A list of credit codes that have been generated for this benefit allocation.
    codes: []const CreditCode,

    /// The amount of credits that have actually been issued and are available for
    /// use.
    issued_amount: MonetaryValue,

    pub const json_field_names = .{
        .allocated_amount = "AllocatedAmount",
        .codes = "Codes",
        .issued_amount = "IssuedAmount",
    };
};

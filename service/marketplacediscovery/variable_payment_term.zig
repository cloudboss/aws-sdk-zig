const TermType = @import("term_type.zig").TermType;

/// Defines a variable payment term with a maximum total charge amount.
pub const VariablePaymentTerm = struct {
    /// Defines the currency for the prices in this term.
    currency_code: []const u8,

    /// The unique identifier of the term.
    id: []const u8,

    /// The maximum total amount that can be charged under this term.
    max_total_charge_amount: []const u8,

    /// The category of the term.
    type: TermType,

    pub const json_field_names = .{
        .currency_code = "currencyCode",
        .id = "id",
        .max_total_charge_amount = "maxTotalChargeAmount",
        .type = "type",
    };
};

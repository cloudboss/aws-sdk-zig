const VariablePaymentTermConfiguration = @import("variable_payment_term_configuration.zig").VariablePaymentTermConfiguration;

/// Defines a payment model where sellers can submit variable payment requests
/// up to a maximum charge amount, with configurable approval strategies and
/// expiration timelines.
pub const VariablePaymentTerm = struct {
    /// Additional parameters specified by the acceptor while accepting the term.
    configuration: ?VariablePaymentTermConfiguration,

    /// Defines the currency for the prices mentioned in the term.
    currency_code: ?[]const u8,

    /// The maximum total amount that can be charged to the customer through
    /// variable payment requests under this term.
    max_total_charge_amount: ?[]const u8,

    /// Type of the term.
    type: ?[]const u8,

    pub const json_field_names = .{
        .configuration = "configuration",
        .currency_code = "currencyCode",
        .max_total_charge_amount = "maxTotalChargeAmount",
        .type = "type",
    };
};

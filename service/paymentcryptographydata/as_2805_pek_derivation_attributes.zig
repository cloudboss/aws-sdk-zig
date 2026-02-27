/// Parameter information to use a PEK derived using AS2805.
pub const As2805PekDerivationAttributes = struct {
    /// The system trace audit number for the transaction.
    system_trace_audit_number: []const u8,

    /// The transaction amount for the transaction.
    transaction_amount: []const u8,

    pub const json_field_names = .{
        .system_trace_audit_number = "SystemTraceAuditNumber",
        .transaction_amount = "TransactionAmount",
    };
};

/// Parameters that are required for translation between ISO9564 PIN format
/// 0,3,4 translation.
pub const TranslationPinDataIsoFormat034 = struct {
    /// The Primary Account Number (PAN) of the cardholder. A PAN is a unique
    /// identifier for a payment credit or debit card and associates the card to a
    /// specific account holder.
    primary_account_number: []const u8,

    pub const json_field_names = .{
        .primary_account_number = "PrimaryAccountNumber",
    };
};

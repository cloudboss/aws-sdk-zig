/// Parameters to derive session key for Visa payment card for ARQC
/// verification.
pub const SessionKeyVisa = struct {
    /// A number that identifies and differentiates payment cards with the same
    /// Primary Account Number (PAN).
    pan_sequence_number: []const u8,

    /// The Primary Account Number (PAN) of the cardholder. A PAN is a unique
    /// identifier for a payment credit or debit card and associates the card to a
    /// specific account holder.
    primary_account_number: []const u8,

    pub const json_field_names = .{
        .pan_sequence_number = "PanSequenceNumber",
        .primary_account_number = "PrimaryAccountNumber",
    };
};

/// Parameters to derive session key for a UnionPay payment card for
/// Authorization Request Cryptogram (ARQC) generation and verification.
pub const SessionKeyUnionPay = struct {
    /// The transaction counter that the terminal provides during transaction
    /// processing. This value is in hexadecimal format. For example, enter a
    /// decimal counter of 109 as `006D`.
    application_transaction_counter: []const u8,

    /// A number that identifies and differentiates payment cards with the same
    /// Primary Account Number (PAN). If not used, enter `00`.
    pan_sequence_number: []const u8,

    /// The Primary Account Number (PAN) of the cardholder. A PAN is a unique
    /// identifier for a payment credit or debit card and associates the card to a
    /// specific account holder.
    primary_account_number: []const u8,

    pub const json_field_names = .{
        .application_transaction_counter = "ApplicationTransactionCounter",
        .pan_sequence_number = "PanSequenceNumber",
        .primary_account_number = "PrimaryAccountNumber",
    };
};

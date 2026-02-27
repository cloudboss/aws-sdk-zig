/// Parameters that are required to generate or verify Dynamic Card Verification
/// Value (dCVV).
pub const DynamicCardVerificationValue = struct {
    /// The transaction counter value that comes from the terminal.
    application_transaction_counter: []const u8,

    /// The expiry date of a payment card.
    card_expiry_date: []const u8,

    /// A number that identifies and differentiates payment cards with the same
    /// Primary Account Number (PAN).
    pan_sequence_number: []const u8,

    /// The service code of the payment card. This is different from Card Security
    /// Code (CSC).
    service_code: []const u8,

    pub const json_field_names = .{
        .application_transaction_counter = "ApplicationTransactionCounter",
        .card_expiry_date = "CardExpiryDate",
        .pan_sequence_number = "PanSequenceNumber",
        .service_code = "ServiceCode",
    };
};

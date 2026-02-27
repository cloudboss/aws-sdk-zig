/// Card data parameters that are required to verify CVV (Card Verification
/// Value) for the payment card.
pub const CardVerificationValue1 = struct {
    /// The expiry date of a payment card.
    card_expiry_date: []const u8,

    /// The service code of the payment card. This is different from Card Security
    /// Code (CSC).
    service_code: []const u8,

    pub const json_field_names = .{
        .card_expiry_date = "CardExpiryDate",
        .service_code = "ServiceCode",
    };
};

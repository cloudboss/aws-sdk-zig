/// Card data parameters that are required to verify Card Verification Value
/// (CVV2) for the payment card.
pub const CardVerificationValue2 = struct {
    /// The expiry date of a payment card.
    card_expiry_date: []const u8,

    pub const json_field_names = .{
        .card_expiry_date = "CardExpiryDate",
    };
};

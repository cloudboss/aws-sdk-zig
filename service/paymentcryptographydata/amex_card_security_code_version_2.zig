/// Card data parameters that are required to generate a Card Security Code
/// (CSC2) for an AMEX payment card.
pub const AmexCardSecurityCodeVersion2 = struct {
    /// The expiry date of a payment card.
    card_expiry_date: []const u8,

    /// The service code of the AMEX payment card. This is different from the Card
    /// Security Code (CSC).
    service_code: []const u8,

    pub const json_field_names = .{
        .card_expiry_date = "CardExpiryDate",
        .service_code = "ServiceCode",
    };
};

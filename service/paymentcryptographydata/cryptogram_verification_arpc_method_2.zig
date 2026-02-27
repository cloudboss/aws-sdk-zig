/// Parameters that are required for ARPC response generation using method2
/// after ARQC verification is successful.
pub const CryptogramVerificationArpcMethod2 = struct {
    /// The data indicating whether the issuer approves or declines an online
    /// transaction using an EMV chip card.
    card_status_update: []const u8,

    /// The proprietary authentication data used by issuer for communication during
    /// online transaction using an EMV chip card.
    proprietary_authentication_data: ?[]const u8,

    pub const json_field_names = .{
        .card_status_update = "CardStatusUpdate",
        .proprietary_authentication_data = "ProprietaryAuthenticationData",
    };
};

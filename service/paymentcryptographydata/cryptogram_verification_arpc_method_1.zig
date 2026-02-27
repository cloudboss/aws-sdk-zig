/// Parameters that are required for ARPC response generation using method1
/// after ARQC verification is successful.
pub const CryptogramVerificationArpcMethod1 = struct {
    /// The auth code used to calculate APRC after ARQC verification is successful.
    /// This is the same auth code used for ARQC generation outside of Amazon Web
    /// Services Payment Cryptography.
    auth_response_code: []const u8,

    pub const json_field_names = .{
        .auth_response_code = "AuthResponseCode",
    };
};

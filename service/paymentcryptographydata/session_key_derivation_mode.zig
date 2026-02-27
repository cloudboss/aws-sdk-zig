pub const SessionKeyDerivationMode = enum {
    emv_common_session_key,
    emv2000,
    amex,
    mastercard_session_key,
    visa,

    pub const json_field_names = .{
        .emv_common_session_key = "EMV_COMMON_SESSION_KEY",
        .emv2000 = "EMV2000",
        .amex = "AMEX",
        .mastercard_session_key = "MASTERCARD_SESSION_KEY",
        .visa = "VISA",
    };
};

const SessionKeyAmex = @import("session_key_amex.zig").SessionKeyAmex;
const SessionKeyEmv2000 = @import("session_key_emv_2000.zig").SessionKeyEmv2000;
const SessionKeyEmvCommon = @import("session_key_emv_common.zig").SessionKeyEmvCommon;
const SessionKeyMastercard = @import("session_key_mastercard.zig").SessionKeyMastercard;
const SessionKeyVisa = @import("session_key_visa.zig").SessionKeyVisa;

/// Parameters to derive a session key for Authorization Response Cryptogram
/// (ARQC) verification.
pub const SessionKeyDerivation = union(enum) {
    /// Parameters to derive session key for an Amex payment card for ARQC
    /// verification.
    amex: ?SessionKeyAmex,
    /// Parameters to derive session key for an Emv2000 payment card for ARQC
    /// verification.
    emv_2000: ?SessionKeyEmv2000,
    /// Parameters to derive session key for an Emv common payment card for ARQC
    /// verification.
    emv_common: ?SessionKeyEmvCommon,
    /// Parameters to derive session key for a Mastercard payment card for ARQC
    /// verification.
    mastercard: ?SessionKeyMastercard,
    /// Parameters to derive session key for a Visa payment cardfor ARQC
    /// verification.
    visa: ?SessionKeyVisa,

    pub const json_field_names = .{
        .amex = "Amex",
        .emv_2000 = "Emv2000",
        .emv_common = "EmvCommon",
        .mastercard = "Mastercard",
        .visa = "Visa",
    };
};

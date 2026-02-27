const AmexCardSecurityCodeVersion1 = @import("amex_card_security_code_version_1.zig").AmexCardSecurityCodeVersion1;
const AmexCardSecurityCodeVersion2 = @import("amex_card_security_code_version_2.zig").AmexCardSecurityCodeVersion2;
const CardHolderVerificationValue = @import("card_holder_verification_value.zig").CardHolderVerificationValue;
const CardVerificationValue1 = @import("card_verification_value_1.zig").CardVerificationValue1;
const CardVerificationValue2 = @import("card_verification_value_2.zig").CardVerificationValue2;
const DiscoverDynamicCardVerificationCode = @import("discover_dynamic_card_verification_code.zig").DiscoverDynamicCardVerificationCode;
const DynamicCardVerificationCode = @import("dynamic_card_verification_code.zig").DynamicCardVerificationCode;
const DynamicCardVerificationValue = @import("dynamic_card_verification_value.zig").DynamicCardVerificationValue;

/// Card data parameters that are requried to verify Card Verification Values
/// (CVV/CVV2), Dynamic Card Verification Values (dCVV/dCVV2), or Card Security
/// Codes (CSC).
pub const CardVerificationAttributes = union(enum) {
    amex_card_security_code_version_1: ?AmexCardSecurityCodeVersion1,
    /// Card data parameters that are required to verify a Card Security Code (CSC2)
    /// for an AMEX payment card.
    amex_card_security_code_version_2: ?AmexCardSecurityCodeVersion2,
    /// Card data parameters that are required to verify a cardholder verification
    /// value for the payment card.
    card_holder_verification_value: ?CardHolderVerificationValue,
    /// Card data parameters that are required to verify Card Verification Value
    /// (CVV) for the payment card.
    card_verification_value_1: ?CardVerificationValue1,
    /// Card data parameters that are required to verify Card Verification Value
    /// (CVV2) for the payment card.
    card_verification_value_2: ?CardVerificationValue2,
    /// Card data parameters that are required to verify CDynamic Card Verification
    /// Code (dCVC) for the payment card.
    discover_dynamic_card_verification_code: ?DiscoverDynamicCardVerificationCode,
    /// Card data parameters that are required to verify CDynamic Card Verification
    /// Code (dCVC) for the payment card.
    dynamic_card_verification_code: ?DynamicCardVerificationCode,
    /// Card data parameters that are required to verify CDynamic Card Verification
    /// Value (dCVV) for the payment card.
    dynamic_card_verification_value: ?DynamicCardVerificationValue,

    pub const json_field_names = .{
        .amex_card_security_code_version_1 = "AmexCardSecurityCodeVersion1",
        .amex_card_security_code_version_2 = "AmexCardSecurityCodeVersion2",
        .card_holder_verification_value = "CardHolderVerificationValue",
        .card_verification_value_1 = "CardVerificationValue1",
        .card_verification_value_2 = "CardVerificationValue2",
        .discover_dynamic_card_verification_code = "DiscoverDynamicCardVerificationCode",
        .dynamic_card_verification_code = "DynamicCardVerificationCode",
        .dynamic_card_verification_value = "DynamicCardVerificationValue",
    };
};

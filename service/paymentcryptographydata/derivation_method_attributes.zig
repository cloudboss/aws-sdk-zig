const AmexAttributes = @import("amex_attributes.zig").AmexAttributes;
const Emv2000Attributes = @import("emv_2000_attributes.zig").Emv2000Attributes;
const EmvCommonAttributes = @import("emv_common_attributes.zig").EmvCommonAttributes;
const MasterCardAttributes = @import("master_card_attributes.zig").MasterCardAttributes;
const VisaAttributes = @import("visa_attributes.zig").VisaAttributes;

/// Parameters to derive the payment card specific confidentiality and integrity
/// keys.
pub const DerivationMethodAttributes = union(enum) {
    /// Parameters to derive the confidentiality and integrity keys for a payment
    /// card using Amex derivation method.
    amex: ?AmexAttributes,
    /// Parameters to derive the confidentiality and integrity keys for a payment
    /// card using Emv2000 derivation method.
    emv_2000: ?Emv2000Attributes,
    /// Parameters to derive the confidentiality and integrity keys for a payment
    /// card using Emv common derivation method.
    emv_common: ?EmvCommonAttributes,
    /// Parameters to derive the confidentiality and integrity keys for a payment
    /// card using Mastercard derivation method.
    mastercard: ?MasterCardAttributes,
    /// Parameters to derive the confidentiality and integrity keys for a a payment
    /// card using Visa derivation method.
    visa: ?VisaAttributes,

    pub const json_field_names = .{
        .amex = "Amex",
        .emv_2000 = "Emv2000",
        .emv_common = "EmvCommon",
        .mastercard = "Mastercard",
        .visa = "Visa",
    };
};

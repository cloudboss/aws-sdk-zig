const Ibm3624NaturalPin = @import("ibm_3624_natural_pin.zig").Ibm3624NaturalPin;
const Ibm3624PinFromOffset = @import("ibm_3624_pin_from_offset.zig").Ibm3624PinFromOffset;
const Ibm3624PinOffset = @import("ibm_3624_pin_offset.zig").Ibm3624PinOffset;
const Ibm3624RandomPin = @import("ibm_3624_random_pin.zig").Ibm3624RandomPin;
const VisaPin = @import("visa_pin.zig").VisaPin;
const VisaPinVerificationValue = @import("visa_pin_verification_value.zig").VisaPinVerificationValue;

/// Parameters that are required for PIN data generation.
pub const PinGenerationAttributes = union(enum) {
    /// Parameters that are required to generate or verify Ibm3624 natural PIN.
    ibm_3624_natural_pin: ?Ibm3624NaturalPin,
    /// Parameters that are required to generate or verify Ibm3624 PIN from offset
    /// PIN.
    ibm_3624_pin_from_offset: ?Ibm3624PinFromOffset,
    /// Parameters that are required to generate or verify Ibm3624 PIN offset PIN.
    ibm_3624_pin_offset: ?Ibm3624PinOffset,
    /// Parameters that are required to generate or verify Ibm3624 random PIN.
    ibm_3624_random_pin: ?Ibm3624RandomPin,
    /// Parameters that are required to generate or verify Visa PIN.
    visa_pin: ?VisaPin,
    /// Parameters that are required to generate or verify Visa PIN Verification
    /// Value (PVV).
    visa_pin_verification_value: ?VisaPinVerificationValue,

    pub const json_field_names = .{
        .ibm_3624_natural_pin = "Ibm3624NaturalPin",
        .ibm_3624_pin_from_offset = "Ibm3624PinFromOffset",
        .ibm_3624_pin_offset = "Ibm3624PinOffset",
        .ibm_3624_random_pin = "Ibm3624RandomPin",
        .visa_pin = "VisaPin",
        .visa_pin_verification_value = "VisaPinVerificationValue",
    };
};

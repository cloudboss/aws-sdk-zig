const Ibm3624PinVerification = @import("ibm_3624_pin_verification.zig").Ibm3624PinVerification;
const VisaPinVerification = @import("visa_pin_verification.zig").VisaPinVerification;

/// Parameters that are required for PIN data verification.
pub const PinVerificationAttributes = union(enum) {
    /// Parameters that are required to generate or verify Ibm3624 PIN.
    ibm_3624_pin: ?Ibm3624PinVerification,
    /// Parameters that are required to generate or verify Visa PIN.
    visa_pin: ?VisaPinVerification,

    pub const json_field_names = .{
        .ibm_3624_pin = "Ibm3624Pin",
        .visa_pin = "VisaPin",
    };
};

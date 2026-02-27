/// Pparameters that are required to generate or verify Ibm3624 PIN offset PIN.
pub const Ibm3624PinOffset = struct {
    /// The decimalization table to use for IBM 3624 PIN algorithm. The table is
    /// used to convert the algorithm intermediate result from hexadecimal
    /// characters to decimal.
    decimalization_table: []const u8,

    /// The encrypted PIN block data. According to ISO 9564 standard, a PIN Block is
    /// an encoded representation of a payment card Personal Account Number (PAN)
    /// and the cardholder Personal Identification Number (PIN).
    encrypted_pin_block: []const u8,

    /// The unique data for cardholder identification.
    pin_validation_data: []const u8,

    /// The padding character for validation data.
    pin_validation_data_pad_character: []const u8,

    pub const json_field_names = .{
        .decimalization_table = "DecimalizationTable",
        .encrypted_pin_block = "EncryptedPinBlock",
        .pin_validation_data = "PinValidationData",
        .pin_validation_data_pad_character = "PinValidationDataPadCharacter",
    };
};

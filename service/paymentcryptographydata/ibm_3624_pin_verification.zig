/// Parameters that are required to generate or verify Ibm3624 PIN verification
/// PIN.
pub const Ibm3624PinVerification = struct {
    /// The decimalization table to use for IBM 3624 PIN algorithm. The table is
    /// used to convert the algorithm intermediate result from hexadecimal
    /// characters to decimal.
    decimalization_table: []const u8,

    /// The PIN offset value.
    pin_offset: []const u8,

    /// The unique data for cardholder identification.
    pin_validation_data: []const u8,

    /// The padding character for validation data.
    pin_validation_data_pad_character: []const u8,

    pub const json_field_names = .{
        .decimalization_table = "DecimalizationTable",
        .pin_offset = "PinOffset",
        .pin_validation_data = "PinValidationData",
        .pin_validation_data_pad_character = "PinValidationDataPadCharacter",
    };
};

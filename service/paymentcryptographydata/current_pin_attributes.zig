/// The parameter values of the current PIN to be changed on the EMV chip card.
pub const CurrentPinAttributes = struct {
    /// The encrypted pinblock of the current pin stored on the chip card.
    current_encrypted_pin_block: []const u8,

    /// The `keyArn` of the current PIN PEK.
    current_pin_pek_identifier: []const u8,

    pub const json_field_names = .{
        .current_encrypted_pin_block = "CurrentEncryptedPinBlock",
        .current_pin_pek_identifier = "CurrentPinPekIdentifier",
    };
};

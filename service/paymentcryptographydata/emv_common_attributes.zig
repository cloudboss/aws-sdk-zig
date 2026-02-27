const MajorKeyDerivationMode = @import("major_key_derivation_mode.zig").MajorKeyDerivationMode;
const EmvEncryptionMode = @import("emv_encryption_mode.zig").EmvEncryptionMode;
const PinBlockLengthPosition = @import("pin_block_length_position.zig").PinBlockLengthPosition;
const PinBlockPaddingType = @import("pin_block_padding_type.zig").PinBlockPaddingType;

/// Parameters to derive the confidentiality and integrity keys for an Emv
/// common payment card.
pub const EmvCommonAttributes = struct {
    /// The application cryptogram for the current transaction that is provided by
    /// the terminal during transaction processing.
    application_cryptogram: []const u8,

    /// The method to use when deriving the master key for the payment card.
    major_key_derivation_mode: MajorKeyDerivationMode,

    /// The block cipher method to use for encryption.
    mode: EmvEncryptionMode,

    /// A number that identifies and differentiates payment cards with the same
    /// Primary Account Number (PAN). Typically 00 is used, if no value is provided
    /// by the terminal.
    pan_sequence_number: []const u8,

    /// Specifies if PIN block length should be added to front of the pin block.
    ///
    /// If value is set to `FRONT_OF_PIN_BLOCK`, then PIN block padding type should
    /// be `ISO_IEC_7816_4`.
    pin_block_length_position: PinBlockLengthPosition,

    /// The padding to be added to the PIN block prior to encryption.
    ///
    /// Padding type should be `ISO_IEC_7816_4`, if `PinBlockLengthPosition` is set
    /// to `FRONT_OF_PIN_BLOCK`. No padding is required, if `PinBlockLengthPosition`
    /// is set to `NONE`.
    pin_block_padding_type: PinBlockPaddingType,

    /// The Primary Account Number (PAN) of the cardholder.
    primary_account_number: []const u8,

    pub const json_field_names = .{
        .application_cryptogram = "ApplicationCryptogram",
        .major_key_derivation_mode = "MajorKeyDerivationMode",
        .mode = "Mode",
        .pan_sequence_number = "PanSequenceNumber",
        .pin_block_length_position = "PinBlockLengthPosition",
        .pin_block_padding_type = "PinBlockPaddingType",
        .primary_account_number = "PrimaryAccountNumber",
    };
};

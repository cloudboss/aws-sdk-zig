const EmvMajorKeyDerivationMode = @import("emv_major_key_derivation_mode.zig").EmvMajorKeyDerivationMode;
const EmvEncryptionMode = @import("emv_encryption_mode.zig").EmvEncryptionMode;

/// Parameters for plaintext encryption using EMV keys.
pub const EmvEncryptionAttributes = struct {
    /// An input used to provide the intial state. If no value is provided, Amazon
    /// Web Services Payment Cryptography defaults it to zero.
    initialization_vector: ?[]const u8 = null,

    /// The EMV derivation mode to use for ICC master key derivation as per EMV
    /// version 4.3 book 2.
    major_key_derivation_mode: EmvMajorKeyDerivationMode,

    /// The block cipher method to use for encryption.
    mode: ?EmvEncryptionMode = null,

    /// A number that identifies and differentiates payment cards with the same
    /// Primary Account Number (PAN). Typically 00 is used, if no value is provided
    /// by the terminal.
    pan_sequence_number: []const u8,

    /// The Primary Account Number (PAN), a unique identifier for a payment credit
    /// or debit card and associates the card to a specific account holder.
    primary_account_number: []const u8,

    /// The derivation value used to derive the ICC session key. It is typically the
    /// application transaction counter value padded with zeros or previous ARQC
    /// value padded with zeros as per EMV version 4.3 book 2.
    session_derivation_data: []const u8,

    pub const json_field_names = .{
        .initialization_vector = "InitializationVector",
        .major_key_derivation_mode = "MajorKeyDerivationMode",
        .mode = "Mode",
        .pan_sequence_number = "PanSequenceNumber",
        .primary_account_number = "PrimaryAccountNumber",
        .session_derivation_data = "SessionDerivationData",
    };
};

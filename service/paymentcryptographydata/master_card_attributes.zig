const MajorKeyDerivationMode = @import("major_key_derivation_mode.zig").MajorKeyDerivationMode;

/// Parameters to derive the confidentiality and integrity keys for a Mastercard
/// payment card.
pub const MasterCardAttributes = struct {
    /// The application cryptogram for the current transaction that is provided by
    /// the terminal during transaction processing.
    application_cryptogram: []const u8,

    /// The method to use when deriving the master key for the payment card.
    major_key_derivation_mode: MajorKeyDerivationMode,

    /// A number that identifies and differentiates payment cards with the same
    /// Primary Account Number (PAN). Typically 00 is used, if no value is provided
    /// by the terminal.
    pan_sequence_number: []const u8,

    /// The Primary Account Number (PAN) of the cardholder.
    primary_account_number: []const u8,

    pub const json_field_names = .{
        .application_cryptogram = "ApplicationCryptogram",
        .major_key_derivation_mode = "MajorKeyDerivationMode",
        .pan_sequence_number = "PanSequenceNumber",
        .primary_account_number = "PrimaryAccountNumber",
    };
};

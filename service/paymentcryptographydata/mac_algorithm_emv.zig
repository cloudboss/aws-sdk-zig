const MajorKeyDerivationMode = @import("major_key_derivation_mode.zig").MajorKeyDerivationMode;
const SessionKeyDerivationMode = @import("session_key_derivation_mode.zig").SessionKeyDerivationMode;
const SessionKeyDerivationValue = @import("session_key_derivation_value.zig").SessionKeyDerivationValue;

/// Parameters that are required for EMV MAC generation and verification.
pub const MacAlgorithmEmv = struct {
    /// The method to use when deriving the master key for EMV MAC generation or
    /// verification.
    major_key_derivation_mode: MajorKeyDerivationMode,

    /// A number that identifies and differentiates payment cards with the same
    /// Primary Account Number (PAN).
    pan_sequence_number: []const u8,

    /// The Primary Account Number (PAN), a unique identifier for a payment credit
    /// or debit card and associates the card to a specific account holder.
    primary_account_number: []const u8,

    /// The method of deriving a session key for EMV MAC generation or verification.
    session_key_derivation_mode: SessionKeyDerivationMode,

    /// Parameters that are required to generate session key for EMV generation and
    /// verification.
    session_key_derivation_value: SessionKeyDerivationValue,

    pub const json_field_names = .{
        .major_key_derivation_mode = "MajorKeyDerivationMode",
        .pan_sequence_number = "PanSequenceNumber",
        .primary_account_number = "PrimaryAccountNumber",
        .session_key_derivation_mode = "SessionKeyDerivationMode",
        .session_key_derivation_value = "SessionKeyDerivationValue",
    };
};

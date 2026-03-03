const CurrentPinAttributes = @import("current_pin_attributes.zig").CurrentPinAttributes;
const MajorKeyDerivationMode = @import("major_key_derivation_mode.zig").MajorKeyDerivationMode;

/// Parameters to derive the confidentiality and integrity keys for a payment
/// card using Amex derivation method.
pub const AmexAttributes = struct {
    /// The transaction counter of the current transaction that is provided by the
    /// terminal during transaction processing.
    application_transaction_counter: []const u8,

    /// The `keyArn` of the issuer master key for cryptogram (IMK-AC) for the
    /// payment card.
    authorization_request_key_identifier: []const u8,

    /// The encrypted pinblock of the old pin stored on the chip card.
    current_pin_attributes: ?CurrentPinAttributes = null,

    /// The method to use when deriving the master key for a payment card using Amex
    /// derivation.
    major_key_derivation_mode: MajorKeyDerivationMode,

    /// A number that identifies and differentiates payment cards with the same
    /// Primary Account Number (PAN). Typically 00 is used, if no value is provided
    /// by the terminal.
    pan_sequence_number: []const u8,

    /// The Primary Account Number (PAN) of the cardholder.
    primary_account_number: []const u8,

    pub const json_field_names = .{
        .application_transaction_counter = "ApplicationTransactionCounter",
        .authorization_request_key_identifier = "AuthorizationRequestKeyIdentifier",
        .current_pin_attributes = "CurrentPinAttributes",
        .major_key_derivation_mode = "MajorKeyDerivationMode",
        .pan_sequence_number = "PanSequenceNumber",
        .primary_account_number = "PrimaryAccountNumber",
    };
};

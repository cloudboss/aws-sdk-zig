/// The input for a crypto X402 payment.
pub const CryptoX402PaymentInput = struct {
    /// The X402 payment payload.
    payload: []const u8,

    /// The maximum on-chain Permit2 allowance to grant before signing the payment
    /// authorization, in the asset's smallest denomination. This field is valid
    /// only for the `upto` (metered) scheme; supplying it for the `exact` scheme
    /// returns a validation error.
    ///
    /// When set, the service approves an ERC-20 allowance for this amount before
    /// processing the payment. The approval sets, rather than adds to, the wallet's
    /// allowance. Set this field only when the wallet needs approving, for example
    /// on its first `upto` payment, to avoid a redundant on-chain transaction. Omit
    /// the field to skip allowance handling. This is the default, and the only
    /// behavior for the `exact` scheme.
    permit_2_allowance_limit: ?[]const u8 = null,

    /// The version of the X402 protocol.
    version: []const u8,

    pub const json_field_names = .{
        .payload = "payload",
        .permit_2_allowance_limit = "permit2AllowanceLimit",
        .version = "version",
    };
};

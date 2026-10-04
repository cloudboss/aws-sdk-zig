const CryptoX402PaymentInput = @import("crypto_x402_payment_input.zig").CryptoX402PaymentInput;
const MppPaymentInput = @import("mpp_payment_input.zig").MppPaymentInput;

/// The payment input details, which vary by payment type.
pub const PaymentInput = union(enum) {
    /// Input for a crypto X402 payment.
    crypto_x402: ?CryptoX402PaymentInput,
    mpp: ?MppPaymentInput,

    pub const json_field_names = .{
        .crypto_x402 = "cryptoX402",
        .mpp = "mpp",
    };
};

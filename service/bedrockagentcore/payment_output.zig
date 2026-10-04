const CryptoX402PaymentOutput = @import("crypto_x402_payment_output.zig").CryptoX402PaymentOutput;
const MppPaymentOutput = @import("mpp_payment_output.zig").MppPaymentOutput;

/// The payment output details, which vary by payment type.
pub const PaymentOutput = union(enum) {
    /// Output from a crypto X402 payment.
    crypto_x402: ?CryptoX402PaymentOutput,
    mpp: ?MppPaymentOutput,

    pub const json_field_names = .{
        .crypto_x402 = "cryptoX402",
        .mpp = "mpp",
    };
};

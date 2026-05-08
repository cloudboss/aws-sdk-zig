const CryptoX402PaymentOutput = @import("crypto_x402_payment_output.zig").CryptoX402PaymentOutput;

/// Payment response payload union. We will support versioning by introducing
/// other model in this union
pub const PaymentOutput = union(enum) {
    crypto_x402: ?CryptoX402PaymentOutput,

    pub const json_field_names = .{
        .crypto_x402 = "cryptoX402",
    };
};

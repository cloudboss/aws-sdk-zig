const CryptoX402PaymentInput = @import("crypto_x402_payment_input.zig").CryptoX402PaymentInput;

/// Payment request details union
pub const PaymentInput = union(enum) {
    crypto_x402: ?CryptoX402PaymentInput,

    pub const json_field_names = .{
        .crypto_x402 = "cryptoX402",
    };
};

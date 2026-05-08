const EmbeddedCryptoWallet = @import("embedded_crypto_wallet.zig").EmbeddedCryptoWallet;

/// Details specific to the instrument type
pub const PaymentInstrumentDetails = union(enum) {
    /// Embedded crypto wallet managed directly by end user
    embedded_crypto_wallet: ?EmbeddedCryptoWallet,

    pub const json_field_names = .{
        .embedded_crypto_wallet = "embeddedCryptoWallet",
    };
};
